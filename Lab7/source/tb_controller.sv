// $Id: $
// File name:   tb_controller.sv
// Created:     2/24/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Test Bench for controller of FIR Filter

`timescale 1ns/10ps

module tb_controller();

	// Define local constants
	localparam NUM_VAL_BITS	= 16;
	localparam MAX_VAL_BIT	= NUM_VAL_BITS - 1;
	localparam CHECK_DELAY	= 1ns;
	localparam CLK_PERIOD		= 10ns;
	
	// Test bench dut port signals
	reg tb_clk;
	reg tb_n_rst;
	reg tb_dr;
	reg tb_lc;
	reg tb_overflow;
	reg tb_cnt_up;
	reg tb_clear;
    reg tb_modwait;
    reg [2:0] tb_op;
    reg [3:0] tb_src1;
    reg [3:0] tb_src2;
    reg [3:0] tb_dest;
    reg tb_err;
	
	// Test bench verification signals
	integer tb_test_num;
    string  tb_test_case;
	reg [3:0] tb_expected_src1;
    reg [3:0] tb_expected_src2;
    reg [3:0] tb_expected_dest;
    reg tb_expected_clear;
	reg tb_expected_err;
	reg [2:0] tb_expected_op;
    reg tb_expected_modwait;
    reg tb_expected_cnt_up;
	
	task reset_dut;
	begin
		// Activate the design's reset (does not need to be synchronize with clock)
		tb_n_rst = 1'b0;
		
		// Wait for a couple clock cycles
		@(posedge tb_clk);
		@(posedge tb_clk);
		
		// Release the reset
		@(negedge tb_clk);
		tb_n_rst = 1;
		
		// Wait for a while before activating the design
		@(posedge tb_clk);
		@(posedge tb_clk);
	end
	endtask
	
    task check_outputs;
        input expected_modwait;
        input [2:0] expected_op;
        input [3:0] expected_src1;
        input [3:0] expected_src2;
        input [3:0] expected_dest;
        input expected_cnt_up;
        input expected_clear;
        input expected_err;
    begin
        tb_expected_modwait = expected_modwait;
        tb_expected_op = expected_op;
        tb_expected_src1 = expected_src1;
        tb_expected_src2 = expected_src2;
        tb_expected_dest = expected_dest;
        tb_expected_cnt_up = expected_cnt_up;
        tb_expected_clear = expected_clear;
        tb_expected_err = expected_err;
        assert(tb_expected_modwait == tb_modwait)
            $info("Test case %0d: Modwait correctly received", tb_test_num);
        else
            $error("Test case %0d: Modwait was not correctly received", tb_test_num);
        assert(tb_expected_op == tb_op)
            $info("Test case %0d: Op correctly received", tb_test_num);
        else
            $error("Test case %0d: Op was not correctly received", tb_test_num);
        assert(tb_expected_src1 == tb_src1)
            $info("Test case %0d: Src1 correctly received", tb_test_num);
        else
            $error("Test case %0d: Src1 was not correctly received", tb_test_num);
        assert(tb_expected_src2 == tb_src2)
            $info("Test case %0d: Src2 correctly received", tb_test_num);
        else
            $error("Test case %0d: Src2 was not correctly received", tb_test_num);
        assert(tb_expected_dest == tb_dest)
            $info("Test case %0d: Dest correctly received", tb_test_num);
        else
            $error("Test case %0d: Dest was not correctly received", tb_test_num);
        assert(tb_expected_cnt_up == tb_cnt_up)
            $info("Test case %0d: Cnt_up correctly received", tb_test_num);
        else
            $error("Test case %0d: Cnt_up was not correctly received", tb_test_num);
        assert(tb_expected_clear == tb_clear)
            $info("Test case %0d: Clear correctly received", tb_test_num);
        else
            $error("Test case %0d: Clear was not correctly received", tb_test_num);
        assert(tb_expected_err == tb_err)
            $info("Test case %0d: Err correctly received", tb_test_num);
        else
            $error("Test case %0d: Err was not correctly received", tb_test_num);
    end
    endtask

	// Clock gen block
	always
	begin : CLK_GEN
		tb_clk = 1'b0;
		#(CLK_PERIOD / 2.0);
		tb_clk = 1'b1;
		#(CLK_PERIOD / 2.0);
	end
	
	// DUT portmap
	controller DUT(
									.clk(tb_clk),
									.n_rst(tb_n_rst),
									.dr(tb_dr),
									.lc(tb_lc),
									.overflow(tb_overflow),
									.cnt_up(tb_cnt_up),
									.clear(tb_clear),
									.modwait(tb_modwait),
									.op(tb_op),
									.src1(tb_src1),
                                    .src2(tb_src2),
                                    .dest(tb_dest),
                                    .err(tb_err)
								);
	
	// Test bench process
	initial
	begin
		// Initial values
		tb_test_num = -1;
		tb_n_rst = 1'b1;
        tb_test_case = "TB Init";
		tb_dr = 1'b0;
		tb_lc = 1'b0;
		tb_overflow = 1'b0;
		
		// Wait for some time before starting test cases
		#(1ns);
        // Test case 0: Basic Power on Reset
        tb_test_num  = 0;
        tb_test_case = "Power-on-Reset";
		reset_dut;
		check_outputs(1'b0, 3'b000, 4'd15, 4'd15, 4'd15, 1'b0, 1'b0, 1'b0);

        // Test case 1: From STORE to EIDLE 
        // Synchronize to falling edge of clock to prevent timing shifts from prior test case(s)
        @(negedge tb_clk);
        tb_test_num  += 1;
        tb_test_case = "From STORE to EIDLE";
        reset_dut;
        @(negedge tb_clk);
        tb_dr = 1;
        #(CLK_PERIOD);
        tb_dr = 0;
        check_outputs(1'b1, 3'b010, 4'd15, 4'd15, 4'd9, 1'b1, 1'b0, 1'b0);
        #(CLK_PERIOD);
        check_outputs(1'b0, 3'b000, 4'd15, 4'd15, 4'd15, 1'b0, 1'b0, 1'b1);
        #(2*CLK_PERIOD);

        // Test case 2: Run Through whole state of data_ready 
        // Synchronize to falling edge of clock to prevent timing shifts from prior test case(s)
        @(negedge tb_clk);
        tb_test_num  += 1;
        tb_test_case = "Run Through whole state of data_ready";
        reset_dut;
        @(negedge tb_clk);
        tb_dr = 1;
        #(2*CLK_PERIOD);
        tb_dr = 0;
        #(12*CLK_PERIOD);
        check_outputs(1'b1, 3'b100, 4'd0, 4'd10, 4'd0, 1'b0, 1'b0, 1'b0);
        #(CLK_PERIOD);
        check_outputs(1'b0, 3'b000, 4'd15, 4'd15, 4'd15, 1'b0, 1'b0, 1'b0);

        // Test case 3: Load Coefficient 
        // Synchronize to falling edge of clock to prevent timing shifts from prior test case(s)
        @(negedge tb_clk);
        tb_test_num  += 1;
        tb_test_case = "Load Coefficient";
        reset_dut;
        @(negedge tb_clk);
        tb_lc = 1;
        #(7*CLK_PERIOD);
        tb_lc = 0;
        #(2*CLK_PERIOD);
	end

    // Wrap-up process
	final
	begin
		$display("This test bench has runned to the end.");
	end
endmodule
