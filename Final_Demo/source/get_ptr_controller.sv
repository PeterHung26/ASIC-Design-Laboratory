// $Id: $
// File name:   get_ptr_controller.sv
// Created:     4/24/2023
// Author:      Te Yu Hsin
// Lab Section: 337-17
// Version:     1.0  Initial Design Entry
// Description: .

module get_ptr_controller (
    input logic clk,
    input logic n_rst,
    input logic clr,
    input logic get_rx_data,
    input logic get_tx_packet_data,
    input logic [6:0] buffer_occupancy,
    output logic [6:0] get_ptr
);

    logic [6:0] next_get_ptr;

    always_ff @( posedge clk, negedge n_rst ) begin
        if (!n_rst) begin
            get_ptr <= 0;
        end
        else begin
            get_ptr <= next_get_ptr;
        end
    end

    always_comb begin
        if (clr) begin
            next_get_ptr = 0;
        end
        else if ((get_rx_data || get_tx_packet_data) && (get_ptr < 64) && (buffer_occupancy)) begin
            next_get_ptr = get_ptr + 1;
        end
        else begin
            next_get_ptr = get_ptr;
        end
    end
    
endmodule