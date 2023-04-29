// $Id: $
// File name:   tb_buffer.sv
// Created:     4/16/2023
// Author:      Te Yu Hsin
// Lab Section: 337-17
// Version:     1.0  Initial Design Entry
// Description: .
`timescale 1ns/10ps

module tb_buffer();

localparam CLK_PERIOD = 10;
typedef struct {
    logic [7:0] data;
    logic tx;
    logic rx;
} testVector;
//*****************************************************************************
// Declare TB Signals (Bus Model Controls)
//*****************************************************************************
string   tb_test_case;
integer  tb_test_case_num;
logic tb_check;
testVector tb_test_vectors[];
logic tb_model_reset;
integer index;

//*****************************************************************************
// General System signals
//*****************************************************************************
logic tb_clk;
logic tb_n_rst;
logic [6:0] tb_buffer_occupancy;
logic tb_store_tx_data;
logic tb_store_rx_packet_data;
logic tb_get_rx_data;
logic tb_get_tx_packet_data;
logic [7:0] tb_tx_data;
logic [7:0] tb_rx_packet_data;
logic tb_clear;
logic tb_flush;
logic [7:0] tb_rx_data;
logic [7:0] tb_tx_packet_data;
logic [6:0] expected_buffer_occupancy;
logic [7:0] expected_data;


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
// DUT Instance
//*****************************************************************************
buffer DUT (
    .clk(tb_clk),
    .n_rst(tb_n_rst),
    .store_tx_data(tb_store_tx_data),
    .store_rx_packet_data(tb_store_rx_packet_data),
    .get_rx_data(tb_get_rx_data),
    .get_tx_packet_data(tb_get_tx_packet_data),
    .tx_data(tb_tx_data),
    .rx_packet_data(tb_rx_packet_data),
    .clear(tb_clear),
    .flush(tb_flush),
    .buffer_occupancy(tb_buffer_occupancy),
    .rx_data(tb_rx_data),
    .tx_packet_data(tb_tx_packet_data)
);

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
  expected_buffer_occupancy = 0;
  index = 0;
end
endtask

task check_outputs;
begin
    tb_check    = 1'b1;
    if(tb_buffer_occupancy == expected_buffer_occupancy) begin // Check passed
        $info("Correct 'buffer_occupancy' during %s test case", tb_test_case);
    end
    else begin // Check failed
        $error("Incorrect 'buffer_occupancy' during %s test case", tb_test_case);
    end
    if (tb_buffer_occupancy) begin
        if ((tb_tx_packet_data != expected_data) || (tb_rx_data != expected_data)) begin
            $error("Incorrect 'data' during %s test case", tb_test_case);
        end
        else begin
            $info("Correct 'data' during %s test case", tb_test_case);
        end
    end
 
    // Wait some small amount of time so check pulse timing is visible on waves
    #(0.1);
    tb_check =1'b0;
end
endtask

task store_test;
    input testVector tv;
begin
    @(negedge tb_clk);
    tb_store_rx_packet_data = tv.rx;
    tb_store_tx_data = tv.tx;
    if (tb_store_tx_data) begin
        tb_tx_data = tv.data;
    end
    if (tb_store_rx_packet_data) begin
        tb_rx_packet_data = tv.data;
    end

    @(posedge tb_clk);
    if (expected_buffer_occupancy < 64) begin
        expected_buffer_occupancy = expected_buffer_occupancy + 1;      
    end
    expected_data = tb_test_vectors[index].data;

    @(negedge tb_clk);
    check_outputs;
    #(0.1)
    tb_store_rx_packet_data = 0;
    tb_store_tx_data = 0;
    //tb_tx_data = 0;
    //tb_rx_packet_data = 0;
end
endtask

task store_stream_test;
    input testVector tv[];
begin
    for (int i = 0; i < tv.size; i++)
    begin
        store_test(tv[i]);
    end
end
endtask

task get_test;
    input testVector tv;
begin
	@(negedge tb_clk);
    tb_get_rx_data = tv.rx;
    tb_get_tx_packet_data = tv.tx;

    @(posedge tb_clk);
    if (expected_buffer_occupancy > 0) begin
        expected_buffer_occupancy = expected_buffer_occupancy - 1;      
    end

    index = (index + 1 ) % tb_test_vectors.size;
    expected_data = tb_test_vectors[index].data;        


    @(negedge tb_clk);
    check_outputs;
    #(0.1)
    tb_get_rx_data = 0;
    tb_get_tx_packet_data = 0;
end
endtask

task get_stream_test;
    input testVector tv[];
begin
    for (int i = 0; i < tv.size; i++) begin
        get_test(tv[i]);
    end
end
endtask

task clear;
    begin
        tb_clear = 1;
        @(posedge tb_clk); // wait for 1 clock cycle
        expected_buffer_occupancy = 0;
        @(negedge tb_clk);
        check_outputs;
        #(0.1)
        tb_clear = 0;
    end
endtask

task flush;
    begin
        tb_flush = 1;
        @(posedge tb_clk); // wait for 1 clock cycle
        expected_buffer_occupancy = 0;
        @(negedge tb_clk);
        check_outputs;
        #(0.1)
        tb_flush = 0;
    end
endtask

//*****************************************************************************
//*****************************************************************************
// Main TB Process
//*****************************************************************************
//*****************************************************************************
initial begin
    // Initialize Test Case Navigation Signals
    tb_test_case       = "Initilization";
    tb_test_case_num   = -1;
    tb_check           = 1'b0;
    // Initialize all of the directly controled DUT inputs
    tb_n_rst          = 1'b1;
    tb_store_tx_data = 0;
    tb_store_rx_packet_data = 0;
    tb_get_rx_data = 0;
    tb_get_tx_packet_data = 0;
    tb_tx_data = 0;
    tb_rx_packet_data = 0;
    tb_flush = 0;
    tb_clear = 0;
    expected_buffer_occupancy = 0;
    index = 0;

    // Wait some time before starting first test case
    #(0.1);

    // Clear the bus model
    reset_dut();

    //*****************************************************************************
    // Power-on-Reset Test Case
    //*****************************************************************************
    // Update Navigation Info
    tb_test_case     = "Power-on-Reset";
    tb_test_case_num = tb_test_case_num + 1;

    // Reset the DUT
    reset_dut();

    // Check outputs for reset state
    check_outputs;

    // Give some visual spacing between check and next test case start
    #(CLK_PERIOD * 3);

    //*****************************************************************************
    // Tx
    //*****************************************************************************
    // Update Navigation Info
    tb_test_case     = "Store and Get Tx One Byte with one more Get at the end";
    tb_test_case_num = tb_test_case_num + 1;
    flush;
    tb_test_vectors = new[1];
    tb_test_vectors[0].data = 1;
    tb_test_vectors[0].tx = 1;
    tb_test_vectors[0].rx = 0;
    store_stream_test(tb_test_vectors);
    get_stream_test(tb_test_vectors);
    get_test(tb_test_vectors[0]);

    tb_test_case     = "Store and Get Tx Max Byte";
    tb_test_case_num = tb_test_case_num + 1;
    clear;
    tb_test_vectors = new[64];
    for (int i = 0; i < 64; i++) begin
        tb_test_vectors[i].data = i;
        tb_test_vectors[i].tx = 1;
        tb_test_vectors[i].rx = 0;
    end

    store_stream_test(tb_test_vectors);
    get_stream_test(tb_test_vectors);

    tb_test_case     = "Store and Get Tx More than Max Byte";
    tb_test_case_num = tb_test_case_num + 1;
    clear;
    tb_test_vectors = new[70];
    for (int i = 0; i < 70; i++) begin
        tb_test_vectors[i].data = i;
        tb_test_vectors[i].tx = 1;
        tb_test_vectors[i].rx = 0;
    end

    store_stream_test(tb_test_vectors);
    get_stream_test(tb_test_vectors);

    //*****************************************************************************
    // Rx
    //*****************************************************************************
    // Update Navigation Info
    tb_test_case     = "Store and Get Rx One Byte";
    tb_test_case_num = tb_test_case_num + 1;
    flush;
    tb_test_vectors = new[1];
    tb_test_vectors[0].data = 1;
    tb_test_vectors[0].tx = 0;
    tb_test_vectors[0].rx = 1;
    store_stream_test(tb_test_vectors);
    get_stream_test(tb_test_vectors);

    tb_test_case     = "Store and Get Rx Max Byte";
    tb_test_case_num = tb_test_case_num + 1;
    clear;
    tb_test_vectors = new[64];
    for (int i = 0; i < 64; i++) begin
        tb_test_vectors[i].data = i;
        tb_test_vectors[i].tx = 0;
        tb_test_vectors[i].rx = 1;
    end

    store_stream_test(tb_test_vectors);
    get_stream_test(tb_test_vectors);

    $stop();
end
endmodule