// $Id: $
// File name:   sr_9bit.sv
// Created:     2/16/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: 9-bit Shift Register

module sr_9bit (
    input wire clk,
    input wire n_rst,
    input wire shift_strobe,
    input wire serial_in,
    output reg [7:0] packet_data,
    output reg stop_bit
);


flex_stp_sr #(
    .NUM_BITS(9),
    .SHIFT_MSB(0)
)
CORE(
    .clk(clk),
    .n_rst(n_rst),
    .serial_in(serial_in),
    .shift_enable(shift_strobe),
    .parallel_out({stop_bit, packet_data})
);

endmodule