module edge_detector
(
    input wire clk,
    input wire n_rst,
    input wire d_plus_sync,
    output reg d_edge
);

reg old_d_plus;

always_ff @(posedge clk, negedge n_rst) begin
    if(!n_rst) begin
        old_d_plus <= 1'b1;
    end
    else begin
        old_d_plus <= d_plus_sync;
    end
end

assign d_edge = (old_d_plus & (!d_plus_sync)) | ((!old_d_plus) & d_plus_sync);
endmodule