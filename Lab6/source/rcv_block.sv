// $Id: $
// File name:   rcv_block.sv
// Created:     2/15/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Receiver Block

module rcv_block (
    input wire clk,
    input wire n_rst,
    input wire serial_in,
    input wire data_read,
    output reg [7:0] rx_data,
    output reg data_ready,
    output reg overrun_error,
    output reg framing_error
);

reg load_buffer;
reg sbc_clear;
reg sbc_enable;
reg enable_timer;
reg packet_done;
reg shift_strobe;
reg [7:0] packet_data;
reg stop_bit;
reg new_packet_detected;

rx_data_buff RX_DATA_BUFF(
    .clk(clk),
    .n_rst(n_rst),
    .load_buffer(load_buffer),
    .packet_data(packet_data),
    .data_read(data_read),
    .rx_data(rx_data),
    .data_ready(data_ready),
    .overrun_error(overrun_error)
  );

timer TIMER(
    .clk(clk),
    .n_rst(n_rst),
    .enable_timer(enable_timer),
    .shift_strobe(shift_strobe),
    .packet_done(packet_done)
  );

sr_9bit SR_9BIT(
    .clk(clk),
    .n_rst(n_rst),
    .shift_strobe(shift_strobe),
    .serial_in(serial_in),
    .packet_data(packet_data),
    .stop_bit(stop_bit)
  );

rcu RCU(
    .clk(clk),
    .n_rst(n_rst),
    .new_packet_detected(new_packet_detected),
    .packet_done(packet_done),
    .framing_error(framing_error),
    .sbc_clear(sbc_clear),
    .sbc_enable(sbc_enable),
    .load_buffer(load_buffer),
    .enable_timer(enable_timer)
  );

start_bit_det START_BIT_DET(
    .clk(clk),
    .n_rst(n_rst),
    .serial_in(serial_in),
    .new_packet_detected(new_packet_detected)
  );

stop_bit_chk STOP_BIT_CHK(
    .clk(clk),
    .n_rst(n_rst),
    .sbc_clear(sbc_clear),
    .sbc_enable(sbc_enable),
    .stop_bit(stop_bit),
    .framing_error(framing_error)
  );
endmodule