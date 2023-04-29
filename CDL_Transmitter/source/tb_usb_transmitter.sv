// $Id: $
// File name:   tb_usb_transmitter.sv
// Created:     4/16/2023
// Author:      Te Yu Hsin
// Lab Section: 337-17
// Version:     1.0  Initial Design Entry
// Description: .

`timescale 1ns / 10ps

module tb_usb_transmitter;

localparam CLK_PERIOD = 10;
localparam USB_PERIOD  = 83.3333;
typedef struct {
    logic [3:0] pid;
    logic [7:0] data[];
} testVector;
//*****************************************************************************
// Declare TB Signals (Bus Model Controls)
//*****************************************************************************
string   tb_test_case;
integer  tb_test_case_num;
logic tb_check;
string tb_check_tag;
testVector tb_test_vectors[];

//*****************************************************************************
// General System signals
//*****************************************************************************
logic tb_clk;
logic tb_n_rst;

logic [6:0] tb_buffer_occupancy;
logic [3:0] tb_tx_packet;
logic [7:0] tb_tx_packet_data;
logic tb_get_tx_packet_data;
logic tb_tx_transfer_active;
logic tb_tx_error;
logic tb_d_plus_out;
logic tb_d_minus_out;
logic expected_tx_transfer_active;
logic expected_tx_error;
logic expected_d_plus_out;
logic expected_d_minus_out;

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
usb_transmitter DUT (
    .clk(tb_clk),
    .n_rst(tb_n_rst),
    .buffer_occupancy(tb_buffer_occupancy),
    .tx_packet(tb_tx_packet),
    .tx_packet_data(tb_tx_packet_data),
    .get_tx_packet_data(tb_get_tx_packet_data),
    .tx_transfer_active(tb_tx_transfer_active),
    .tx_error(tb_tx_error),
    .d_plus_out(tb_d_plus_out),
    .d_minus_out(tb_d_minus_out)
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
end
endtask

task check_outputs;
begin
    tb_check    = 1'b1;
    if(tb_tx_transfer_active == expected_tx_transfer_active) begin // Check passed
        $info("Correct 'tx_transfer_active' during %s test case", tb_test_case);
    end
    else begin // Check failed
        $error("Incorrect 'tx_transfer_active' during %s test case", tb_test_case);
    end

    if(tb_tx_error == expected_tx_error) begin // Check passed
        $info("Correct 'tx_error' output %s test case", tb_test_case);
    end
    else begin // Check failed
        $error("Incorrect 'tx_error' output %s test case", tb_test_case);
    end

    if(tb_d_plus_out == expected_d_plus_out) begin // Check passed
        $info("Correct 'd_plus_out' output %s test case", tb_test_case);
    end
    else begin // Check failed
        $error("Incorrect 'd_plus_out' output %s test case", tb_test_case);
    end

    if(tb_d_minus_out == expected_d_minus_out) begin // Check passed
        $info("Correct 'd_minus_out' output %s test case", tb_test_case);
    end
    else begin // Check failed
        $error("Incorrect 'd_minus_out' output %s test case", tb_test_case);
    end
    // Wait some small amount of time so check pulse timing is visible on waves
    #(0.2);
    tb_check =1'b0;
end
endtask

task encoder(logic bit_value);
    if(!bit_value) begin
        expected_d_plus_out = ~expected_d_plus_out;
        expected_d_minus_out = ~expected_d_minus_out;
    end
endtask

task enqueue_transaction;
  input testVector tv;
begin
    int i;
    logic [7:0] data;
    tb_tx_packet = tv.pid;
    tb_tx_packet_data = tv.data.size ? tv.data[0] : 0;
    tb_buffer_occupancy = tv.data.size;
    expected_tx_transfer_active = 1;

    // SYNC
    data = 8'b10000000;
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

    // DATA
    // i = 0;
    // tb_tx_packet_data = 0;
    // while(i < tv.data.size) begin
    //     @(negedge tb_clk);
    //     if (tb_get_tx_packet_data) begin
    //         tb_tx_packet_data = tv.data[i];
    //         tb_buffer_occupancy--;

    //         for(int j = 0; j < 8; j++)begin
    //             encoder(data[j]);
    //             #(USB_PERIOD/2);
    //             check_outputs;
    //             #(USB_PERIOD/2 - 0.1);
    //         end
    //     end
    //     i++;
    // end

    // CHECK DATA 
    if (tb_tx_packet == 4'b0011) begin
        i = 0;
        while(i < tv.data.size) begin
            data = tv.data[i];
            tb_tx_packet_data = tv.data[i];
            #(3);
            for(int j = 0; j < 8; j++)begin
                encoder(data[j]);
                #(USB_PERIOD/2);
                check_outputs;
                #(USB_PERIOD/2 - 0.1);
            end
            tb_buffer_occupancy--;
            i++;
        end
    end

    if ((tb_tx_packet == 4'b0011) || (tb_tx_packet == 4'b0001) || (tb_tx_packet == 4'b1001)|| (tb_tx_packet == 4'b1011)) begin
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

    tb_tx_packet = 0;

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
    expected_tx_transfer_active = 0;
    #(CLK_PERIOD * 4);
    check_outputs;
end
endtask

task enqueue_transaction_vec;
  input testVector tv[];
begin
    int i;
    for(i = 0; i < tv.size; i++) begin
        enqueue_transaction(tv[i]);
    end
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
    tb_buffer_occupancy = 0;
    tb_tx_packet = 0;
    tb_tx_packet_data = 0;
    expected_tx_transfer_active = 0;
    expected_tx_error = 0;
    expected_d_plus_out = 1;
    expected_d_minus_out = 0;

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
    #(USB_PERIOD);

    //*****************************************************************************
    // ACK Test Case
    //*****************************************************************************
    // Update Navigation Info
    tb_test_case     = "ACK";
    tb_test_case_num = tb_test_case_num + 1;

    // Reset the DUT
    reset_dut();

    // Set correct test vector
    tb_test_vectors = new[4];
    tb_test_vectors[0].pid = 4'b0010;

    // Start sending packet
    enqueue_transaction(tb_test_vectors[0]);

    // Give some visual spacing between check and next test case start
    #(USB_PERIOD);

    //*****************************************************************************
    // NAK Test Case
    //*****************************************************************************
    // Update Navigation Info
    tb_test_case     = "NAK";
    tb_test_case_num = tb_test_case_num + 1;

    // Reset the DUT
    reset_dut();

    // Set correct test vector
    tb_test_vectors[1].pid = 4'b1010;

    // Start sending packet
    enqueue_transaction(tb_test_vectors[1]);

    // Give some visual spacing between check and next test case start
    #(USB_PERIOD);

    //*****************************************************************************
    // STALL Test Case
    //*****************************************************************************
    // Update Navigation Info
    tb_test_case     = "STALL";
    tb_test_case_num = tb_test_case_num + 1;

    // Reset the DUT
    reset_dut();

    // Set correct test vector
    tb_test_vectors[2].pid = 4'b1110;

    // Start sending packet
    enqueue_transaction(tb_test_vectors[2]);

    // Give some visual spacing between check and next test case start
    #(USB_PERIOD);

    //*****************************************************************************
    // DATA One byte Test Case
    //*****************************************************************************
    // Update Navigation Info
    tb_test_case     = "DATA  with FOUR byte";
    tb_test_case_num = tb_test_case_num + 1;

    // Reset the DUT
    reset_dut();

    tb_test_vectors = new[1];

    // Set correct test vector
    tb_test_vectors[0].pid = 4'b0011;
    tb_test_vectors[0].data = new[4];
    tb_test_vectors[0].data[0] = 8'b11011101;
    tb_test_vectors[0].data[1] = 8'b11001100;
    tb_test_vectors[0].data[2] = 8'b10111011;
    tb_test_vectors[0].data[3] = 8'b10101010;

    // Start sending packet
    enqueue_transaction(tb_test_vectors[0]);

    // Give some visual spacing between check and next test case start
    #(USB_PERIOD);

    //*****************************************************************************
    // DATA Max byte Test Case
    //*****************************************************************************
    // Update Navigation Info
    tb_test_case     = "DATA  with MAX byte";
    tb_test_case_num = tb_test_case_num + 1;

    // Reset the DUT
    reset_dut();

    tb_test_vectors = new[1];

    // Set correct test vector
    tb_test_vectors[0].pid = 4'b0011;
    tb_test_vectors[0].data = new[64];
    for(int i = 0; i < 64; i++) begin
        tb_test_vectors[0].data[i] = 8'b11110000;       
    end

    // Start sending packet
    enqueue_transaction(tb_test_vectors[0]);

    // Give some visual spacing between check and next test case start
    #(500);

    //*****************************************************************************
    // Get DATA while no data in buffer
    //*****************************************************************************
    // Update Navigation Info
    tb_test_case     = "Get DATA while no data in buffer";
    tb_test_case_num = tb_test_case_num + 1;

    // Reset the DUT
    reset_dut();

    tb_test_vectors = new[1];

    // Set correct test vector
    tb_test_vectors[0].pid = 4'b0011;

    // Start sending packet
    enqueue_transaction(tb_test_vectors[0]);

    // Give some visual spacing between check and next test case start
    #(USB_PERIOD);

    $stop();
end
endmodule