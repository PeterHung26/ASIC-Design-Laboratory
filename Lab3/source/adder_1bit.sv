// $Id: $
// File name:   adder_1bit.sv
// Created:     1/19/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: 1-bit Full Adder Design.
`timescale 1ns / 100ps

module adder_1bit
(
	input wire a,
	input wire b,
	input wire carry_in,
	output wire sum,
	output wire carry_out
);
	wire tmp1;
	wire tmp2;
	wire tmp3;
	assign tmp1 = a ^ b;
	assign sum = carry_in ^ tmp1;
	assign carry_out = ((~carry_in) & (b & a)) | (carry_in & (b | a));
	always @ (a, b, carry_in)
	begin
		#(2) assert((a == 1'b1) || (a == 1'b0))
		else $error("Input 'a' of component is not a digital logic value\n");
		assert((b == 1'b1) || (b == 1'b0))
		else $error("Input 'b' of component is not a digital logic value\n");
		assert((carry_in == 1'b1) || (carry_in == 1'b0))
		else $error("Input 'carry_in' of component is not a digital logic value\n");
	end
	// STUDENT: Fill in the correct port map with parameter override syntax for using your n-bit ripple carry adder design to be an 8-bit ripple carry adder design
endmodule