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
    input wire [3:0] data_size,
    output reg [7:0] packet_data,
    output reg stop_bit
);
reg [7:0] pre_packet_data;

flex_stp_sr #(
    .NUM_BITS(9),
    .SHIFT_MSB(0)
)
CORE(
    .clk(clk),
    .n_rst(n_rst),
    .serial_in(serial_in),
    .shift_enable(shift_strobe),
    .parallel_out({stop_bit, pre_packet_data})
);

always_comb begin
    packet_data = pre_packet_data;
    if(data_size == 4'd5) begin
        packet_data = {3'b000, pre_packet_data[7:3]};
    end
    else if(data_size == 4'd7) begin
        packet_data = {1'b0, pre_packet_data[7:1]};
    end
    else begin
        packet_data = pre_packet_data;
    end
end

endmodule