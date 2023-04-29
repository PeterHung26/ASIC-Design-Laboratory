module decoder
(
    input wire clk,
    input wire n_rst,
    input wire d_plus_sync,
    input wire shift_enable,
    output reg d_orig
);

reg old_data;
reg new_data;
reg nxt_old;
reg nxt_new;

always_comb begin : NEXT_VALUE
    nxt_old = old_data;
    nxt_new = new_data;
    if(shift_enable) begin
       nxt_new = d_plus_sync;
       nxt_old = new_data; 
    end
end

always_ff @(posedge clk, negedge n_rst) begin
    if(!n_rst) begin
       new_data <= 1'b1;
       old_data <= 1'b1; 
    end
    else begin
        new_data <= nxt_new;
        old_data <= nxt_old; 
    end
end

assign d_orig = ~(new_data ^ old_data);

endmodule