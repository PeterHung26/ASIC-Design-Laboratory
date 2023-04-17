module d_minus_sync_low
(
    input wire clk,
    input wire n_rst,
    input wire d_minus,
    output reg d_minus_sync
);

sync_low
CORE(
    .clk(clk),
    .n_rst(n_rst),
    .async_in(d_minus),
    .sync_out(d_minus_sync)
);

endmodule