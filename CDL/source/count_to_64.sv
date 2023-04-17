module count_to_64
(
    input wire clk,
    input wire n_rst,
    input wire flush,
    input wire w_enable,
    output reg 64_done
);

reg [6:0] count;
reg [6:0] nxt_count;

always_comb begin: NEXT_COUNT
    nxt_count = count;
    if(flush)
        nxt_count = '0;
    else if(w_enable) begin
        if(count == 7'd64)
            nxt_count = count;
        else
            nxt_count = count + 1;
    end
end

always_ff @(posedge clk, negedge n_rst) begin: REGISTER
    if(!n_rst)
        count <= '0;
    else
        count <= nxt_count;
end

always_comb begin: OUTPUT_LOGIC
    if(count == 7'd64)
        64_done = 1'b1;
    else
        64_done = 1'b0;
end
endmodule