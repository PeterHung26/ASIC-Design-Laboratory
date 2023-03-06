// $Id: $
// File name:   apb_uart_rx.sv
// Created:     3/1/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: APB-UART Receiver Peripheral Block

module apb_uart_rx(
    input wire clk,
    input wire n_rst,
    input wire serial_in,
    input wire psel,
    input wire [2:0] paddr,
    input wire penable,
    input wire pwrite,
    input wire [7:0] pwdata,
    output wire [7:0] prdata,
    output wire pslverr
);
reg data_ready;
reg [7:0] rx_data;
reg data_read;
reg overrun_error;
reg framing_error;
reg [3:0] data_size;
reg [13:0] bit_period;

apb_slave APB_SLAVE(
    .clk(clk),
    .n_rst(n_rst),
    .rx_data(rx_data),
    .data_ready(data_ready),
    .overrun_error(overrun_error),
    .framing_error(framing_error),
    .data_read(data_read),
    .psel(psel),
    .paddr(paddr),
    .penable(penable),
    .pwrite(pwrite),
    .pwdata(pwdata),
    .prdata(prdata),
    .pslverr(pslverr),
    .data_size(data_size),
    .bit_period(bit_period)
  );

rcv_block RCV_BLOCK(
    .clk(clk),
    .n_rst(n_rst),
    .data_size(data_size),
    .bit_period(bit_period),
    .serial_in(serial_in),
    .rx_data(rx_data),
    .data_read(data_read),
    .data_ready(data_ready),
    .overrun_error(overrun_error),
    .framing_error(framing_error)
  );
endmodule