// $Id: $
// File name:   tb_timer.sv
// Created:     2/18/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Test Bench for Timer

`timescale 1ns / 10ps

module tb_timer();
  // Define parameters
  // Common parameters
  localparam CLK_PERIOD        = 2.5;
  localparam PROPAGATION_DELAY = 0.8; // Allow for 800 ps for FF propagation delay
  localparam  INACTIVE_VALUE     = 1'b1;
  localparam  RESET_OUTPUT_VALUE = 1'b0;

  // Declare Test Case Signals
  integer tb_test_num;
  string  tb_test_case;
  logic   tb_mismatch;
  logic   tb_check;
  string  tb_stream_check_tag;
  integer tb_bit_num;
  integer tb_cycle_num;

  // Declare the Test Bench Signals for Expected Results
  logic                tb_expected_ouput;

  // Declare DUT Connection Signals
  logic                tb_clk;
  logic                tb_n_rst;
  logic                tb_enable_timer;
  logic                tb_shift_strobe;
  logic                tb_packet_done;
  
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
    input integer tb_case;
  begin
    tb_mismatch = 1'b0;
    tb_check    = 1'b1;
    if(tb_case == 0) begin // tb_shift_strobe
        if(tb_expected_ouput == tb_shift_strobe) begin // Check passed
            $info("Correct output %s during %s test case", check_tag, tb_test_case);
        end
        else begin // Check failed
            tb_mismatch = 1'b1;
            $error("Incorrect output %s during %s test case", check_tag, tb_test_case);
        end
    end
    else begin // tb_packet_done
        if(tb_expected_ouput == tb_packet_done) begin // Check passed
            $info("Correct output %s during %s test case", check_tag, tb_test_case);
        end
        else begin // Check failed
            tb_mismatch = 1'b1;
            $error("Incorrect output %s during %s test case", check_tag, tb_test_case);
        end
    end
    // Wait some small amount of time so check pulse timing is visible on waves
    #(0.1);
    tb_check =1'b0;
  end
  endtask

  task data_count;
  begin
    // Synchronize to the negative edge of clock to prevent timing errors
    for(tb_bit_num = 0; tb_bit_num < 98; tb_bit_num++) begin
      @ (negedge tb_clk);
    end
  end
  endtask

  // Task to run a cycle and check the output
  task one_cycle;
  begin
    for(tb_bit_num = 0; tb_bit_num < 10; tb_bit_num++) begin
      @ (negedge tb_clk);
    end
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
  timer DUT (.clk(tb_clk), .n_rst(tb_n_rst),
                .enable_timer(tb_enable_timer),
                .shift_strobe(tb_shift_strobe),
                .packet_done(tb_packet_done));

  // Test bench main process
  initial begin
    // Initialize all of the test inputs
    tb_n_rst            = 1'b1; // Initialize to be inactive
    tb_enable_timer     = 1'b0;
    tb_test_num         = 0;    // Initialize test case counter
    tb_test_case        = "Test bench initializaton";
    tb_stream_check_tag = "N/A";
    tb_bit_num          = 0;
    tb_cycle_num        = 0;
    tb_mismatch         = 1'b0;
    tb_check            = 1'b0;
    // Wait some time before starting first test case
    #(0.1);

    // ************************************************************************
    // Test Case 1: Check Shift Strobe
    // ************************************************************************
    tb_test_num  = tb_test_num + 1;
    tb_test_case = "Check Shift Strobe";
    // Note: Do not use reset task during reset test case since we need to specifically check behavior during reset
    // Wait some time before applying test case stimulus
    #(0.1);
    // Apply test case initial stimulus (non-reset value parralel input)
    reset_dut();
    tb_enable_timer = 1'b1;
    @(negedge tb_clk);
    tb_enable_timer = 1'b0;
    @(negedge tb_clk);
    tb_expected_ouput = 1'b1;
    for(tb_cycle_num = 0; tb_cycle_num < 9;tb_cycle_num++) begin
        one_cycle();
        $sformat(tb_stream_check_tag, "during clk_count %0d", tb_cycle_num + 1);
        check_output(tb_stream_check_tag,0);
    end

    // ************************************************************************
    // Test Case 2: Check Packet_Done
    // ************************************************************************
    tb_test_num  = tb_test_num + 1;
    tb_test_case = "Check Packet_Done";
    // Start out with inactive value and reset the DUT to isolate from prior tests
    reset_dut();
    tb_enable_timer = 1'b1;
    @(negedge tb_clk);
    tb_enable_timer = 1'b0;
    @(negedge tb_clk);
    data_count();
    @(negedge tb_clk);
    check_output("packet_done = 1",1);
  end
endmodule
