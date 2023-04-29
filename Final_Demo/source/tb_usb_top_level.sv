`timescale 1ns / 10ps
module tb_usb_top_level();

// Timing related constants
localparam CLK_PERIOD = 10;
localparam BUS_DELAY  = 800ps; // Based on FF propagation delay
localparam DATA_PERIOD = 83.3333;
localparam USB_PERIOD = 80;
localparam DATA_SIZE = 8;

// Sizing related constants
localparam DATA_WIDTH      = 4;
localparam ADDR_WIDTH      = 4;
localparam DATA_WIDTH_BITS = DATA_WIDTH * 8;
localparam DATA_MAX_BIT    = DATA_WIDTH_BITS - 1;
localparam ADDR_MAX_BIT    = ADDR_WIDTH - 1;

// AHB Register Indices;
localparam DATA_BUFF_IND        = 0;  //size = 4
localparam STATUS_IND           = 4;  //size = 2
localparam ERROR_IND            = 6;  //size = 2
localparam BUFFER_OCCUPANCY_IND = 8;  //size = 1
localparam WRITE_STATUS_IND     = 9;  //size = 1  
localparam READ_STATUS_IND      = 10; //size = 1  get_rx_data
localparam BYTE_IND             = 11; //size = 1  size
localparam TX_CONTROL_IND       = 12; //size = 1
localparam FLUSH_CONTROL_IND    = 13; //size = 1

// PID read from AHB status register
localparam NEW_DATA_AHB   = 16'b0000000000000000;
localparam PID_IN_AHB     = 16'b0000000000000001;
localparam PID_OUT_AHB    = 16'b0000000000000010;
localparam PID_ACK_AHB    = 16'b0000000000000100;
localparam PID_NAK_AHB    = 16'b0000000000001000;
localparam RECEIVING_AHB  = 16'b0000000100000000;
localparam SENDING_AHB    = 16'b0000001000000000;

//PID Constants
localparam SYNC_BYTE  = 8'b10000000;
localparam PID_OUT    = 4'b0001; //11100001 -> 00001010
localparam PID_IN     = 4'b1001; //01101001 -> 01110010
localparam PID_DATA_0 = 4'b0011; //11000011 -> 00010100
localparam PID_DATA_1 = 4'b1011; //01001011 -> 01101100
localparam PID_ACK    = 4'b0010; //11010010 -> 00011011
localparam PID_NAK    = 4'b1010; //01011010 -> 01100011
localparam PID_STALL  = 4'b1110; //00011110 -> 01011111
//PID Bytes
localparam PID_OUT_BYTE = 8'b11100001;
localparam PID_IN_BYTE = 8'b01101001;
localparam PID_DATA0_BYTE = 8'b11000011;
localparam PID_DATA1_BYTE = 8'b01001011;
localparam PID_ACK_BYTE = 8'b11010010;
localparam PID_NAK_BYTE = 8'b01011010;
localparam PID_STALL_BYTE = 8'b00011110;

// Endpoint Address constant
localparam USB_ADDR = 16'b0110000010000001; // Address: 7'b0000001, Endpoint number: 4'b0001, CRC:5'b01100
localparam CRC_BITS1 = 8'b00001101;
localparam CRC_BITS0 = 8'b10000000;

//DUT Inputs
logic tb_clk;
logic tb_n_rst;
logic tb_hsel;
logic [ADDR_MAX_BIT:0] tb_haddr;
logic [1:0] tb_htrans;
logic [2:0] tb_hsize;
logic tb_hwrite;
logic [DATA_MAX_BIT:0] tb_hwdata;
logic tb_d_plus_in;
logic tb_d_minus_in;

//DUT Outputs
logic [DATA_MAX_BIT:0] tb_hrdata;
logic tb_hresp;
logic tb_hready;
logic tb_d_mode;
logic tb_d_plus_out;
logic tb_d_minus_out;
logic [6:0] tb_buffer_occupancy;
logic tb_get_rx_data;
logic [3:0] tb_tx_packet;
logic tb_tx_transfer_active;

//Test Bench Debug Signal
// Overall test case number for reference
integer tb_test_case_num;
string tb_test_case;
integer j;
string                 tb_check_tag;
logic                  tb_mismatch;
logic                  tb_check;
// Test case 'inputs' used for test stimulus
reg tb_test_prev_d_plus;
reg [6:0] tb_test_rx_count; // record how many bytes received

//Expected Outputs
//logic [DATA_MAX_BIT:0] tb_expected_hrdata;
//logic tb_expected_hresp;
//logic tb_expected_hready;
logic tb_expected_d_mode;
logic tb_expected_d_plus_out;
logic tb_expected_d_minus_out;

typedef struct
{
    reg [3:0] pid;
    reg [7:0] data[];
} testVector;
testVector tb_test_vectors;

//*****************************************************************************
// Declare Bus Model Control Signals
//*****************************************************************************
// Testing setup signals
logic                      tb_enqueue_transaction;
logic                      tb_transaction_write;
logic                      tb_transaction_fake;
logic [ADDR_MAX_BIT:0]     tb_transaction_addr;
bit   [DATA_MAX_BIT:0]     tb_transaction_data[];
logic                      tb_transaction_error;
logic [2:0]                tb_transaction_size;
// Testing control signal(s)
logic    tb_enable_transactions;
integer  tb_current_addr_transaction_num;
integer  tb_current_addr_beat_num;
logic    tb_current_addr_transaction_error;
integer  tb_current_data_transaction_num;
integer  tb_current_data_beat_num;
logic    tb_current_data_transaction_error;
logic    tb_model_reset;
bit      [DATA_MAX_BIT:0] tb_test_data [];

//*****************************************************************************
// Clock Generation Block
//*****************************************************************************
always begin
  // Start with clock low to avoid false rising edge events at t=0
  tb_clk = 1'b0;
  // Wait half of the clock period before toggling clock value (maintain 50% duty cycle)
  #(CLK_PERIOD/2.0);
  tb_clk = 1'b1;
  // Wait half of the clock period before toggling clock value via rerunning the block (maintain 50% duty cycle)
  #(CLK_PERIOD/2.0);
end

//*****************************************************************************
// DUT Instance
//*****************************************************************************
usb_top_level DUT(
    .clk(tb_clk),
    .n_rst(tb_n_rst),
    .hsel(tb_hsel),
    .haddr(tb_haddr),
    .htrans(tb_htrans),
    .hsize(tb_hsize[1:0]),
    .hwrite(tb_hwrite),
    .hwdata(tb_hwdata),
    .hrdata(tb_hrdata),
    .hresp(tb_hresp),
    .hready(tb_hready),
    .d_mode(tb_d_mode),
    .d_plus_in(tb_d_plus_in),
    .d_minus_in(tb_d_minus_in),
    .d_plus_out(tb_d_plus_out),
    .d_minus_out(tb_d_minus_out),
    .buffer_occupancy(tb_buffer_occupancy),
    .get_rx_data(tb_get_rx_data),
    .tx_packet(tb_tx_packet),
    .tx_transfer_active(tb_tx_transfer_active)
);

//*****************************************************************************
// Bus Model Instance
//*****************************************************************************
ahb_lite_bus_cdl #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) BFM (.clk(tb_clk),
                  // Testing setup signals
                  .enqueue_transaction(tb_enqueue_transaction),
                  .transaction_write(tb_transaction_write),
                  .transaction_fake(tb_transaction_fake),
                  .transaction_addr(tb_transaction_addr),
                  .transaction_data(tb_transaction_data),
                  .transaction_error(tb_transaction_error),
                  .transaction_size(tb_transaction_size),
                  // Testing controls
                  .model_reset(tb_model_reset),
                  .enable_transactions(tb_enable_transactions),
                  .current_addr_transaction_num(tb_current_addr_transaction_num),
                  .current_addr_beat_num(tb_current_addr_beat_num),
                  .current_addr_transaction_error(tb_current_addr_transaction_error),
                  .current_data_transaction_num(tb_current_data_transaction_num),
                  .current_data_beat_num(tb_current_data_beat_num),
                  .current_data_transaction_error(tb_current_data_transaction_error),
                  // AHB-Lite-Slave Side
                  .hsel(tb_hsel),
                  .htrans(tb_htrans),
                  .haddr(tb_haddr),
                  .hsize(tb_hsize),
                  .hwrite(tb_hwrite),
                  .hwdata(tb_hwdata),
                  .hrdata(tb_hrdata),
                  .hresp(tb_hresp),
                  .hready(tb_hready));

//*****************************************************************************
// DUT Related TB Tasks
//*****************************************************************************
// Task for standard DUT reset procedure
task reset_dut;
begin
  // Activate the reset
  tb_n_rst = 1'b0;

  // Maintain the reset for more than one cycle
  @(posedge tb_clk);
  @(posedge tb_clk);

  // Wait until safely away from rising edge of the clock before releasing
  @(negedge tb_clk);
  tb_n_rst = 1'b1;

  // Leave out of reset for a couple cycles before allowing other stimulus
  // Wait for negative clock edges, 
  // since inputs to DUT should normally be applied away from rising clock edges
  @(negedge tb_clk);
  @(negedge tb_clk);
end
endtask

//*****************************************************************************
// Rx Tasks
//*****************************************************************************
task send_bit;
    input one_bit;
begin
    if(one_bit == 1'b0) begin
        tb_d_plus_in = !tb_test_prev_d_plus;
        tb_d_minus_in = tb_test_prev_d_plus;
        tb_test_prev_d_plus = !tb_test_prev_d_plus;
    end
    else begin
        tb_d_plus_in = tb_test_prev_d_plus;
        tb_d_minus_in = !tb_test_prev_d_plus;
    end
    #(DATA_PERIOD);
end
endtask

task send_byte;
    input [7:0] data;
    integer i;
begin
    for(i = 0; i < 8; i = i + 1)
    begin
        if(data[i] == 0) begin
            tb_d_plus_in = !tb_test_prev_d_plus;
            tb_d_minus_in = tb_test_prev_d_plus;
            tb_test_prev_d_plus = !tb_test_prev_d_plus;
        end
        else begin
            tb_d_plus_in = tb_test_prev_d_plus;
            tb_d_minus_in = !tb_test_prev_d_plus;
        end
        #(DATA_PERIOD);
    end
    tb_test_rx_count = tb_test_rx_count + 1;
end
endtask

task send_eop;
begin
    tb_d_plus_in = 1'b0;
    tb_d_minus_in = 1'b0;
    #(DATA_PERIOD*2);
    tb_d_plus_in = 1'b1;
    tb_d_minus_in = 1'b0;
    tb_test_prev_d_plus = 1'b1;
end
endtask

task test_stream;
    input testVector tv;
    integer i;
begin
    logic [7:0] pidd;
    pidd = {~tv.pid, tv.pid};
    send_byte(SYNC_BYTE); // send sync byte
    send_byte(pidd);
    for(i = 0; i < tv.data.size; i++) begin
        send_byte(tv.data[i]);
    end
    send_eop();
end
endtask

task init_rx_in;
    tb_test_rx_count = '0;
    tb_d_plus_in = 1'b1;
    tb_d_minus_in = 1'b0;
    tb_test_prev_d_plus = 1'b1;
endtask

//*****************************************************************************
// Tx Tasks
//*****************************************************************************
/*task test_tx_packet_stream(testVector tv[]);
begin
    int i;
    for(i = 0; i < tv.size; i++) begin
        test_tx_packet(tv[i]);
    end
end
endtask

task check_tx_outputs;
begin
  tb_check = 1;
  if(expected_d_plus_out != tb_d_plus_out) begin
    $error("Error %0d: Wrong d_plus!", tb_test_case_num);
  end
  if(expected_d_minus_out != tb_d_minus_out) begin
    $error("Error %0d: Wrong d_minus!", tb_test_case_num);
  end
  #(0.1);
  tb_check = 0; 
end
endtask

task encoder(logic bit_value);
    if(!bit_value) begin
        expected_d_plus_out = ~expected_d_plus_out;
        expected_d_minus_out = ~expected_d_minus_out;
    end
endtask

task test_tx_packet;
  input testVector tv;
begin
    int i;
    logic [7:0] data;

    // SYNC
    data = SYNC_BYTE;
    for(i=0; i < 8; i++)begin
        encoder(data[i]);
        #(USB_PERIOD/2);
        check_outputs;
        #(USB_PERIOD/2 - 0.1);
    end

    // PID
    data = {~tv.pid, tv.pid};
    for(i=0; i < 8; i++)begin
        encoder(data[i]);
        #(USB_PERIOD/2);
        check_outputs;
        #(USB_PERIOD/2 - 0.1);
    end

    // CHECK DATA 
    if (tb_tx_packet == PID_DATA0) begin
        i = 0;
        while(i < tv.data.size) begin
            data = tv.data[i];
            for(int j = 0; j < 8; j++)begin
                encoder(data[j]);
                #(USB_PERIOD/2);
                check_outputs;
                #(USB_PERIOD/2 - 0.1);
            end
            i++;
        end
    end

    if ((tb_tx_packet == PID_DATA_0) || (tb_tx_packet == PID_DATA_1) || (tb_tx_packet == PID_IN)|| (tb_tx_packet == PID_OUT)) begin
        data = 8'd0;
        for(int j = 0; j < 8; j++)begin
                encoder(data[j]);
                #(USB_PERIOD/2);
                check_outputs;
                #(USB_PERIOD/2 - 0.1);
        end
        for(int j = 0; j < 8; j++)begin
                encoder(data[j]);
                #(USB_PERIOD/2);
                check_outputs;
                #(USB_PERIOD/2 - 0.1);
        end
    end

    //tb_tx_packet = 0;

    // EOP
    expected_d_plus_out = 0;
    expected_d_minus_out = 0;
    //check in the middle
    #(USB_PERIOD / 2);
    check_outputs;
    // run for one byte
    #(USB_PERIOD - 0.1);
    check_outputs;
    // go back to normal clock
    #(USB_PERIOD / 2 - 0.1);

    // IDLE
    expected_d_plus_out = 1;
    expected_d_minus_out = 0;
    #(CLK_PERIOD * 4);
    check_outputs;
end
endtask*/

//*****************************************************************************
// Bus Model Usage Related TB Tasks
//*****************************************************************************
// Task to pulse the reset for the bus model
task reset_model;
begin
  tb_model_reset = 1'b1;
  #(0.1);
  tb_model_reset = 1'b0;
end
endtask

// Task to enqueue a new transaction
task enqueue_transaction;
  input logic for_dut;
  input logic write_mode;
  input logic [ADDR_MAX_BIT:0] address;
  input bit   [DATA_MAX_BIT:0] data [];
  input logic expected_error;
  input logic [1:0] size;
begin
  // Make sure enqueue flag is low (will need a 0->1 pulse later)
  tb_enqueue_transaction = 1'b0;
  #0.1ns;

  // Setup info about transaction
  tb_transaction_fake  = ~for_dut;
  tb_transaction_write = write_mode;
  tb_transaction_addr  = address;
  tb_transaction_data  = data;
  tb_transaction_error = expected_error;
  tb_transaction_size  = {1'b0,size};

  // Pulse the enqueue flag
  tb_enqueue_transaction = 1'b1;
  #0.1ns;
  tb_enqueue_transaction = 1'b0;
end
endtask

// Task to wait for multiple transactions to happen
task execute_transactions;
  input integer num_transactions;
  integer wait_var;
begin
  // Activate the bus model
  tb_enable_transactions = 1'b1;
  @(posedge tb_clk);

  // Process the transactions (all but last one overlap 1 out of 2 cycles
  for(wait_var = 0; wait_var < num_transactions; wait_var++) begin
    @(posedge tb_clk);
  end

  // Run out the last one (currently in data phase)
  @(posedge tb_clk);

  // Turn off the bus model
  @(negedge tb_clk);
  tb_enable_transactions = 1'b0;
end
endtask

// Task to check the outputs
task check_outputs;
  input string check_tag;
begin
  tb_mismatch = 1'b0;
  tb_check    = 1'b1;
  if(tb_expected_d_mode == tb_d_mode) begin // Check passed
    $info("Correct 'd_mode' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'd_mode' output %s during %s test case", check_tag, tb_test_case);
  end

  if(tb_expected_d_plus_out == tb_d_plus_out) begin // Check passed
    $info("Correct 'dplus_out' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'dplus_out' output %s during %s test case", check_tag, tb_test_case);
  end

  if(tb_expected_d_minus_out == tb_d_minus_out) begin // Check passed
    $info("Correct 'dminus_out' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'dminus_out' output %s during %s test case", check_tag, tb_test_case);
  end
  // Wait some small amount of time so check pulse timing is visible on waves
  #(0.1);
  tb_check =1'b0;
end
endtask
// Task to clear/initialize all inputs
task init_expected_outs;
begin
tb_expected_d_mode      = '0;
tb_expected_d_minus_out  = '0;
tb_expected_d_plus_out   = '1;
end
endtask

initial begin
  // Initialize Test Case Navigation Signals
  tb_test_case       = "Initilization";
  tb_test_case_num   = -1;
  tb_test_data       = '{1{32'b0}};
  tb_check_tag       = "N/A";
  tb_check           = 1'b0;
  tb_mismatch        = 1'b0;
  // Initialize all of the directly controled DUT inputs
  tb_n_rst          = 1'b1;
  // Initialize all of the bus model control inputs
  tb_model_reset          = 1'b0;
  tb_enable_transactions  = 1'b0;
  tb_enqueue_transaction  = 1'b0;
  tb_transaction_write    = 1'b0;
  tb_transaction_fake     = 1'b0;
  tb_transaction_addr     = '0;
  tb_transaction_data     = '{1{32'b0}};
  tb_transaction_error    = 1'b0;
  tb_transaction_size     = 3'd0;
  // Initialize the top input
  tb_d_plus_in = 1'b1;
  tb_d_minus_in = 1'b0;
  // Initialize the top output
  tb_expected_d_plus_out  = 1'b1;
  tb_expected_d_minus_out = 1'b0;

  // Wait some time before starting first test case
  #(0.1);

  // Clear the bus model
  reset_model();

  //*****************************************************************************
  //Test Case 0: Power-on-Reset Test Case
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Power-on-Reset";
  tb_test_case_num = tb_test_case_num + 1;
  // Reset the DUT
  init_rx_in();
  reset_dut();
  // Check outputs for reset state
  init_expected_outs();
  #(BUS_DELAY);
  check_outputs("after DUT reset");
  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 2);

  //*****************************************************************************
  //Test Case 1: Receive PID OUT and normal data
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Receive PID OUT and normal data";
  tb_test_case_num = tb_test_case_num + 1;
  // Reset the DUT
  init_rx_in();
  reset_dut();
  init_expected_outs();
  tb_test_vectors.data = new[2];
  tb_test_vectors.pid = PID_OUT;
  tb_test_vectors.data[0] = USB_ADDR[7:0];//ADDRESS: 7'b0000001, Endpoint number: 4'b0001, CRC number: 5'b00000
  tb_test_vectors.data[1] = USB_ADDR[15:8];
  @(negedge tb_clk);
  test_stream(tb_test_vectors);
  #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder
  tb_test_data     = '{1{32'h00000004}}; //received OUT token
  //Read Status Register and whether there is error
  enqueue_transaction(1'b1, 1'b0, STATUS_IND, tb_test_data, 1'b0, 2'd1); // Receive OUT
  enqueue_transaction(1'b1, 1'b0, ERROR_IND, '{1{32'h00000000}}, 1'b0, 2'd1); // No error
  execute_transactions(2);

  tb_test_vectors.data = new[4];
  tb_test_vectors.pid = PID_DATA_0;
  tb_test_vectors.data[0] = 8'b11000000; // 2 bytes data
  tb_test_vectors.data[1] = 8'b01101100;
  tb_test_vectors.data[2] = USB_ADDR[7:0];//ADDRESS: 7'b0000001, Endpoint number: 4'b0001, CRC number: 5'b00000
  tb_test_vectors.data[3] = USB_ADDR[15:8];
  @(negedge tb_clk);
  test_stream(tb_test_vectors);
  #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder
  tb_test_data = '{1{32'h00000001}}; // set get_rx_data to 1
  //Check whether there is error and read the data
  enqueue_transaction(1'b1, 1'b0, ERROR_IND, '{1{32'h00000000}}, 1'b0, 2'd1); // No error
  enqueue_transaction(1'b1, 1'b0, STATUS_IND, '{1{32'h00000001}}, 1'b0, 2'd1); // Check PID and Data ready
  enqueue_transaction(1'b1, 1'b1, BYTE_IND, '{1{32'h00000001}}, 1'b0, 2'd1); // How many size want to read
  enqueue_transaction(1'b1, 1'b1, READ_STATUS_IND, '{1{32'h00010000}}, 1'b0, 2'd0); // Set get_rx_data to 1
  execute_transactions(4);
  #(CLK_PERIOD*5);
  enqueue_transaction(1'b1, 1'b0, DATA_BUFF_IND, '{1{32'h000000c0}}, 1'b0, 2'd0);
  enqueue_transaction(1'b1, 1'b0, DATA_BUFF_IND + 1, '{1{32'h00006c00}}, 1'b0, 2'd0);
  execute_transactions(2);
  //After correctly receiving data,if no error, send flush and ACK
  enqueue_transaction(1'b1, 1'b1, FLUSH_CONTROL_IND, tb_test_data, 1'b0, 2'd0);
  enqueue_transaction(1'b1, 1'b1, TX_CONTROL_IND, '{1{32'h00000002}}, 1'b0, 2'd0); // send ACK
  execute_transactions(2);
  // Tx outputs check
  // tb_test_vectors = new[1];
  // tb_test_vectors[0].pid = 4'b0010;
  #(40*DATA_PERIOD);
  
  

  //*****************************************************************************
  //Test Case 2: Receive PID OUT and data with error
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Receive PID OUT and data with error";
  tb_test_case_num = tb_test_case_num + 1;
  // Reset the DUT
  init_rx_in();
  reset_dut();
  init_expected_outs();
  tb_test_vectors.data = new[2];
  tb_test_vectors.pid = PID_OUT;
  tb_test_vectors.data[0] = USB_ADDR[7:0];//ADDRESS: 7'b0000001, Endpoint number: 4'b0001, CRC number: 5'b00000
  tb_test_vectors.data[1] = USB_ADDR[15:8];
  @(negedge tb_clk);
  test_stream(tb_test_vectors);
  #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder
  tb_test_data     = '{1{32'h00000004}}; //received OUT token
  //Read Status Register
  enqueue_transaction(1'b1, 1'b0, STATUS_IND, tb_test_data, 1'b0, 2'd1); // Receive OUT
  enqueue_transaction(1'b1, 1'b0, ERROR_IND, '{1{32'h00000000}}, 1'b0, 2'd1); // No error
  execute_transactions(2);

  //Send eop early before sending a byte
  send_byte(SYNC_BYTE); //send sync byte
  send_byte(PID_DATA0_BYTE); //send pid
  send_byte(8'b00001011); // send a byte data
  send_bit(1'b1);
  send_byte(CRC_BITS0); // CRC
  send_byte(CRC_BITS1);
  send_eop(); // send an eop during sending a byte
  #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder
  enqueue_transaction(1'b1, 1'b0, ERROR_IND, '{1{32'h00010000}}, 1'b0, 2'd1); // Receiving error
  execute_transactions(1);
  // Send Flush and PID NAK
  enqueue_transaction(1'b1, 1'b1, FLUSH_CONTROL_IND, '{1{32'h00000001}}, 1'b0, 2'd0);
  enqueue_transaction(1'b1, 1'b1, TX_CONTROL_IND, '{1{32'h00000003}}, 1'b0, 2'd0); // send NAK
  execute_transactions(2);
  #(40*DATA_PERIOD);

  //*****************************************************************************
  //Test Case 3: Receive PID OUT and data over 64 bytes
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Receive PID OUT and data over 64 bytes";
  tb_test_case_num = tb_test_case_num + 1;
  // Reset the DUT
  init_rx_in();
  reset_dut();
  init_expected_outs();
  tb_test_vectors.data = new[2];
  tb_test_vectors.pid = PID_OUT;
  tb_test_vectors.data[0] = USB_ADDR[7:0];//ADDRESS: 7'b0000001, Endpoint number: 4'b0001, CRC number: 5'b00000
  tb_test_vectors.data[1] = USB_ADDR[15:8];
  @(negedge tb_clk);
  test_stream(tb_test_vectors);
  #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder

  tb_test_data     = '{1{32'h00000004}}; //received OUT token
  enqueue_transaction(1'b1, 1'b0, STATUS_IND, tb_test_data, 1'b0, 2'd1); // Receive OUT
  enqueue_transaction(1'b1, 1'b0, ERROR_IND, '{1{32'h00000000}}, 1'b0, 2'd1); // No error
  execute_transactions(2);

  //Send 65 bytes data
  tb_test_vectors.data = new[67]; // 65 bytes + 2 bytes CRC
  for(j = 0; j < tb_test_vectors.data.size - 2; j++)
  begin
      tb_test_vectors.data[j] = 8'b10111100;
  end
  tb_test_vectors.pid = PID_DATA_0;
  tb_test_vectors.data[65] = CRC_BITS0;// last 2 bytes are CRC
  tb_test_vectors.data[66] = CRC_BITS1;
  @(negedge tb_clk);
  test_stream(tb_test_vectors);
  #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder

  enqueue_transaction(1'b1, 1'b0, ERROR_IND, '{1{32'h00010000}}, 1'b0, 2'd1); // Receiving error
  execute_transactions(1);
  // Send Flush and PID NAK
  enqueue_transaction(1'b1, 1'b1, FLUSH_CONTROL_IND, '{1{32'h00000001}}, 1'b0, 2'd0);
  enqueue_transaction(1'b1, 1'b1, TX_CONTROL_IND, '{1{32'h00000003}}, 1'b0, 2'd0); // send NAK
  execute_transactions(2);
  #(40*DATA_PERIOD);


  //*****************************************************************************
  //Test Case 4: Receive PID OUT and 64 bytes data
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Receive PID OUT and 64 bytes data";
  tb_test_case_num = tb_test_case_num + 1;
  // Reset the DUT
  init_rx_in();
  reset_dut();
  init_expected_outs();
  tb_test_vectors.data = new[2];
  tb_test_vectors.pid = PID_OUT;
  tb_test_vectors.data[0] = USB_ADDR[7:0];//ADDRESS: 7'b0000001, Endpoint number: 4'b0001, CRC number: 5'b00000
  tb_test_vectors.data[1] = USB_ADDR[15:8];
  @(negedge tb_clk);
  test_stream(tb_test_vectors);
  #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder

  tb_test_data     = '{1{32'h00000004}}; //received OUT token
  enqueue_transaction(1'b1, 1'b0, STATUS_IND, tb_test_data, 1'b0, 2'd1); // Receive OUT
  enqueue_transaction(1'b1, 1'b0, ERROR_IND, '{1{32'h00000000}}, 1'b0, 2'd1); // No error
  execute_transactions(2);

  //Send 65 bytes data
  tb_test_vectors.data = new[66]; // 64 bytes + 2 bytes CRC
  for(j = 0; j < tb_test_vectors.data.size - 2; j++)
  begin
      tb_test_vectors.data[j] = 8'b11110000;
  end
  tb_test_vectors.pid = PID_DATA_0;
  tb_test_vectors.data[64] = CRC_BITS0;// last 2 bytes are CRC
  tb_test_vectors.data[65] = CRC_BITS1;
  @(negedge tb_clk);
  test_stream(tb_test_vectors);
  #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder

  enqueue_transaction(1'b1, 1'b0, ERROR_IND, '{1{32'h00000000}}, 1'b0, 2'd1); // No error
  execute_transactions(1);

  for(j = 0; j < 16; j++) begin
    enqueue_transaction(1'b1, 1'b1, BYTE_IND, '{1{32'h00000001}}, 1'b0, 2'd0); // How many size want to read
    enqueue_transaction(1'b1, 1'b1, READ_STATUS_IND, '{1{32'h00010000}}, 1'b0, 2'd0); // Set get_rx_data to 1
    execute_transactions(2);
    #(CLK_PERIOD*5);
    enqueue_transaction(1'b1, 1'b0, DATA_BUFF_IND, '{1{32'h000000f0}}, 1'b0, 2'd0);
    enqueue_transaction(1'b1, 1'b0, DATA_BUFF_IND + 1, '{1{32'h0000f000}}, 1'b0, 2'd0);
    enqueue_transaction(1'b1, 1'b0, DATA_BUFF_IND + 2, '{1{32'h00f00000}}, 1'b0, 2'd0);
    enqueue_transaction(1'b1, 1'b0, DATA_BUFF_IND + 3, '{1{32'hf0000000}}, 1'b0, 2'd0);
    execute_transactions(4);
  end

  // Send Flush and PID NAK
  enqueue_transaction(1'b1, 1'b1, FLUSH_CONTROL_IND, '{1{32'h00000001}}, 1'b0, 2'd0);
  enqueue_transaction(1'b1, 1'b1, TX_CONTROL_IND, '{1{32'h00000003}}, 1'b0, 2'd0); // send NAK
  execute_transactions(2);
  #(40*DATA_PERIOD);


  //*****************************************************************************
  //Test Case 5: Receive PID IN and transmit data successfully
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Receive PID IN and transmit data successfully";
  tb_test_case_num = tb_test_case_num + 1;
  // Reset the DUT
  init_rx_in();
  reset_dut();
  init_expected_outs();
  tb_test_vectors.data = new[2];
  tb_test_vectors.pid = PID_IN;
  tb_test_vectors.data[0] = USB_ADDR[7:0];//ADDRESS: 7'b0000001, Endpoint number: 4'b0001, CRC number: 5'b00000
  tb_test_vectors.data[1] = USB_ADDR[15:8];
  @(negedge tb_clk);
  test_stream(tb_test_vectors);
  #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder
  //Read Status Register
  tb_test_data = '{1{32'h00000002}}; //received OUT token
  enqueue_transaction(1'b1, 1'b0, STATUS_IND, tb_test_data, 1'b0, 2'd1); // Receive OUT
  enqueue_transaction(1'b1, 1'b0, ERROR_IND, '{1{32'h00000000}}, 1'b0, 2'd1); // No error
  execute_transactions(2);

  enqueue_transaction(1'b1, 1'b1, DATA_BUFF_IND, '{1{32'haabbccdd}}, 1'b0, 2'd2);
  execute_transactions(1);
  repeat(4)@(posedge tb_clk);
   

  //enqueue_transaction(1'b1, 1'b1, BYTE_IND, '{1{32'h00000001}}, 1'b0, 2'd2);
  enqueue_transaction(1'b1, 1'b1, FLUSH_CONTROL_IND, '{1{32'h00000001}}, 1'b0, 2'd0);
  enqueue_transaction(1'b1, 1'b1, TX_CONTROL_IND, '{1{32'h00000001}}, 1'b0, 2'd0); // send DATA0
  execute_transactions(2);
  //Receive ACK
  /*tb_test_vectors.data = new[0];
  tb_test_vectors.pid = PID_ACK;
  @(negedge tb_clk);
  test_stream(tb_test_vectors);
  #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder*/
  #(80*DATA_PERIOD);
  
  //*****************************************************************************
  //Test Case 6: Receive PID IN and transmit 64 bytes data successfully
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Receive PID IN and transmit 64 bytes data successfully";
  tb_test_case_num = tb_test_case_num + 1;
  // Reset the DUT
  init_rx_in();
  reset_dut();
  init_expected_outs();
  tb_test_vectors.data = new[2];
  tb_test_vectors.pid = PID_IN;
  tb_test_vectors.data[0] = USB_ADDR[7:0];//ADDRESS: 7'b0000001, Endpoint number: 4'b0001, CRC number: 5'b00000
  tb_test_vectors.data[1] = USB_ADDR[15:8];
  @(negedge tb_clk);
  test_stream(tb_test_vectors);
  #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder
  //Read Status Register
  tb_test_data = '{1{32'h00000002}}; //received OUT token
  enqueue_transaction(1'b1, 1'b0, STATUS_IND, tb_test_data, 1'b0, 2'd1); // Receive OUT
  enqueue_transaction(1'b1, 1'b0, ERROR_IND, '{1{32'h00000000}}, 1'b0, 2'd1); // No error
  execute_transactions(2);

  enqueue_transaction(1'b1, 1'b1, DATA_BUFF_IND, '{1{32'haabbccdd}}, 1'b0, 2'd2);
  execute_transactions(1);
  repeat(4)@(posedge tb_clk);
  enqueue_transaction(1'b1, 1'b1, DATA_BUFF_IND, '{1{32'haabbccdd}}, 1'b0, 2'd2);
  execute_transactions(1);
  repeat(4)@(posedge tb_clk);
  enqueue_transaction(1'b1, 1'b1, DATA_BUFF_IND, '{1{32'haabbccdd}}, 1'b0, 2'd2);
  execute_transactions(1);
  repeat(4)@(posedge tb_clk);
  enqueue_transaction(1'b1, 1'b1, DATA_BUFF_IND, '{1{32'haabbccdd}}, 1'b0, 2'd2);
  execute_transactions(1);
  repeat(4)@(posedge tb_clk);
  enqueue_transaction(1'b1, 1'b1, DATA_BUFF_IND, '{1{32'haabbccdd}}, 1'b0, 2'd2);
  execute_transactions(1);
  repeat(4)@(posedge tb_clk);
  enqueue_transaction(1'b1, 1'b1, DATA_BUFF_IND, '{1{32'haabbccdd}}, 1'b0, 2'd2);
  execute_transactions(1);
  repeat(4)@(posedge tb_clk);
  enqueue_transaction(1'b1, 1'b1, DATA_BUFF_IND, '{1{32'haabbccdd}}, 1'b0, 2'd2);
  execute_transactions(1);
  repeat(4)@(posedge tb_clk);
  enqueue_transaction(1'b1, 1'b1, DATA_BUFF_IND, '{1{32'haabbccdd}}, 1'b0, 2'd2);
  execute_transactions(1);
  repeat(4)@(posedge tb_clk);
  enqueue_transaction(1'b1, 1'b1, DATA_BUFF_IND, '{1{32'haabbccdd}}, 1'b0, 2'd2);
  execute_transactions(1);
  repeat(4)@(posedge tb_clk);
  enqueue_transaction(1'b1, 1'b1, DATA_BUFF_IND, '{1{32'haabbccdd}}, 1'b0, 2'd2);
  execute_transactions(1);
  repeat(4)@(posedge tb_clk);
  enqueue_transaction(1'b1, 1'b1, DATA_BUFF_IND, '{1{32'haabbccdd}}, 1'b0, 2'd2);
  execute_transactions(1);
  repeat(4)@(posedge tb_clk);
  enqueue_transaction(1'b1, 1'b1, DATA_BUFF_IND, '{1{32'haabbccdd}}, 1'b0, 2'd2);
  execute_transactions(1);
  repeat(4)@(posedge tb_clk);
  enqueue_transaction(1'b1, 1'b1, DATA_BUFF_IND, '{1{32'haabbccdd}}, 1'b0, 2'd2);
  execute_transactions(1);
  repeat(4)@(posedge tb_clk);
  enqueue_transaction(1'b1, 1'b1, DATA_BUFF_IND, '{1{32'haabbccdd}}, 1'b0, 2'd2);
  execute_transactions(1);
  repeat(4)@(posedge tb_clk);
  enqueue_transaction(1'b1, 1'b1, DATA_BUFF_IND, '{1{32'haabbccdd}}, 1'b0, 2'd2);
  execute_transactions(1);
  repeat(4)@(posedge tb_clk);
  enqueue_transaction(1'b1, 1'b1, DATA_BUFF_IND, '{1{32'haabbccdd}}, 1'b0, 2'd2);
  execute_transactions(1);
  repeat(4)@(posedge tb_clk);
   

  //enqueue_transaction(1'b1, 1'b1, BYTE_IND, '{1{32'h00000001}}, 1'b0, 2'd2);
  enqueue_transaction(1'b1, 1'b1, FLUSH_CONTROL_IND, '{1{32'h00000001}}, 1'b0, 2'd0);
  enqueue_transaction(1'b1, 1'b1, TX_CONTROL_IND, '{1{32'h00000001}}, 1'b0, 2'd0); // send DATA0
  execute_transactions(2);
  //Receive ACK
  /*tb_test_vectors.data = new[0];
  tb_test_vectors.pid = PID_ACK;
  @(negedge tb_clk);
  test_stream(tb_test_vectors);
  #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder*/
  #(1000*DATA_PERIOD);


  //*****************************************************************************
  //Test Case 7: Receive PID IN and transmit PID NAK
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Receive PID IN and transmit PID NAK";
  tb_test_case_num = tb_test_case_num + 1;
  // Reset the DUT
  init_rx_in();
  reset_dut();
  init_expected_outs();
  tb_test_vectors.data = new[2];
  tb_test_vectors.pid = PID_IN;
  tb_test_vectors.data[0] = USB_ADDR[7:0];//ADDRESS: 7'b0000001, Endpoint number: 4'b0001, CRC number: 5'b00000
  tb_test_vectors.data[1] = USB_ADDR[15:8];
  @(negedge tb_clk);
  test_stream(tb_test_vectors);
  #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder
  //Read Status Register
  tb_test_data = '{1{32'h00000002}}; //received OUT token
  enqueue_transaction(1'b1, 1'b0, STATUS_IND, tb_test_data, 1'b0, 2'd1); // Receive OUT
  enqueue_transaction(1'b1, 1'b0, ERROR_IND, '{1{32'h00000000}}, 1'b0, 2'd1); // No error
  execute_transactions(2);

  enqueue_transaction(1'b1, 1'b1, TX_CONTROL_IND, '{1{32'h00000003}}, 1'b0, 2'd1); // Send NAK
  execute_transactions(1);
  repeat(4)@(posedge tb_clk);
  #(40*DATA_PERIOD);
  $stop();
  
  //AHB and Transmitter part


end

endmodule

