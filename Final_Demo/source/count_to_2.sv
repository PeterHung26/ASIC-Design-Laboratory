module count_to_2
(
    input wire clk,
    input wire n_rst,
    input wire flush, 
    input wire load_buf,
    output reg done_2
);

reg [1:0] count;
reg [1:0] nxt_count;

always_comb begin: NEXT_COUNT
    nxt_count = count;
    if(flush)
        nxt_count = '0;
    else if(load_buf) begin
        if(count == 2'b10)
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
    if(count == 2'b10)
        done_2 = 1'b1;
    else
        done_2 = 1'b0;
end

endmodule