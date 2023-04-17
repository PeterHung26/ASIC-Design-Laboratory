module edge_detector
(
    input wire clk,
    input wire n_rst,
    input wire d_plus_sync,
    output reg d_edge
);

start_bit_det
CORE(
    .clk(clk),
    .n_rst(n_rst),
    .serial_in(d_plus_sync),
    .new_packet_detected(d_edge)
);

endmodule