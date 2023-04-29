// $Id: $
// File name:   ahb_slave_cdl.sv
// Created:     3/28/2023
// Author:      Hsuanling Lee
// Lab Section: 4
// Version:     1.0  Initial Design Entry
// Description: CDL AHB-Slave - Group 30
module ahb_slave_cdl
(
  input logic clk,
  input logic n_rst,

  input  logic hsel,
  input  logic [3:0] haddr,
  input  logic [1:0] htrans,
  input  logic [1:0] hsize,
  input  logic hwrite,
  input  logic [31:0] hwdata,
  output logic [31:0] hrdata,
  output logic hresp,
  output logic hready,

  input  logic [3:0] rx_packet,
  input  logic rx_data_ready,
  input  logic rx_transfer_active,
  input  logic rx_error,

  output logic dmode,

  input  logic [6:0] buffer_occupancy,
  input  logic [7:0] rx_data,
  output logic get_rx_data,
  output logic store_tx_data,
  output logic [7:0] tx_data,
  output logic clear,
  output logic [3:0] tx_packet,
  input logic tx_transfer_active,
  input logic tx_error
);
  // FOR TX PACKET
  localparam OUT   = 4'b0001; //1
  localparam IN    = 4'b1001; //9
  localparam DATA0 = 4'b0011; //3
  localparam DATA1 = 4'b1011; //11
  localparam ACK   = 4'b0010; //2
  localparam NAK   = 4'b1010; //10
  localparam STALL = 4'b1110; //13

  logic [13:0] [7:0] slavedata, next_slavedata;
  logic [31:0] next_hrdata;
  logic [3:0]  next_haddr;
  logic [3:0] next_address;
  logic [3:0] addr;
  logic next_hwrite;
  logic next_hsize;
  logic read, write;
  logic next_read, next_write;

  typedef enum {DATA_IDLE, READ, DATA_WRITE, BYTE1, BYTE2, BYTE3, BYTE4} stateTYPE;
  stateTYPE data_state, next_data_state;

  typedef enum {IDLE, WRITE, CHECK, CLEAR} state;
  state tx_state, next_state_tx;
  state flush_state, next_state_flush;

//HREADY WHEN NO HRESP
  assign hready = (hresp) ? 1'b0: 1'b1;

//DMODE LOGIC - WHEN RX_HIGH
  always_comb begin : D_MODE
    dmode = 1'b0;
    if (rx_transfer_active) begin
      dmode = 1'b1;
    end
  end

  // FLUSH_BUFFER_CONTROL_REGISTER STATE DIAGRAM
  always_comb begin : FLUSH_BUFFER_CONTROL_REGISTER
      next_state_flush = flush_state;
      case (flush_state)
          IDLE: begin
            if (haddr == 13 && hwrite && hsel && !hresp) begin 
              next_state_flush = WRITE;
            end
          end
          WRITE: begin
            next_state_flush = CHECK;
          end
          CHECK: begin
            if (buffer_occupancy == '0) begin
              next_state_flush = CLEAR;
            end
          end
          CLEAR: begin 
            next_state_flush = IDLE;
          end
      endcase
  end
  // CLEAR OUTPUT FROM FLUSH REGISTER
  // flush = clear
  assign clear = slavedata[13][0];


  // TX PACKET CONTROL REGISTER
  always_comb begin : TX_PACKET_CONTROL_REGISTER
      next_state_tx = tx_state;
      case (tx_state)
          IDLE  : if (hsel && hwrite && !hresp && haddr == 12) next_state_tx = WRITE;
          WRITE : if (tx_transfer_active) next_state_tx = CHECK;
          CHECK: if (!tx_transfer_active) next_state_tx = CLEAR;
          CLEAR : next_state_tx = IDLE;
      endcase
  end

  // TX PACKET OUTPUT FROM FLUSH REGISTER
  always_comb begin : TX_PACKET_OUTPUT
    tx_packet = 0;
    if(slavedata[12] == 1) begin //reading value from ADDRESS_TX_PACKET
      tx_packet = DATA0;
    end else if(slavedata[12] == 2) begin
      tx_packet = ACK;
    end else if(slavedata[12] == 3) begin
      tx_packet = NAK;
    end else if(slavedata[12] == 4) begin
      tx_packet = STALL; 
    end else begin
      tx_packet = '0;
    end
  end

//Data Buffer FSM
    always_comb begin : DB_STATE
      next_data_state = data_state;
      next_read = read;
      next_write = write;
      case (data_state)
        DATA_IDLE : begin 
          if (next_slavedata[10][0]) begin
            next_data_state = READ;
          end else if (!hresp && hsel && hwrite && (next_address == 0)) begin
            next_data_state = DATA_WRITE;
          end
        end
        DATA_WRITE : begin
          next_data_state = BYTE1;
          next_write = 1;
        end
        READ  : begin
          next_data_state = BYTE1;
          next_read = 1;
        end
        BYTE1 : begin 
            next_data_state = (slavedata[11][0]) ? DATA_IDLE:BYTE2;
            next_read = (slavedata[11][0])? 0:read;
            next_write = (slavedata[11][0])? 0:write;
        end

        BYTE2 : begin 
            next_data_state = (slavedata[11][1]) ? DATA_IDLE:BYTE3;
            next_read = (slavedata[11][1])? 0:read;
            next_write = (slavedata[11][1])? 0:write;
        end
        BYTE3 : next_data_state = BYTE4;
        BYTE4 : begin 
            next_data_state = DATA_IDLE;
            next_read = 0;
            next_write = 0;
        end
        default: next_data_state = DATA_IDLE;
      endcase
    end

  always_comb begin : WRITE_DATA_OUTPUT
    tx_data       = '0;
    store_tx_data = '0;
    if (write)
      store_tx_data = 1'b1;
    if(write) begin
      case (data_state)
        BYTE1 : tx_data = slavedata[0];
        BYTE2 : tx_data = slavedata[1];
        BYTE3 : tx_data = slavedata[2];
        BYTE4 : tx_data = slavedata[3];
      endcase
    end
  end
  assign get_rx_data = read;

//ADDRESS MAPPING FOR THE SLAVE
  always_comb begin : ADDRESS_MAPPING
    hresp = 0;
    next_address = addr;
    if (hsel) begin
      if ((hwrite && (haddr < 10) && (haddr > 3)) || (haddr > 13) || (hsize == 3)) //conditions when errors
        hresp = 1; 
      else
        case (hsize)
          2'd0 : next_address = haddr; // 1 byte
          2'd1 : next_address = haddr & ~2'd1; // 2 bytes
          2'd2 : next_address = haddr & ~2'd3; // 4 bytes
          //little endian so read address should be mapped
        endcase
    end
  end





  always_comb begin : RECEIVE_DATA // READING
    // next_address is the read select line
    next_hrdata = hrdata;
    if (hsel && !hwrite && !hresp) begin //reading starts
      if ((!hwrite && next_hwrite) && (next_haddr == haddr)) // Check if read after write
        next_hrdata = hwdata; // Read directly from hwdata
      else begin
        case (hsize)
          0: begin // 1 byte read
            case (haddr[1:0])
              2'd0: next_hrdata = {24'd0, slavedata[next_address]};
              2'd1: next_hrdata = {16'd0, slavedata[next_address],  8'd0};
              2'd2: next_hrdata = { 8'd0, slavedata[next_address], 16'd0};
              2'd3: next_hrdata = {slavedata[next_address], 24'd0};
            endcase
          end 
          1: begin // 2 bytes read
            case (haddr[1:0])
              2'd0, 2'd1: next_hrdata = {16'd0, slavedata[next_address+1], slavedata[next_address]};
              2'd2, 2'd3: next_hrdata = {slavedata[next_address+1], slavedata[next_address], 16'd0};
            endcase
          end
          2: begin
          next_hrdata = {slavedata[next_address+3], slavedata[next_address+2], slavedata[next_address+1], slavedata[next_address]}; // 4 bytes read
          end
        endcase
      end
    end
  end


  //Writing
  always_comb begin : WRITE_FROM_AHB
    next_slavedata[8]  = {1'b0,buffer_occupancy}; //update buffer_occupancy reg
    next_slavedata[13:9] = slavedata[13:9]; //update the flush/tx control reg

    // TX CONTROL
    if (tx_state == CLEAR) begin 
      next_slavedata[12] = '0;//reset the tx_state
    end

    //FLUSH
    if (flush_state == CLEAR) begin
      next_slavedata[13] = '0; // reset the flush
    end

    // ERROR Reg
    next_slavedata[7:6] = '0; //clear error reg
    if (rx_error) begin
      next_slavedata[6] = 1;
    end
    if (tx_error) begin
      next_slavedata[7] = 1;
    end

    // Status Reg
    next_slavedata[5:4] = '0; //clear status reg
    if (rx_transfer_active) begin
      next_slavedata[5][0] = 1'b1;
    end
    if (tx_transfer_active) begin
      next_slavedata[5][1] = 1'b1;
    end
    if (rx_data_ready) begin
      next_slavedata[4][0] = 1'b1;
    end
    case (rx_packet)
      IN: begin
        next_slavedata[4][1] = 1'b1;
      end
      OUT: begin
        next_slavedata[4][2] = 1'b1;
      end
      ACK: begin
        next_slavedata[4][3] = 1'b1;
      end
      NAK: begin
        next_slavedata[4][4] = 1'b1;
      end
    endcase
  next_slavedata[3:0]= slavedata[3:0]; //set the data buffer reg
    // WRITE_ADDRESS_STATUS
    if(write)begin
      case (data_state)
        DATA_WRITE, BYTE1, BYTE2, BYTE3: next_slavedata[9] = 8'h1;
        BYTE4: next_slavedata[9] = 8'h0;
      endcase
    end

    // WRITE COMMAND FROM DATA_BUFFER
    if (data_state == DATA_WRITE)
      next_slavedata[3:0] = hwdata;

    if(read) begin
    case (data_state)
      BYTE1 : begin
        next_slavedata[0] = rx_data;
        if (slavedata[11][0]) begin
          next_slavedata[10] = '0;
        end
      end
      BYTE2 : 
      begin
        next_slavedata[1] = rx_data;
        if (slavedata[11][1]) begin
          next_slavedata[10] = '0;
        end
      end
      BYTE3 : next_slavedata[2] = rx_data;
      BYTE4 : 
        begin 
          next_slavedata[3] = rx_data;
          next_slavedata[10] = '0;
        end
    endcase
    end

    // SIZE REG
    if (hsel && (htrans != 2'b00)) begin
      case (hsize)
        0 : next_slavedata[11] = 1;
        1 : next_slavedata[11] = 2;
        2 : next_slavedata[11] = 4;
      endcase
    end

    if (hsel & next_hwrite && (addr > 9)) begin // Write Command
      case (next_hsize)
        0: begin
          case (addr[1:0])
            2'd0 : next_slavedata[addr] = hwdata[7:0];
            2'd1 : next_slavedata[addr] = hwdata[15:8];
            2'd2 : next_slavedata[addr] = hwdata[23:16];
            2'd3 : next_slavedata[addr] = hwdata[31:24];
          endcase
        end 
        1: begin
          case (addr[1:0])
            2'd0, 2'd1: {next_slavedata[addr+1],next_slavedata[addr]} = hwdata[15:0];
            2'd0, 2'd2: {next_slavedata[addr+1],next_slavedata[addr]} = hwdata[31:16];
          endcase
        end
        2: begin
          {next_slavedata[addr+3],next_slavedata[addr+2],next_slavedata[addr+1],next_slavedata[addr]} = hwdata;
        end
      endcase
    end
  end

  always_ff @( posedge clk, negedge n_rst ) begin : FLIP_FLOPS_FOR_ALL
      if (!n_rst) begin
        tx_state <= IDLE;
        flush_state <= IDLE;
        data_state <= DATA_IDLE;
        slavedata <= '0;
        read  <= '0;
        write <= '0;
        addr <= '0;
        hrdata <= '0;
        next_haddr  <= '0;
        next_hwrite <= '0;
        next_hsize <= '0;
      end else begin
        data_state <= next_data_state;
        tx_state <= next_state_tx;
        flush_state <= next_state_flush;
        slavedata <= next_slavedata;
        read  <= next_read;
        write <= next_write;
        addr <= next_address;
        hrdata <= next_hrdata;
        next_haddr  <= haddr;
        next_hwrite <= hwrite;
        next_hsize <= hsize;
      end
  end
endmodule