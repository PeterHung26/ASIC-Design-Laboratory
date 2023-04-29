module rx_packet
(
    input wire clk,
    input wire n_rst,
    input wire store_pid,
    input wire [7:0] p_out,
    output reg [3:0] rx_packet
);

reg [3:0] nxt_rx_packet;

always_comb begin : NXT_RX_PACKET
    nxt_rx_packet = rx_packet;
    if(store_pid) begin
        case (p_out)
        8'b11100001: begin // OUT
            nxt_rx_packet = 4'b0001;
        end
        8'b01101001: begin // IN
            nxt_rx_packet = 4'b1001;
        end
        8'b11000011: begin // DATA0
            nxt_rx_packet = 4'b0011;
        end
        8'b01001011: begin // DATA1
            nxt_rx_packet = 4'b1011;
        end
        8'b11010010: begin // ACK
            nxt_rx_packet = 4'b0010;
        end
        8'b01011010: begin // NAK
            nxt_rx_packet = 4'b1010;
        end
        8'b00011110: begin // STALL
            nxt_rx_packet = 4'b1110;
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