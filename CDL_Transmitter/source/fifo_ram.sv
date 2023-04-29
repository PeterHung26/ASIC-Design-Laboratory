// $Id: $
// File name:   FIFO.sv
// Created:     4/14/2023
// Author:      Te Yu Hsin
// Lab Section: 337-17
// Version:     1.0  Initial Design Entry
// Description: .

module fifo_ram (
    input logic clk,
    input logic n_rst,
    input logic [7:0] tx_data,
    input logic [7:0] rx_packet_data,
    input logic [6:0] store_ptr,
    input logic [6:0] get_ptr,
    input logic store_rx_packet_data,
    input logic store_tx_data,

    output logic [6:0] buffer_occupancy,
    output logic [7:0] tx_packet_data,
    output logic [7:0] rx_data
);

logic [7:0] FIFO_reg [63:0];
logic [7:0] next_FIFO_reg [63:0];
logic [6:0] buffer_count = 0;
genvar i;
generate
    for (i = 0; i < 64; i++)
        always_ff @( posedge clk, negedge n_rst ) begin
            if (!n_rst) begin
                FIFO_reg[i] <= 0;
            end
            else begin
                FIFO_reg[i] <= next_FIFO_reg[i];
            end 
        end
endgenerate

generate
    for(i = 0; i< 64; i++)
        always_comb begin
            if ((store_rx_packet_data || store_tx_data) && (store_ptr[5:0] == i)) begin
                if (store_tx_data) begin
                    next_FIFO_reg[i] = tx_data;
                end
                else begin
                    next_FIFO_reg[i] = rx_packet_data;
                end
            end
            else begin
                next_FIFO_reg[i] = FIFO_reg[i];
            end
        end
endgenerate

always_comb begin
    rx_data = FIFO_reg[get_ptr[5:0]];
    tx_packet_data = FIFO_reg[get_ptr[5:0]];
    buffer_count = store_ptr - get_ptr;
    if (buffer_count == 64 || buffer_count == -64) begin
        buffer_occupancy = 64;
    end
    else begin
        buffer_occupancy = buffer_count % 64;
    end
end

    
endmodule