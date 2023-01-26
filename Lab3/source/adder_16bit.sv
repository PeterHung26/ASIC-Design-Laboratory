// $Id: $
// File name:   adder_16bit.sv
// Created:     1/25/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Efficient Non-Exhaustive Design Verification
`timescale 1ns / 100ps

module adder_16bit
(
	input wire [15:0] a,
	input wire [15:0] b,
	input wire carry_in,
	output wire [15:0] sum,
	output wire overflow
);
	genvar k;
    generate
		for(k = 0;k < 16; k = k + 1)
		begin
			always @ (a, b)
			begin
				assert((a[k] == 1'b1) || (a[k] == 1'b0))
				else $error("Input 'a' of %d bit is not a digital logic value\n", k);
				assert((b[k] == 1'b1) || (b[k] == 1'b0))
				else $error("Input 'b' of %d bit is not a digital logic value\n", k);
				assert((carry_in == 1'b1) || (carry_in == 1'b0))
				else $error("Input 'carry_in' of component is not a digital logic value\n");
			end
		end
	endgenerate
	adder_nbit #(.BIT_WIDTH(16)) A8 (.a(a), .b(b) , .carry_in(carry_in), .sum(sum), .overflow(overflow));
	// STUDENT: Fill in the correct port map with parameter override syntax for using your n-bit ripple carry adder design to be an 8-bit ripple carry adder design
endmodule
