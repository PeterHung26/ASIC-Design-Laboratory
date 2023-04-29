// $Id: $
// File name:   store_ptr_controller.sv
// Created:     4/15/2023
// Author:      Te Yu Hsin
// Lab Section: 337-17
// Version:     1.0  Initial Design Entry
// Description: .

module store_ptr_controller (
    input logic clk,
    input logic n_rst,
    input logic clr,
    input logic store_rx_packet_data,
    input logic store_tx_data,
    input logic [6:0] buffer_occupancy,
    output logic [6:0] store_ptr
);

    logic [6:0] next_store_ptr;

    always_ff @( posedge clk, negedge n_rst ) begin
        if (!n_rst) begin
            store_ptr <= 0;
        end
        else begin
            store_ptr <= next_store_ptr;
        end
    end

    always_comb begin
        if (clr) begin
            next_store_ptr = 0;
        end
        else if ((store_tx_data || store_rx_packet_data) && (store_ptr < 64)) begin
            next_store_ptr = store_ptr + 1;
        end
        else begin
            next_store_ptr = store_ptr;
        end
    end
    
endmodule