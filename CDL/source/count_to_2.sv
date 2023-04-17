module count_to_2
(
    input wire clk,
    input wire n_rst,
    input wire flush, 
    input wire load_buf,
    output reg 2_done
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
        2_done = 1'b1;
    else
        2_done = 1'b0;
end

endmodule