// $Id: $
// File name:   buffer.sv
// Created:     4/13/2023
// Author:      Te Yu Hsin
// Lab Section: 337-17
// Version:     1.0  Initial Design Entry
// Description: .

module buffer (
    input logic clk,
    input logic n_rst,
    input logic store_tx_data,
    input logic store_rx_packet_data,
    input logic get_rx_data,
    input logic get_tx_packet_data,
    input logic [7:0] tx_data,
    input logic [7:0] rx_packet_data,
    input logic clear,
    input logic flush,

    output logic [6:0] buffer_occupancy,
    output logic [7:0] rx_data,
    output logic [7:0] tx_packet_data
);

logic [6:0] store_ptr;
logic [6:0] get_ptr;
logic clr;

assign clr = (flush || clear);

store_ptr_controller store_ptr_controller (
    .clk(clk),
    .n_rst(n_rst),
    .clr(clr),
    .store_rx_packet_data(store_rx_packet_data),
    .store_tx_data(store_tx_data),
    .store_ptr(store_ptr),
    .buffer_occupancy(buffer_occupancy)
);

get_ptr_controller get_ptr_controller (
    .clk(clk),
    .n_rst(n_rst),
    .clr(clr),
    .get_rx_data(get_rx_data),
    .get_tx_packet_data(get_tx_packet_data),
    .get_ptr(get_ptr),
    .buffer_occupancy(buffer_occupancy)
);

fifo_ram fifo_ram (
    .clk(clk),
    .n_rst(n_rst),
    .tx_data(tx_data),
    .rx_packet_data(rx_packet_data),
    .store_ptr(store_ptr),
    .get_ptr(get_ptr),
    .store_rx_packet_data(store_rx_packet_data),
    .store_tx_data(store_tx_data),
    .buffer_occupancy(buffer_occupancy),
    .tx_packet_data(tx_packet_data),
    .rx_data(rx_data)
);

    
endmodule