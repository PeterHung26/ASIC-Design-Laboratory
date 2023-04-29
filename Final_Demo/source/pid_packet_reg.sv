// $Id: $
// File name:   pid_packet_reg.sv
// Created:     4/22/2023
// Author:      Te Yu Hsin
// Lab Section: 337-17
// Version:     1.0  Initial Design Entry
// Description: .

module pid_packet_reg (
    input logic clk,
    input logic n_rst,
    input logic tx_packet,
    output logic different
);
logic [3:0] last_tx_packet;

assign different = (last_tx_packet != tx_packet);

always_ff @( posedge clk, negedge n_rst ) begin
    if (!n_rst) begin
        last_tx_packet <= '0;
    end
    else begin
        last_tx_packet <= tx_packet;
    end
end

    
endmodule