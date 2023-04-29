
`timescale 1ns / 10ps

module tb_ahb_slave_cdl();

// Timing related constants
localparam CLK_PERIOD = 10;
localparam BUS_DELAY  = 800ps; // Based on FF propagation delay

// Sizing related constants
localparam DATA_WIDTH      = 4;
localparam ADDR_WIDTH      = 4;
localparam DATA_WIDTH_BITS = DATA_WIDTH * 8;
localparam DATA_MAX_BIT    = DATA_WIDTH_BITS - 1;
localparam ADDR_MAX_BIT    = ADDR_WIDTH - 1;

// HTRANS Codes
localparam TRANS_IDLE = 2'd0;
localparam TRANS_BUSY = 2'd1;
localparam TRANS_NSEQ = 2'd2;
localparam TRANS_SEQ  = 2'd3;

  // FOR TX PACKET
  localparam OUT   = 4'b0001; //1
  localparam IN    = 4'b1001; //9
  localparam DATA0 = 4'b0011; //3
  localparam DATA1 = 4'b1011; //11
  localparam ACK   = 4'b0010; //2
  localparam NAK   = 4'b1010; //10
  localparam STALL = 4'b1110; //13

// Define our address mapping scheme via constants
localparam ADDR_READ_MIN  = 8'd0;
localparam ADDR_READ_MAX  = 8'd127;
localparam ADDR_WRITE_MIN = 8'd64;
localparam ADDR_WRITE_MAX = 8'd255;

//*****************************************************************************
// Declare TB Signals (Bus Model Controls)
//*****************************************************************************
// Testing setup signals
bit                          tb_enqueue_transaction;
bit                          tb_transaction_write;
bit                          tb_transaction_fake;
bit [3:0]                     tb_transaction_addr;
bit [((DATA_WIDTH*8) - 1):0] tb_transaction_data[];
bit                          tb_transaction_error;
bit [2:0]                    tb_transaction_size;
// Testing control signal(s)
logic    tb_model_reset;
logic    tb_enable_transactions;
integer  tb_current_addr_transaction_num;
integer  tb_current_addr_beat_num;
logic    tb_current_addr_transaction_error;
integer  tb_current_data_transaction_num;
integer  tb_current_data_beat_num;
logic    tb_current_data_transaction_error;

string                 tb_test_case;
integer                tb_test_case_num;
bit   [DATA_MAX_BIT:0] tb_test_data [];
string                 tb_check_tag;
logic                  tb_mismatch;
logic                  tb_check;
integer                tb_i;

//*****************************************************************************
// General System signals
//*****************************************************************************
logic tb_clk;
logic tb_n_rst;

// Expected value check signals
logic                   tb_expected_hresp;
//logic [DATA_MAX_BIT:0]  tb_expected_hrdata;
logic [7:0]             tb_expected_rx_data;
logic                   tb_expected_hready;
logic                   tb_expected_get_rx_data;
logic                   tb_expected_store_tx_data;
logic [7:0]             tb_expected_tx_data;
logic                   tb_expected_clear;
logic [3:0]             tb_expected_tx_packet;
logic                   tb_expected_dmode;

//*****************************************************************************
// AHB-Lite-Slave side signals
//*****************************************************************************
logic                          tb_tx_error;
logic                          tb_clear;
logic                          tb_get_rx_data;
logic                          tb_store_tx_data;
logic [7:0]                    tb_tx_data;
logic [3:0]                    tb_tx_packet;
logic                          tb_d_mode;
logic                          tb_hsel;
logic [1:0]                    tb_htrans;
logic [2:0]                    tb_hburst;
logic [3:0]                    tb_haddr;
logic [2:0]                    tb_hsize;
logic                          tb_hwrite;
logic                          tb_hresp;
logic                          tb_hready;
logic [3:0]                    tb_rx_packet;
logic                          tb_rx_data_ready;
logic                          tb_rx_transfer_active;
logic                          tb_rx_error;
logic [6:0]                    tb_buffer_occupancy;
logic [7:0]                    tb_rx_data;
logic                          tb_tx_transfer_active;
logic [((DATA_WIDTH*8) - 1):0] tb_hwdata;
logic [((DATA_WIDTH*8) - 1):0] tb_hrdata;


//*****************************************************************************
// Clock Generation Block
//*****************************************************************************
// Clock generation block
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
// Bus Model Instance
//*****************************************************************************
ahb_lite_bus_cdl 
                  #(  .DATA_WIDTH(4), .ADDR_WIDTH(4))
                  BFM (.clk(tb_clk),
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
                  .current_addr_transaction_error(tb_current_addr_transaction_error),
                  .current_data_transaction_num(tb_current_data_transaction_num),
                  .current_data_transaction_error(tb_current_data_transaction_error),
                  // AHB-Lite-Slave Side
                  .hsel(tb_hsel),
                  .haddr(tb_haddr),
                  .hsize(tb_hsize),
                  .htrans(tb_htrans),
                  .hwrite(tb_hwrite),
                  .hwdata(tb_hwdata),
                  .hrdata(tb_hrdata),
                  .hresp(tb_hresp),
                  .hready(tb_hready));

//*****************************************************************************
// Test Module Instance
//*****************************************************************************
ahb_slave_cdl DUT ( .clk(tb_clk), .n_rst(tb_n_rst),
                        // AHB-Lite-Slave Side Bus
                        .hsel(tb_hsel),
                        //.haddr({4'b0, tb_haddr}),
                        .haddr(tb_haddr),
                        .htrans(tb_htrans),
                        .hsize(tb_hsize[1:0]),
                        .hwrite(tb_hwrite),
                        .hwdata(tb_hwdata),
                        .rx_packet(tb_rx_packet),
                        .rx_data_ready(tb_rx_data_ready),
                        .rx_transfer_active(tb_rx_transfer_active),
                        .rx_error(tb_rx_error),
                        .buffer_occupancy(tb_buffer_occupancy),
                        .rx_data(tb_rx_data),
                        .tx_transfer_active(tb_tx_transfer_active),
                        .tx_error(tb_tx_error),
                        .hrdata(tb_hrdata),
                        .hresp(tb_hresp),
                        .hready(tb_hready),
                        .dmode(tb_d_mode),
                        .get_rx_data(tb_get_rx_data),
                        .store_tx_data(tb_store_tx_data),
                        .tx_data(tb_tx_data),
                        .clear(tb_clear),
                        .tx_packet(tb_tx_packet));

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

// logic [7:0]             tb_expected_rx_data;
// logic                   tb_expected_hready;
// logic                   tb_expected_get_rx_data;
// logic                   tb_expected_store_tx_data;
// logic                   tb_expected_clear;
// logic [3:0]             tb_expected_tx_packet;
// logic                   tb_expected_dmode;
// logic                   tb_expected_hready;
// logic                   tb_expected_hresp;
// Task to cleanly and consistently check DUT output values
task check_outputs;
  input string check_tag;
begin
  tb_mismatch = 1'b0;
  tb_check    = 1'b1;
   if(tb_expected_tx_packet == tb_tx_packet) begin // Check passed
    $info("Correct 'tx_packet' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'tx_packet' output %s during %s test case", check_tag, tb_test_case);
  end

  if(tb_expected_get_rx_data == tb_get_rx_data) begin // Check passed
    $info("Correct 'get_rx_data' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'get_rx_data' output %s during %s test case", check_tag, tb_test_case);
  end

  if(tb_expected_store_tx_data == tb_store_tx_data) begin // Check passed
    $info("Correct 'store_tx_data' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'store_tx_data' output %s during %s test case", check_tag, tb_test_case);
  end

  // if(tb_expected_hrdata == tb_hrdata) begin // Check passed
  //   $info("Correct 'hrdata' output %s during %s test case", check_tag, tb_test_case);
  // end
  // else begin // Check failed
  //   tb_mismatch = 1'b1;
  //   $error("Incorrect 'hrdata' output %s during %s test case", check_tag, tb_test_case);
  // end

  if(tb_expected_dmode == tb_d_mode) begin // Check passed
    $info("Correct 'dmode' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'dmode' output %s during %s test case", check_tag, tb_test_case);
  end

  if(tb_expected_hresp == tb_hresp) begin // Check passed
    $info("Correct 'hresp' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'hresp' output %s during %s test case", check_tag, tb_test_case);
  end

  if(tb_expected_clear == tb_clear) begin // Check passed
    $info("Correct 'clear' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'clear' output %s during %s test case", check_tag, tb_test_case);
  end


  if(tb_expected_hready == tb_hready) begin // Check passed
    $info("Correct 'hready' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'hready' output %s during %s test case", check_tag, tb_test_case);
  end

  if(tb_expected_tx_data == tb_tx_data) begin // Check passed
    $info("Correct 'tx_data' output %s during %s test case", check_tag, tb_test_case);
  end
  else begin // Check failed
    tb_mismatch = 1'b1;
    $error("Incorrect 'tx_data' output %s during %s test case", check_tag, tb_test_case);
  end

  // Wait some small amount of time so check pulse timing is visible on waves
  #(0.1);
  tb_check =1'b0;
end
endtask

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
  input bit for_dut;
  input bit write_mode;
  input bit [ADDR_MAX_BIT:0] address;
  input bit [DATA_MAX_BIT:0] data[];
  input bit expected_error;
  input bit [1:0] size;
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
task outputs_reset;
begin
tb_expected_hresp           ='0;
//tb_expected_hrdata            ='0;
tb_expected_rx_data           ='0;
tb_expected_get_rx_data           ='0;
tb_expected_store_tx_data           ='0;
tb_expected_tx_data           ='0;
tb_expected_clear           ='0;
tb_expected_tx_packet           ='0;
tb_expected_dmode           ='0;
tb_expected_hready           ='1;
end
endtask

task inputs_reset;
begin
  tb_rx_data_ready        = '0;
  tb_rx_packet            = '0;
  tb_rx_transfer_active   = '0;
  tb_tx_transfer_active   = '0;
  tb_rx_error             = '0;
  tb_tx_error             = '0;
  tb_buffer_occupancy     = '0;
  tb_hresp                = '0;
  tb_hready ='1;
end
endtask
//*****************************************************************************
//*****************************************************************************
// Main TB Process
//*****************************************************************************
//*****************************************************************************
initial begin
  // Initialize Test Case Navigation Signals
  tb_test_case       = "Initialization";
  tb_test_case_num   = -1;
  tb_test_data       = new[1];
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
  tb_transaction_data     = new[1];
  tb_transaction_error    = 1'b0;
  tb_transaction_size     = 3'd0;
  


  // Wait some time before starting first test case
  #(0.1);

  // Clear the bus model
  reset_model();

  //*****************************************************************************
  // Power-on-Reset Test Case
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Power-on-Reset";
  tb_test_case_num = tb_test_case_num + 1;
  tb_rx_data_ready        = '1;
  tb_rx_packet            = '1;
  tb_rx_transfer_active   = '1;
  tb_tx_transfer_active   = '1;
  tb_rx_error             = '1;
  tb_tx_error             = '1;
  tb_buffer_occupancy     = '1;
  // Reset the DUT
  reset_dut();

  outputs_reset();
  tb_expected_dmode = 1'b1;
  tb_expected_hready = 1'b1;
  check_outputs("Power-on-Reset");

  // No actual DUT -> Just a place holder currently
  
    //*****************************************************************************
  // Test Case: Write TX Control Reg
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Write 1 TX Control Reg";
  tb_test_case_num = tb_test_case_num + 1;
  inputs_reset();
  outputs_reset();
  
  // Reset the DUT to isolate from prior test case
  reset_dut();

  tb_test_data = '{1{32'h00000001}};
  enqueue_transaction(1'b1, 1'b1, 12, tb_test_data, 1'b0, 2'd0);
  
  // Run the transactions via the model
  execute_transactions(1);

  // Check the DUT outputs
  tb_expected_tx_packet = 4'b0011;
  tb_expected_hready = 1'b1;
  check_outputs("after Write 1 TX Control Reg");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 2);

  //*****************************************************************************
  // Test Case: Write TX Control Reg
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Write TX 2 Control Reg";
  tb_test_case_num = tb_test_case_num + 1;
  inputs_reset();
  outputs_reset();
  
  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Enqueue the needed transactions (Low Coeff Address => F0, just add 2 x index)
  tb_test_data =  '{1{32'h00000002}};
  enqueue_transaction(1'b1, 1'b1, 12, tb_test_data, 1'b0, 2'd0);
  
  // Run the transactions via the model
  execute_transactions(1);

  // Check the DUT outputs
  tb_expected_tx_packet = 4'b0010;
  tb_expected_hready = 1'b1;
  check_outputs("after Write 2 TX Control Reg");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 2);

  //*****************************************************************************
  // Test Case: Write TX Control Reg
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Write TX 4 Control Reg";
  tb_test_case_num = tb_test_case_num + 1;
  inputs_reset();
  outputs_reset();
  
  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Enqueue the needed transactions (Low Coeff Address => F0, just add 2 x index)
  tb_test_data ='{1{32'h00000004}};
  enqueue_transaction(1'b1, 1'b1, 12, tb_test_data, 1'b0, 2'd0);
  
  // Run the transactions via the model
  execute_transactions(1);

  // Check the DUT outputs
  tb_tx_transfer_active = 1'b1;
  tb_expected_tx_packet = STALL;
  check_outputs("after Write 4 TX Control Reg");

  // Check reset
  repeat(3) @(posedge tb_clk);
  @(negedge tb_clk);
  tb_tx_transfer_active = 1'b0;
  repeat (2) @(posedge tb_clk);
  tb_expected_tx_packet = '0;
  #(BUS_DELAY*3);
  check_outputs("after CLEAR 4 TX Control Reg");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 2);

  //*****************************************************************************
  // Test Case: Write FLUSH
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Write FLUSH";
  tb_test_case_num = tb_test_case_num + 1;
  inputs_reset();
  outputs_reset();
  
  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Enqueue the needed transactions
  tb_buffer_occupancy = 6;
  tb_test_data = '{1{32'h00000100}};
  enqueue_transaction(1'b1, 1'b1, 13, tb_test_data, 1'b0, 2'd0);
  
  // Run the transactions via the model
  execute_transactions(1);

  // Check the DUT outputs
  tb_expected_clear = 1'b1;
  check_outputs("after Write FLUSH");

  // Check reset
  repeat(3) @(posedge tb_clk);
  @(negedge tb_clk);
  tb_buffer_occupancy = '0;
  repeat (2) @(posedge tb_clk);
  #(BUS_DELAY);
  tb_expected_clear = 1'b0;
  check_outputs("after CLEAR FLUSH");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 2);


  //*****************************************************************************
  // Test Case: Write to INVALID ADDR
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Write to INVALID ADDR";
  tb_test_case_num = tb_test_case_num + 1;
  inputs_reset();
  outputs_reset();

  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Enqueue the needed transactions
  tb_test_data = '{1{32'hFFFFFFF3}};
  // Enqueue the write
  enqueue_transaction(1'b1, 1'b1, 4'd15, tb_test_data, 1'b1, 2'd0);
  
  // Run the transactions via the model
  execute_transactions(1);

  // Check the DUT outputs
  check_outputs("Write to INVALID ADDR");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 3);

  //*****************************************************************************
  // Test Case: Write to STATUS ADDR - WRITING TO STAUS ERROR
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Write 1 to STATUS ADDR";
  tb_test_case_num = tb_test_case_num + 1;
  inputs_reset();
  outputs_reset();

  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Enqueue the needed transactions
  tb_test_data = '{1{32'hFFFFFFF3}};
  // Enqueue the write
  enqueue_transaction(1'b1, 1'b1, 5, tb_test_data, 1'b1, 2'd0);
  
  // Run the transactions via the model
  execute_transactions(1);
  tb_expected_hresp = '1;
  // Check the DUT outputs
  check_outputs("Write 1 to STATUS ADDR");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 3);

  //*****************************************************************************
  // Test Case: READ STATUS ADDR
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "READ STATUS NEW DATA";
  tb_test_case_num = tb_test_case_num + 1;
  inputs_reset();
  outputs_reset();

  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Set stimulation
  tb_rx_data_ready = 1'b1;
  // Enqueue the needed transactions
  tb_test_data = '{1{32'h00000001}};
  // Enqueue the write
  enqueue_transaction(1'b1, 1'b0, 5, tb_test_data, 1'b0, 2'd1);
  
  // Run the transactions via the model
  execute_transactions(1);

  // Check the DUT outputs
  check_outputs("READ STATUS NEW DATA");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 2);  

  //*****************************************************************************
  // Test Case: READ STATUS ADDR
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "READ STATUS IN";
  tb_test_case_num = tb_test_case_num + 1;
  inputs_reset();
  outputs_reset();

  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Set stimulation
  tb_rx_packet = IN;
  // Enqueue the needed transactions
  tb_test_data = '{1{32'h00000002}};
  // Enqueue the write
  enqueue_transaction(1'b1, 1'b0, 4, tb_test_data, 1'b0, 2'd1);
  
  // Run the transactions via the model
  execute_transactions(1);

  // Check the DUT outputs
  check_outputs("READ STATUS IN");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 2);  

  //*****************************************************************************
  // Test Case: READ STATUS ADDR
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "READ STATUS ACK";
  tb_test_case_num = tb_test_case_num + 1;
  inputs_reset();
  outputs_reset();

  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Set stimulation
  tb_rx_packet = ACK;
  // Enqueue the needed transactions
  tb_test_data ='{1{32'h00000008}};
  // Enqueue the write
  enqueue_transaction(1'b1, 1'b0, 5, tb_test_data, 1'b0, 2'd1);
  
  // Run the transactions via the model
  execute_transactions(1);

  // Check the DUT outputs
  check_outputs("READ STATUS NEW DATA");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 2);  

  //*****************************************************************************
  // Test Case: READ STATUS ADDR
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "READ STATUS RX";
  tb_test_case_num = tb_test_case_num + 1;
  inputs_reset();
  outputs_reset();

  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Set stimulation
  tb_rx_transfer_active = 1'b1;
  // Enqueue the needed transactions
  tb_test_data = '{1{32'h00000100}};
  // Enqueue the write
  enqueue_transaction(1'b1, 1'b0, 4, tb_test_data, 1'b0, 2'd1);
  
  // Run the transactions via the model
  execute_transactions(1);

  // Check the DUT outputs
  tb_expected_dmode = 1'b1;
  check_outputs("READ STATUS RX");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 2);  

  //*****************************************************************************
  // Test Case: READ STATUS ADDR
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "READ STATUS TX";
  tb_test_case_num = tb_test_case_num + 1;
  inputs_reset();
  outputs_reset();

  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Set stimulation
  tb_tx_transfer_active = 1'b1;
  // Enqueue the needed transactions
  tb_test_data = '{1{32'h00000200}};
  // Enqueue the write
  enqueue_transaction(1'b1, 1'b0, 5, tb_test_data, 1'b0, 2'd1);
  
  // Run the transactions via the model
  execute_transactions(1);

  // Check the DUT outputs
  check_outputs("READ STATUS TX");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 2);  

  //*****************************************************************************
  // Test Case: READ ERROR ADDR
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "READ ERR TX";
  tb_test_case_num = tb_test_case_num + 1;
  inputs_reset();
  outputs_reset();

  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Set stimulation
  tb_tx_error = 1'b1;
  // Enqueue the needed transactions
  tb_test_data = '{1{32'h01000000}};
  // Enqueue the write
  enqueue_transaction(1'b1, 1'b0, 6, tb_test_data, 1'b0, 2'd1);
  
  // Run the transactions via the model
  execute_transactions(1);

  // Check the DUT outputs
  check_outputs("READ ERR TX");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 2);  

  //*****************************************************************************
  // Test Case: READ ERROR ADDR
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "READ ERR RX";
  tb_test_case_num = tb_test_case_num + 1;
  inputs_reset();
  outputs_reset();

  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Set stimulation
  tb_rx_error = 1'b1;
  // Enqueue the needed transactions
  tb_test_data = '{1{32'h00010000}};
  // Enqueue the write
  enqueue_transaction(1'b1, 1'b0, 6, tb_test_data, 1'b0, 2'd1);
  
  // Run the transactions via the model
  execute_transactions(1);

  // Check the DUT outputs
  check_outputs("READ ERR RX");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 2);  

  //*****************************************************************************
  // Test Case: READ BUFFER OCCUPANCY
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "READ BUFFER OCCUPANCY";
  tb_test_case_num = tb_test_case_num + 1;
  inputs_reset();
  outputs_reset();

  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Set stimulation
  tb_buffer_occupancy = 10;
  // Enqueue the needed transactions
  tb_test_data = '{1{32'h0000000A}};
  // Enqueue the write
  enqueue_transaction(1'b1, 1'b0, 8, tb_test_data, 1'b0, 2'd0);
  
  // Run the transactions via the model
  execute_transactions(1);

  // Check the DUT outputs
  check_outputs("READ BUFFER OCCUPANCY");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 2);  

  //*****************************************************************************
  // Test Case: READ 2 ADDR
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "READ 2 STATUS & ERROR";
  tb_test_case_num = tb_test_case_num + 1;
  inputs_reset();
  outputs_reset();

  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Set stimulation
  tb_tx_transfer_active = 1'b1;
  tb_tx_error = 1'b1;
  // Enqueue the needed transactions
  // tb_test_data = ;
  // Enqueue the write
  enqueue_transaction(1'b1, 1'b0, 5, '{1{32'h00000200}}, 1'b0, 2'd1);
  enqueue_transaction(1'b1, 1'b0, 6, '{1{32'h01000000}}, 1'b0, 2'd1);
  // Run the transactions via the model
  execute_transactions(2);

  // Check the DUT outputs
  check_outputs("READ 2 STATUS & ERROR");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 2);  

  //*****************************************************************************
  // Test Case: Write DATA BUFFER
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Write 1 DATA BUFFER";
  tb_test_case_num = tb_test_case_num + 1;
  inputs_reset();
  outputs_reset();
  
  // Reset the DUT to isolate from prior test case
  reset_dut();

  tb_test_data = '{1{32'h00000002}};
  enqueue_transaction(1'b1, 1'b1, 0, tb_test_data, 1'b0, 2'd0);
  
  // Run the transactions via the model
  execute_transactions(1);

  // Check the DUT outputs
  tb_expected_tx_data = 8'h22;
  tb_expected_store_tx_data = 1'b1;
  @(posedge tb_clk);
  check_outputs("Write 1 DATA BUFFER");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 2);

  //*****************************************************************************
  // Test Case: Write DATA BUFFER
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Write 4 DATA BUFFER";
  tb_test_case_num = tb_test_case_num + 1;
  inputs_reset();
  outputs_reset();
  
  // Reset the DUT to isolate from prior test case
  reset_dut();

  tb_test_data = '{1{32'h44332211}};
  enqueue_transaction(1'b1, 1'b1, 0, tb_test_data, 1'b0, 2'd2);
  
  // Run the transactions via the model
  execute_transactions(1);

  // Check the DUT outputs
  tb_expected_store_tx_data = 1'b1;

  tb_expected_tx_data = 8'h11;  
  @(posedge tb_clk);
  check_outputs("Write 4 DATA BUFFER - 1");

  tb_expected_tx_data = 8'h22;  
  @(posedge tb_clk);
  check_outputs("Write 4 DATA BUFFER - 2");

  tb_expected_tx_data = 8'h33;  
  @(posedge tb_clk);
  check_outputs("Write 4 DATA BUFFER - 3");

  tb_expected_tx_data = 8'h44;  
  @(posedge tb_clk);
  check_outputs("Write 4 DATA BUFFER - 4");

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 2);

  //*****************************************************************************
  // Test Case: READ DATA BUFFER
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Read 1 DATA BUFFER";
  tb_test_case_num = tb_test_case_num + 1;
  inputs_reset();
  outputs_reset();
  
  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Set up rx_data from data buffer
  tb_rx_data = 8'h11;

  // Write 1 to the READ_STATUS_REG
  enqueue_transaction(1'b1, 1'b1, 10,'{1{32'h00010000}}, 1'b0, 2'd0);
  // Run the transactions via the model
  execute_transactions(1);

  repeat (2) @(posedge tb_clk);
  enqueue_transaction(1'b1, 1'b0, 10, '{1{32'h00000000}}, 1'b0, 2'd0);
  execute_transactions(1);

  tb_test_data ='{1{32'h00000011}};
  enqueue_transaction(1'b1, 1'b0, 0, tb_test_data, 1'b0, 2'd0);
  execute_transactions(1);  

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 2);

  //*****************************************************************************
  // Test Case: READ DATA BUFFER
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Read 4 DATA BUFFER";
  tb_test_case_num = tb_test_case_num + 1;
  inputs_reset();
  outputs_reset();
  
  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Set up rx_data from data buffer
  tb_rx_data = 8'h22;

  // Write 2 BYTES to the BYTE_IND & READ_STATUS_REG
  enqueue_transaction(1'b1, 1'b1, 10 /*or BYTE_IND*/, '{1{32'h04010000}}, 1'b0, 2'd1);
  // Run the transactions via the model
  execute_transactions(1);

  repeat (5) @(posedge tb_clk);
  enqueue_transaction(1'b1, 1'b0, 10, '{1{32'h00000000}}, 1'b0, 2'd0);
  tb_test_data = '{1{32'h22222222}};
  enqueue_transaction(1'b1, 1'b0, 0, tb_test_data, 1'b0, 2'd2);
  execute_transactions(2);
  $info("DONE");
  

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 2);

  //*****************************************************************************
  // Test Case: READ DATA BUFFER
  //*****************************************************************************
  // Update Navigation Info
  tb_test_case     = "Read 2 DATA BUFFER";
  tb_test_case_num = tb_test_case_num + 1;
  inputs_reset();
  outputs_reset();
  
  // Reset the DUT to isolate from prior test case
  reset_dut();

  // Set up rx_data from data buffer
  tb_rx_data = 8'h22;

  // Write 2 BYTES to the BYTE_IND & READ_STATUS_REG
  enqueue_transaction(1'b1, 1'b1, 10 /*or BYTE_IND*/, '{1{32'h02010000}}, 1'b0, 2'd1);
  // Run the transactions via the model
  execute_transactions(1);

  repeat (5) @(posedge tb_clk);
  enqueue_transaction(1'b1, 1'b0, 10, '{1{32'h00000000}}, 1'b0, 2'd0);
  tb_test_data = '{1{32'h00002222}};
  enqueue_transaction(1'b1, 1'b0, 0, tb_test_data, 1'b0, 2'd2);
  execute_transactions(2);
  $info("DONE");
  

  // Give some visual spacing between check and next test case start
  #(CLK_PERIOD * 2);
  $stop;
end

endmodule