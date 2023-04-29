// $Id: $
// File name:   packet_selecter.sv
// Created:     4/12/2023
// Author:      Te Yu Hsin
// Lab Section: 337-17
// Version:     1.0  Initial Design Entry
// Description: .

module packet_selecter (
    input logic sync_start,
    input logic pid_start,
    input logic [7:0] tx_packet_data,
    input logic [3:0] tx_packet,
    input logic crc_start,
    output logic [7:0] d_par
);

always_comb begin : selecter
    d_par = tx_packet_data;
    if (pid_start) begin
        case (tx_packet)
            // OUT
            4'b0001: begin
                d_par = 8'b11100001;
                // d_par = 8'b10000111;
            end
            // IN
            4'b1001: begin
                d_par = 8'b01101001;
                //d_par = 8'b10010110;
            end
            // ACK
            4'b0010: begin
                d_par = 8'b11010010;
                //d_par = 8'b01001011;
            end
            // NAK
            4'b1010: begin
                d_par = 8'b01011010;
                //d_par = 8'b01011010;
            end
            // STALL
            4'b1110: begin
                d_par = 8'b00011110;
                // d_par = 8'b01111000;
            end
            // DATA
            4'b0011: begin
                d_par = 8'b11000011;
            end
        endcase
    end
    if (sync_start) begin
        d_par = 8'b10000000;
    end
    if (crc_start) begin
        d_par = 8'b00000000;
    end
end
    
endmodule