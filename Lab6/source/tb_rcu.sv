// $Id: $
// File name:   tb_rcu.sv
// Created:     2/18/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Test Bench for RCU

`timescale 1ns / 10ps

module tb_rcu();
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

  // Declare the Test Bench Signals for Expected Results
  logic                tb_expected_ouput;

  // Declare DUT Connection Signals
  logic                tb_clk;
  logic                tb_n_rst;
  logic                tb_new_packet_detected;
  logic                tb_packet_done;
  logic                tb_framing_error;
  logic                tb_sbc_clear;
  logic                tb_sbc_enable;
  logic                tb_load_buffer;
  logic                tb_enable_timer;
  
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
    input integer tb_outputcase;
  begin
    tb_mismatch = 1'b0;
    tb_check    = 1'b1;
    if(tb_outputcase == 0) begin // 0: SBC_Enable
        if(tb_expected_ouput == tb_sbc_enable) begin // Check passed
            $info("Correct output %s during %s test case", check_tag, tb_test_case);
        end
        else begin // Check failed
            tb_mismatch = 1'b1;
            $error("Incorrect output %s during %s test case", check_tag, tb_test_case);
        end
    end
    else if(tb_outputcase == 1) begin // 1: SBC_Clear
        if(tb_expected_ouput == tb_sbc_clear) begin // Check passed
            $info("Correct output %s during %s test case", check_tag, tb_test_case);
        end
        else begin // Check failed
            tb_mismatch = 1'b1;
            $error("Incorrect output %s during %s test case", check_tag, tb_test_case);
        end
    end
    else if(tb_outputcase == 2) begin // 2: Enable_Timer
        if(tb_expected_ouput == tb_enable_timer) begin // Check passed
            $info("Correct output %s during %s test case", check_tag, tb_test_case);
        end
        else begin // Check failed
            tb_mismatch = 1'b1;
            $error("Incorrect output %s during %s test case", check_tag, tb_test_case);
        end
    end
    else begin// 3: Load_Buffer
        if(tb_expected_ouput == tb_load_buffer) begin // Check passed
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
  rcu DUT (.clk(tb_clk), .n_rst(tb_n_rst),
                .new_packet_detected(tb_new_packet_detected),
                .packet_done(tb_packet_done),
                .framing_error(tb_framing_error),
                .sbc_clear(tb_sbc_clear),
                .sbc_enable(tb_sbc_enable),
                .load_buffer(tb_load_buffer),
                .enable_timer(tb_enable_timer));

  // Test bench main process
  initial begin
    // Initialize all of the test inputs
    tb_n_rst            = 1'b1; // Initialize to be inactive
    tb_new_packet_detected    = 1'b0;
    tb_packet_done      = 0;
    tb_framing_error    = 0;
    tb_test_num         = 0;    // Initialize test case counter
    tb_test_case        = "Test bench initializaton";
    tb_mismatch         = 1'b0;
    tb_check            = 1'b0;
    // Wait some time before starting first test case
    #(0.1);

    // ************************************************************************
    // Test Case 1: Full cycle of state with no frame error
    // ************************************************************************
    tb_test_num  = tb_test_num + 1;
    tb_test_case = "Full cycle of state with no frame error";
    // Note: Do not use reset task during reset test case since we need to specifically check behavior during reset
    // Wait some time before applying test case stimulus
    #(0.1);
    reset_dut();
    tb_new_packet_detected = 1;
    @(negedge tb_clk);
    // Check that internal state was correctly reset
    tb_expected_ouput = 1'b1;
    check_output("after reset applied and after a cycle with new_pkt = 1", 1);
    // Check that the reset value is maintained during a clock cycle
    tb_new_packet_detected =  0;
    @(negedge tb_clk);
    check_output("after one clock cycle to state WAIT1",2);
    // Release the reset away from a clock edge
    @(negedge tb_clk);
    @(negedge tb_clk);
    @(negedge tb_clk);
    @(negedge tb_clk);
    @(negedge tb_clk);
    tb_packet_done = 1;
    #(CLK_PERIOD);
    check_output("after six clock cycle to state DONE",0);
    tb_packet_done = 0;
    tb_framing_error = 0;
    @(negedge tb_clk);
    check_output("after a clock cycle to state LOAD",3);
    @(negedge tb_clk);
    // ************************************************************************
    // Test Case 2: Full cycle of state with frame error
    // ************************************************************************
    tb_test_num  = tb_test_num + 1;
    tb_test_case = "Full cycle of state with frame error";
    // Start out with inactive value and reset the DUT to isolate from prior tests
    reset_dut();
    tb_new_packet_detected = 1;
    @(negedge tb_clk);
    // Check that internal state was correctly reset
    tb_expected_ouput = 1'b1;
    check_output("after reset applied and after a cycle with new_pkt = 1", 1);
    // Check that the reset value is maintained during a clock cycle
    tb_new_packet_detected =  0;
    @(negedge tb_clk);
    check_output("after one clock cycle to state WAIT1",2);
    // Release the reset away from a clock edge
    @(negedge tb_clk);
    @(negedge tb_clk);
    @(negedge tb_clk);
    @(negedge tb_clk);
    @(negedge tb_clk);
    tb_packet_done = 1;
    #(CLK_PERIOD);
    check_output("after six clock cycle to state DONE",0);
    tb_packet_done = 0;
    tb_framing_error = 1;
    @(negedge tb_clk);
    check_output("after a clock cycle to state LOAD",3);
    @(negedge tb_clk);
  end
endmodule
