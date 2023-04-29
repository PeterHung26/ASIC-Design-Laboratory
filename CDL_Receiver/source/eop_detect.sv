module eop_detect
(
    input wire clk,
    input wire n_rst,
    input wire d_plus_sync,
    input wire d_minus_sync,
    input wire shift_enable,
    output reg eop
);
reg pmand;
reg nxt_eop;

always_comb begin: NXT_EOP
    if(shift_enable) begin
        nxt_eop = pmand;
    end
    else begin
        nxt_eop = eop;
    end
end

always_ff @(posedge clk, negedge n_rst) begin: REGISTER
    if(!n_rst) begin
        eop <= 1'b0;
    end
    else begin
        eop <= nxt_eop;
    end
end

assign pmand = ~(d_plus_sync | d_minus_sync);

endmodule