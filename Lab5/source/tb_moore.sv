// $Id: $
// File name:   tb_moore.sv
// Created:     2/10/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Test Bench for moore 1101 detector

`timescale 1ns / 10ps

module tb_moore();
  // Define parameters
  // Common parameters
  localparam CLK_PERIOD        = 2.5;
  localparam PROPAGATION_DELAY = 0.8; // Allow for 800 ps for FF propagation delay
  localparam  INACTIVE_VALUE     = 1'b1;
  localparam  RESET_OUTPUT_VALUE = 1'b0;

  // Declare Test Case Signals
  integer tb_test_num;
  string  tb_test_case;
  string  tb_stream_check_tag;
  integer tb_bit_num;
  integer tb_curr_bit_index;
  logic   tb_mismatch;
  logic   tb_check;

  // Declare the Test Bench Signals for Expected Results
  logic                tb_expected_ouput;
  logic          [3:0] tb_test_data;

  // Declare DUT Connection Signals
  logic                tb_clk;
  logic                tb_n_rst;
  logic                tb_i;
  logic                tb_o;
  
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
  end
  endtask

  // Task to cleanly and consistently check DUT output values
  task check_output;
    input string check_tag;
  begin
    tb_mismatch = 1'b0;
    tb_check    = 1'b1;
    if(tb_expected_ouput == tb_o) begin // Check passed
      $info("Correct output %s during %s test case", check_tag, tb_test_case);
    end
    else begin // Check failed
      tb_mismatch = 1'b1;
      $error("Incorrect output %s during %s test case", check_tag, tb_test_case);
    end

    // Wait some small amount of time so check pulse timing is visible on waves
    #(0.1);
    tb_check =1'b0;
  end
  endtask

  // Task to run four cycle and check the output
  task four_cycles;
    input logic [3:0] test;
    input logic [3:0] test_o;
  begin
    // Synchronize to the negative edge of clock to prevent timing errors
    for(tb_bit_num = 0; tb_bit_num < 4; tb_bit_num++) begin
      // Update the test data
      tb_curr_bit_index = (3 - tb_bit_num);
      tb_i = test[tb_curr_bit_index];
      // Check that the correct value was sent out for this bit
      $sformat(tb_stream_check_tag, "during bit %0d", tb_bit_num);
      @ (negedge tb_clk);
      tb_expected_ouput = test_o[tb_curr_bit_index];
      check_output(tb_stream_check_tag);
    end
  end
  endtask

  // Task to run a cycle and check the output
  task one_cycle;
    input logic test;
    input logic expected_o;
    input string check;
  begin
    tb_i = test;
    // Synchronize to the negative edge of clock to prevent timing errors
    @(negedge tb_clk); 
    tb_expected_ouput = expected_o;
    check_output(check);
  end
  endtask

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

  // DUT Portmap
  moore DUT (.clk(tb_clk), .n_rst(tb_n_rst),
                .i(tb_i),
                .o(tb_o));

  // Test bench main process
  initial begin
    // Initialize all of the test inputs
    tb_n_rst            = 1'b1; // Initialize to be inactive
    tb_i      = 1'b0;   // Initialize to be reset value
    tb_test_num         = 0;    // Initialize test case counter
    tb_test_case        = "Test bench initializaton";
    tb_stream_check_tag = "N/A";
    tb_bit_num          = -1;   // Initialize to invalid number
    tb_curr_bit_index   = -1;   // Initialize to invalid number
    tb_mismatch         = 1'b0;
    tb_check            = 1'b0;
    // Wait some time before starting first test case
    #(0.1);

    // ************************************************************************
    // Test Case 1: Power-on Reset of the DUT
    // ************************************************************************
    tb_test_num  = tb_test_num + 1;
    tb_test_case = "Power on Reset";
    // Note: Do not use reset task during reset test case since we need to specifically check behavior during reset
    // Wait some time before applying test case stimulus
    #(0.1);
    // Apply test case initial stimulus (non-reset value parralel input)
    tb_n_rst       = 1'b0;

    // Wait for a bit before checking for correct functionality
    #(CLK_PERIOD * 0.5);

    // Check that internal state was correctly reset
    tb_expected_ouput = RESET_OUTPUT_VALUE;
    check_output("after reset applied");

    // Check that the reset value is maintained during a clock cycle
    #(CLK_PERIOD);
    check_output("after clock cycle while in reset");
    
    // Release the reset away from a clock edge
    @(negedge tb_clk);
    tb_n_rst  = 1'b1;   // Deactivate the chip reset
    // Check that internal state was correctly keep after reset release
    #(PROPAGATION_DELAY);
    check_output("after reset was released");

    // ************************************************************************
    // Test Case 2: Normal Operation with Correct order of bits and another 0
    // ************************************************************************
    tb_test_num  = tb_test_num + 1;
    tb_test_case = "Correct order of bits with a 0";
    // Start out with inactive value and reset the DUT to isolate from prior tests
    tb_i = 1'b0;
    reset_dut();

    // Define the test data stream for this test case
    tb_test_data = 4'b1101;

    // Define the expected result
    tb_expected_ouput = 1'b1;

    // Contiguously stream a full bits of correct order (Output checking handled in task)
    four_cycles(tb_test_data,4'b0001);
    tb_i = 1'b0;
    @(negedge tb_clk);
    tb_expected_ouput = RESET_OUTPUT_VALUE;
    check_output("after a full order of 1101 with another 0");

    // ************************************************************************
    // Test Case 3: Normal Operation with Correct order of bits and another 3'b101
    // ************************************************************************
    tb_test_num  = tb_test_num + 1;
    tb_test_case = "Correct order of bits with a 3'b101";
    // Start out with inactive value and reset the DUT to isolate from prior tests
    tb_i = 1'b0;
    reset_dut();

    // Define the test data stream for this test case
    tb_test_data = 4'b1101;

    // Define the expected result
    tb_expected_ouput = 1'b1;

    // Contiguously stream a full bits of correct order (Output checking handled in task)
    four_cycles(tb_test_data,4'b0001);
    one_cycle(1'b1,1'b0,"after a full order of 1101 with another 1'b1");
    one_cycle(1'b0,1'b0,"after a full order of 1101 with another 2'b10");
    one_cycle(1'b1,1'b1,"after a full order of 1101 with another 3'b101");

    // ************************************************************************
    // Test Case 4: Normal Operation with 4'b0000
    // ************************************************************************
    tb_test_num  = tb_test_num + 1;
    tb_test_case = "Inputs 4 bits 0000";
    // Start out with inactive value and reset the DUT to isolate from prior tests
    tb_i = 1'b0;
    reset_dut();

    // Define the test data stream for this test case
    tb_test_data = 4'b0000;

    // Define the expected result
    tb_expected_ouput = 1'b1;

    // Contiguously stream a full bits of correct order (Output checking handled in task)
    four_cycles(tb_test_data, 4'b0000);

    // ************************************************************************
    // Test Case 5: Normal Operation with 4'b1010
    // ************************************************************************
    tb_test_num  = tb_test_num + 1;
    tb_test_case = "Inputs 4 bits 1010";
    // Start out with inactive value and reset the DUT to isolate from prior tests
    tb_i = 1'b0;
    reset_dut();

    // Define the test data stream for this test case
    tb_test_data = 4'b1010;

    // Define the expected result
    tb_expected_ouput = 1'b1;

    // Contiguously stream a full bits of correct order (Output checking handled in task)
    four_cycles(tb_test_data, 4'b0000);

    // ************************************************************************
    // Test Case 6: Normal Operation with 4'b1111
    // ************************************************************************
    tb_test_num  = tb_test_num + 1;
    tb_test_case = "Inputs 4 bits 1111";
    // Start out with inactive value and reset the DUT to isolate from prior tests
    tb_i = 1'b0;
    reset_dut();

    // Define the test data stream for this test case
    tb_test_data = 4'b1111;

    // Define the expected result
    tb_expected_ouput = 1'b1;

    // Contiguously stream a full bits of correct order (Output checking handled in task)
    four_cycles(tb_test_data, 4'b0000);

    // ************************************************************************
    // Test Case 7: Normal Operation with 4'b1100
    // ************************************************************************
    tb_test_num  = tb_test_num + 1;
    tb_test_case = "Inputs 4 bits 1100";
    // Start out with inactive value and reset the DUT to isolate from prior tests
    tb_i = 1'b0;
    reset_dut();

    // Define the test data stream for this test case
    tb_test_data = 4'b1100;

    // Define the expected result
    tb_expected_ouput = 1'b1;

    // Contiguously stream a full bits of correct order (Output checking handled in task)
    four_cycles(tb_test_data, 4'b0000);

    // ************************************************************************
    // Test Case 8: Normal Operation with 4'b1101 with incorrect expected output
    // ************************************************************************
    tb_test_num  = tb_test_num + 1;
    tb_test_case = "Inputs 4 bits 1101 with incorrect expected output";
    // Start out with inactive value and reset the DUT to isolate from prior tests
    tb_i = 1'b0;
    reset_dut();

    // Define the test data stream for this test case
    tb_test_data = 4'b1101;

    // Define the expected result
    tb_expected_ouput = 1'b1;

    // Contiguously stream a full bits of correct order (Output checking handled in task)
    four_cycles(tb_test_data, 4'b1110);
  end
endmodule
