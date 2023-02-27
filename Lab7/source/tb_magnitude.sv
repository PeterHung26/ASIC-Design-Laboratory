// $Id: $
// File name:   tb_magnitude.sv
// Created:     2/24/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Test Bench for Magnitude

`timescale 1ns/10ps

module tb_magnitude();

	// Define local constants
	localparam NUM_VAL_BITS	= 16;
	localparam MAX_VAL_BIT	= NUM_VAL_BITS - 1;
	localparam CHECK_DELAY	= 1ns;
	localparam CLK_PERIOD		= 10ns;
	
	// Test bench dut port signals
	reg [16:0] tb_in;
    reg [15:0] tb_out;
	
	// Test bench verification signals
	integer tb_test_num;
    string  tb_test_case;
	reg [15:0] tb_expected_out;
	
    task check_outputs;
        input [15:0] expected_out;
    begin
        tb_expected_out = expected_out;
        assert(tb_expected_out == tb_out)
            $info("Test case %0d: Out correctly received", tb_test_num);
        else
            $error("Test case %0d: Out was not correctly received", tb_test_num);
    end
    endtask
	
	// DUT portmap
	magnitude DUT(
									.in(tb_in),
                                    .out(tb_out)
								);
	
	// Test bench process
	initial
	begin
		// Initial values
		tb_test_num = -1;
        tb_test_case = "TB Init";
		
		// Wait for some time before starting test cases
		#(1ns);
        // Test case 0: Basic Power on Reset
        tb_test_num  = 0;
        tb_test_case = "First Case";
        tb_in = 17'b11111111110100000;
        #(5);
		check_outputs(16'b0000000001100000);
        #(10);
        tb_in = 17'b01111111110100000;
        #(5);
		check_outputs(16'b1111111110100000);
	end

    // Wrap-up process
	final
	begin
		$display("This test bench has runned to the end.");
	end
endmodule
