module store_2_byte_buffer
(
    input wire clk,
    input wire n_rst,
    input wire load_buf,
    input wire flush,
    input wire [7:0] p_out,
    output reg [7:0] new_2_byte,
    output reg [7:0] old_2_byte,
    output reg [7:0] rcv_data
);

reg [7:0] nxt_new_2_byte;
reg [7:0] nxt_old_2_byte;
reg [7:0] nxt_rcv_data;

always_comb begin: NXT_VALUE
    nxt_new_2_byte = new_2_byte;
    nxt_old_2_byte = old_2_byte;
    nxt_rcv_data = rcv_data;
    if(flush) begin
        nxt_new_2_byte = '0;
        nxt_old_2_byte = '0;
        nxt_rcv_data = '0;
    end
    else if(load_buf) begin
        nxt_new_2_byte = p_out;
        nxt_old_2_byte = new_2_byte;
        nxt_rcv_data = old_2_byte;
    end
end

always_ff @(posedge clk, negedge n_rst) begin: REGISTER
    if(!n_rst) begin
        new_2_byte <= '0;
        old_2_byte <= '0;
        rcv_data <= '0;
    end
    else begin
        new_2_byte <= nxt_new_2_byte;
        old_2_byte <= nxt_old_2_byte;
        rcv_data <= nxt_rcv_data;
    end
end

endmodule