module rx_packet
(
    input wire clk,
    input wire n_rst,
    input wire store_pid,
    input wire [7:0] p_out,
    output reg [2:0] rx_packet
);

reg [2:0] nxt_rx_packet;

always_comb begin : NXT_RX_PACKET
    nxt_rx_packet = rx_packet;
    if(store_pid) begin
        case (p_out)
        8'b11100001: begin // OUT
            nxt_rx_packet = 3'd1;
        end
        8'b01101001: begin // IN
            nxt_rx_packet = 3'd2;
        end
        8'b11000011: begin // DATA0
            nxt_rx_packet = 3'd6;
        end
        8'b01001011: begin // DATA1
            nxt_rx_packet = 3'd6;
        end
        8'b11010100: begin // ACK
            nxt_rx_packet = 3'd3;
        end
        8'b01011010: begin // NAK
            nxt_rx_packet = 3'd4;
        end
        8'b00011110: begin // STALL
            nxt_rx_packet = 3'd5;
        end  
    endcase
    end
end

always_ff @(posedge clk, negedge n_rst) begin : REGISTER
    if(!n_rst)
    begin
        rx_packet <= '0;
    end
    else
    begin
        rx_packet <= nxt_rx_packet;
    end
end

endmodule