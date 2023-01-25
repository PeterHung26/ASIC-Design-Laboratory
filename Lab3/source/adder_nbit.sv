// $Id: $
// File name:   adder_nbit.sv
// Created:     1/21/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Creating a Scalable Ripple Carry Adder Design with Parameters
`timescale 1ns / 100ps

module adder_nbit
#(
    parameter BIT_WIDTH = 4
)
(
	input wire [(BIT_WIDTH-1):0] a,
	input wire [(BIT_WIDTH-1):0] b,
	input wire carry_in,
	output wire [(BIT_WIDTH-1):0] sum,
	output wire overflow
);
    wire [BIT_WIDTH:0] carrys;
	genvar i;
	integer j;
	integer k;
	assign carrys[0] = carry_in;
	generate
		for(i = 0; i <= BIT_WIDTH-1; i = i + 1)
			begin
				adder_1bit IX (.a(a[i]), .b(b[i]) , .carry_in(carrys[i]), .sum(sum[i]), .carry_out(carrys[i+1]));
			end
	endgenerate
	assign overflow = carrys[BIT_WIDTH];
	always @ (*)
	begin
		#(5)
		for(k = 0;k < BIT_WIDTH; k = k + 1)
		begin
			assert((a[k] == 1'b1) || (a[k] == 1'b0))
			else $error("Input 'a' of %d bit is not a digital logic value\n", k);
			assert((b[k] == 1'b1) || (b[k] == 1'b0))
			else $error("Input 'b' of %d bit is not a digital logic value\n", k);
		end
		assert((carry_in == 1'b1) || (carry_in == 1'b0))
		else $error("Input 'carry_in' of component is not a digital logic value\n");
		for(j = 0;j < BIT_WIDTH; j = j + 1)
		begin
			assert((a[j]+b[j]+carrys[j])%2 == sum[j])
			else $error("Output 'sum' of %d bit is not correct\n", j);
		end
	end
		

	// STUDENT: Fill in the correct port map with parameter override syntax for using your n-bit ripple carry adder design to be an 8-bit ripple carry adder design
endmodule