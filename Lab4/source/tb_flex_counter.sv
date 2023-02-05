// $Id: $
// File name:   tb_flex_counter.sv
// Created:     2/1/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Test Bench for Flex Counter

// 0.5um D-FlipFlop Timing Data Estimates:
// Data Propagation delay (clk->Q): 670ps
// Setup time for data relative to clock: 190ps
// Hold time for data relative to clock: 10ps
`timescale 1ns / 10 ps

module tb_flex_counter();

  localparam  CLK_PERIOD    = 2.5;
  localparam  FF_SETUP_TIME = 0.190;
  localparam  FF_HOLD_TIME  = 0.100;
  localparam  CHECK_DELAY   = (CLK_PERIOD - FF_SETUP_TIME); // Check right before the setup time starts

  localparam  INACTIVE_VALUE     = 1'b0;
  localparam  RESET_OUTPUT_VALUE = INACTIVE_VALUE;
  localparam  CLEAR_OUTPUT_VALUE = INACTIVE_VALUE;
  localparam  ROLLOVER_FLAG_0 = 1'b0;
  localparam  ROLLOVER_FLAG_1 = 1'b1;
  localparam  ROLLOVER_VALUE = 15;

  localparam  NUM_CNT_BITS = 4;
  // Declare DUT portmap signals
  reg tb_clk;
  reg tb_n_rst;
  reg tb_clear;
  reg tb_count_enable;
  reg [NUM_CNT_BITS-1:0] tb_rollover_val;
  wire [NUM_CNT_BITS-1:0] tb_count_out;
  wire tb_rollover_flag;

  // Declare test bench signals
  integer tb_test_num;
  string tb_test_case;
  integer tb_stream_test_num;
  string tb_stream_check_tag;
  integer dummy;

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
    input logic  [NUM_CNT_BITS-1:0] expected_countout;
    input logic  expected_rollover_flag;
    input string check_tag;
  begin
    if(expected_countout == tb_count_out) begin // Check passed
      $info("Correct counter output %s during %s test case", check_tag, tb_test_case);
    end
    else begin // Check failed
      $error("Incorrect counter output %s during %s test case", check_tag, tb_test_case);
    end
    if(expected_rollover_flag == tb_rollover_flag) begin // Check passed
      $info("Correct rollover flag %s during %s test case", check_tag, tb_test_case);
    end
    else begin // Check failed
      $error("Incorrect rollover flag %s during %s test case", check_tag, tb_test_case);
    end
  end
  endtask

  task clear_DUT;
  begin
    // Activate the clear
    tb_clear = 1'b1;
    
    // Maintain the clear for one cycle
    @(posedge tb_clk);

    // Wait until safely away from rising edge of the clock before releasing
    @(negedge tb_clk);
    tb_clear = 1'b0;
  end
  endtask  

  // Clock generation block
  always
  begin
    // Start with clock low to avoid false rising edge events at t=0
    tb_clk = 1'b0;
    // Wait half of the clock period before toggling clock value (maintain 50% duty cycle)
    #(CLK_PERIOD/2.0);
    tb_clk = 1'b1;
    // Wait half of the clock period before toggling clock value via rerunning the block (maintain 50% duty cycle)
    #(CLK_PERIOD/2.0);
  end

  // DUT Port map
  flex_counter DUT(.clk(tb_clk), .n_rst(tb_n_rst), .clear(tb_clear), .count_enable(tb_count_enable), .rollover_val(tb_rollover_val), .count_out(tb_count_out),
                     .rollover_flag(tb_rollover_flag));

  // Test bench main process
  initial
  begin
    // Initialize all of the test inputs
    tb_n_rst  = 1'b1;              // Initialize to be inactive
    tb_clear = 1'b0;               // Initialize to be inactive
    tb_count_enable = 1'b0;        // Initialize to be inactive
    tb_rollover_val = ROLLOVER_VALUE;  // Initialize to set rollover value = ROLLOVER_VALUE
    tb_test_num = 0;               // Initialize test case counter
    tb_test_case = "Test bench initializaton";
    tb_stream_test_num = 0;
    tb_stream_check_tag = "N/A";
    // Wait some time before starting first test case
    #(0.1);
    // ************************************************************************
    // Test Case 1: Power-on Reset of the DUT
    // ************************************************************************
    tb_test_num = tb_test_num + 1;
    tb_test_case = "Power on Reset";
    // Note: Do not use reset task during reset test case since we need to specifically check behavior during reset
    // Wait some time before applying test case stimulus
    #(0.1);
    // Apply test case initial stimulus
    tb_count_enable = INACTIVE_VALUE; // Set to not enable counter
    tb_clear = INACTIVE_VALUE;  // Set to not clear
    tb_n_rst  = 1'b0;    // Activate reset
    
    // Wait for a bit before checking for correct functionality
    #(CLK_PERIOD * 0.5);

    // Check that internal state was correctly reset
    check_output( RESET_OUTPUT_VALUE, ROLLOVER_FLAG_0,
                  "after reset applied");
    
    // Check that the reset value is maintained during a clock cycle
    #(CLK_PERIOD);
    check_output( RESET_OUTPUT_VALUE, ROLLOVER_FLAG_0, 
                  "after clock cycle while in reset");
    
    // Release the reset away from a clock edge
    @(posedge tb_clk);
    #(2 * FF_HOLD_TIME);
    tb_n_rst  = 1'b1;   // Deactivate the chip reset
    #0.1;
    tb_count_enable = 1'b1; // Enable the counter
    // Check that internal state was correctly keep after reset release
    check_output( RESET_OUTPUT_VALUE, ROLLOVER_FLAG_0, 
                  "after reset was released");

    // ************************************************************************
    // Test Case 2: Rollover for a rollover value that is not a power of two
    // ************************************************************************
    @(negedge tb_clk); 
    tb_test_num = tb_test_num + 1;
    tb_test_case = "Rollover for a rollover value that is not a power of two";
    // Start out with inactive value of counter_enable and clear and reset the DUT to isolate from prior tests
    tb_count_enable = INACTIVE_VALUE;
    tb_clear = INACTIVE_VALUE;
    reset_dut();

    // Enable the counter and start the test case
    tb_count_enable = 1'b1;
    @(posedge tb_clk); 
    #((ROLLOVER_VALUE-1) * CLK_PERIOD);
    // Move away from risign edge and allow for propagation delays before checking
    #(CHECK_DELAY);
    // Check results
    check_output( ROLLOVER_VALUE, ROLLOVER_FLAG_1, 
                  "after running ROLLOVER VALUE times");
    // After a rising edge, counter should be rollover to 1
    @(posedge tb_clk);
    // Move away from risign edge and allow for propagation delays before checking
    #(CHECK_DELAY);
    // Check results
    check_output( 1'b1, ROLLOVER_FLAG_0, 
                  "after rollover to 1");

    // ************************************************************************
    // Test Case 3: Continuous counting
    // ************************************************************************
    @(negedge tb_clk); 
    tb_test_num = tb_test_num + 1;
    tb_test_case = "Continuous counting";
    // Start out with inactive value of counter_enable and clear and reset the DUT to isolate from prior tests
    tb_count_enable = INACTIVE_VALUE;
    tb_clear = INACTIVE_VALUE;
    reset_dut();

    // Enable the counter and start the test case
    tb_count_enable = 1'b1;
    for(tb_stream_test_num = 1; tb_stream_test_num <= 29; tb_stream_test_num = tb_stream_test_num + 1)
    begin
      // Update the tag for the current stream iteration
      $sformat(tb_stream_check_tag, "after continuous iteration %d", tb_stream_test_num);
      // Allow second stage to pull decayed value
      @(posedge tb_clk);
      // Move away from risign edge and allow for propagation delays before checking 
      #(CHECK_DELAY);
      if((tb_stream_test_num%ROLLOVER_VALUE) == 0)
      begin
        check_output(ROLLOVER_VALUE, ROLLOVER_FLAG_1, tb_stream_check_tag);
      end
      else
      begin
        check_output(tb_stream_test_num%ROLLOVER_VALUE, ROLLOVER_FLAG_0, tb_stream_check_tag);
      end
    end

    // ************************************************************************
    // Test Case 4: Discontinuous counting
    // ************************************************************************
    @(negedge tb_clk); 
    tb_test_num = tb_test_num + 1;
    tb_test_case = "Discontinuous counting";
    // Start out with inactive value of counter_enable and clear and reset the DUT to isolate from prior tests
    tb_count_enable = INACTIVE_VALUE;
    tb_clear = INACTIVE_VALUE;
    reset_dut();

    // Enable the counter and start the test case
    tb_count_enable = 1'b1;
    dummy = 0;
    for(tb_stream_test_num = 1; tb_stream_test_num <= 29; tb_stream_test_num = tb_stream_test_num + 1)
    begin
      if(((tb_stream_test_num%2) == 0) || ((tb_stream_test_num%3) == 0)) // Counter is enabled
      begin
        tb_count_enable = 1'b1;
        // Update the tag for the current stream iteration
        $sformat(tb_stream_check_tag, "after enable iteration %d", tb_stream_test_num);
        @(posedge tb_clk);
        dummy = dummy + 1;
        // Move away from risign edge and allow for propagation delays before checking 
        @(negedge tb_clk);
        if(((dummy%ROLLOVER_VALUE) == 0) && (dummy != 0))
        begin
          check_output(ROLLOVER_VALUE, ROLLOVER_FLAG_1, tb_stream_check_tag);
        end
        else
        begin
          check_output(dummy%ROLLOVER_VALUE, ROLLOVER_FLAG_0, tb_stream_check_tag);
        end
      end
      else // Counter is disabled
      begin
        tb_count_enable = 1'b0;
        // Update the tag for the current stream iteration
        $sformat(tb_stream_check_tag, "after disable iteration %d", tb_stream_test_num);
        @(posedge tb_clk);
        // Move away from risign edge and allow for propagation delays before checking 
        @(negedge tb_clk);
        if(((dummy%ROLLOVER_VALUE) == 0) && (dummy != 0))
        begin
          check_output(ROLLOVER_VALUE, ROLLOVER_FLAG_1, tb_stream_check_tag);
        end
        else
        begin
          check_output(dummy%ROLLOVER_VALUE, ROLLOVER_FLAG_0, tb_stream_check_tag);
        end
      end
    end

    // ************************************************************************
    // Test Case 5: Clearing while counting to check clear vs. count enable priority
    // ************************************************************************
    @(negedge tb_clk); 
    tb_test_num = tb_test_num + 1;
    tb_test_case = "Clearing while counting to check clear vs. count enable priority";
    // Start out with inactive value of counter_enable and clear and reset the DUT to isolate from prior tests
    tb_count_enable = INACTIVE_VALUE;
    tb_clear = INACTIVE_VALUE;
    reset_dut();

    // Enable the counter and start the test case
    tb_count_enable = 1'b1;
    dummy = 0;
    for(tb_stream_test_num = 1; tb_stream_test_num <= (ROLLOVER_VALUE)/2; tb_stream_test_num = tb_stream_test_num + 1)
    begin
      @(posedge tb_clk);
      dummy = dummy + 1;
      // Move away from risign edge and allow for propagation delays before checking 
    end
    @(negedge tb_clk);
    check_output( dummy, ROLLOVER_FLAG_0, "after running (ROLLOVER_VALUE)/2 times");
    clear_DUT();
    if(tb_count_out == 0)
    begin
      $info("Clear has higher priority than counter_enable",dummy);
    end
    else
    begin
      $info("Counter_enable has higher priority than clear",dummy);
    end



    // ************************************************************************
    // Test Case 6: For 100 % automated grading
    // ************************************************************************
    @(negedge tb_clk); 
    tb_rollover_val = 0;
    tb_test_num = tb_test_num + 1;
    tb_test_case = "For 100 percent automated grading";
    // Start out with inactive value of counter_enable and clear and reset the DUT to isolate from prior tests
    tb_count_enable = INACTIVE_VALUE;
    tb_clear = INACTIVE_VALUE;
    tb_stream_test_num = 0;
    dummy = 8'hFFFFFFFF;
    tb_clear = 1;
    reset_dut();
    tb_clear = 0;
    tb_rollover_val = ROLLOVER_VALUE;
    tb_stream_test_num = 1;
    // Enable the counter and start the test case
    tb_count_enable = 1'b1;
    dummy = 0;
    for(tb_stream_test_num = 1; tb_stream_test_num <= 8'hFFFFFFFF; tb_stream_test_num = tb_stream_test_num + 1)
    begin
      if(((tb_stream_test_num%2) == 0) || ((tb_stream_test_num%3) == 0)) // Counter is enabled
      begin
        tb_count_enable = 1'b1;
        // Update the tag for the current stream iteration
        $sformat(tb_stream_check_tag, "after enable iteration %d", tb_stream_test_num);
        @(posedge tb_clk);
        dummy = dummy + 1;
        // Move away from risign edge and allow for propagation delays before checking 
        @(negedge tb_clk);
        if(((dummy%ROLLOVER_VALUE) == 0) && (dummy != 0))
        begin
          check_output(dummy%ROLLOVER_VALUE, ROLLOVER_FLAG_0, tb_stream_check_tag);
        end
        else
        begin
          check_output(ROLLOVER_VALUE, ROLLOVER_FLAG_1, tb_stream_check_tag);
        end
      end
      else // Counter is disabled
      begin
        tb_count_enable = 1'b0;
        // Update the tag for the current stream iteration
        $sformat(tb_stream_check_tag, "after disable iteration %d", tb_stream_test_num);
        @(posedge tb_clk);
        // Move away from risign edge and allow for propagation delays before checking 
        @(negedge tb_clk);
        if(((dummy%ROLLOVER_VALUE) == 0) && (dummy != 0))
        begin
          check_output(ROLLOVER_VALUE, ROLLOVER_FLAG_1, tb_stream_check_tag);
        end
        else
        begin
          check_output(dummy%ROLLOVER_VALUE, ROLLOVER_FLAG_0, tb_stream_check_tag);
        end
      end
    end

  end
endmodule