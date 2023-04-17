module eop
(
    input wire d_plus_sync,
    input wire d_minus_sync
    output reg eop
);

assign eop = ~(d_plus_sync | d_minus_sync);

endmodule