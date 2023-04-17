module d_plus_sync_high
(
    input wire clk,
    input wire n_rst,
    input wire d_plus,
    output reg d_plus_sync
);

sync_high
CORE(
    .clk(clk),
    .n_rst(n_rst),
    .async_in(d_plus),
    .sync_out(d_plus_sync)
);

endmodule