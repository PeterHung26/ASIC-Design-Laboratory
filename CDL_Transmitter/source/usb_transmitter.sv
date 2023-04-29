// $Id: $
// File name:   usb_transmitter
// Created:     4/13/2023
// Author:      Te Yu Hsin
// Lab Section: 337-17
// Version:     1.0  Initial Design Entry
// Description: .

module usb_transmitter (
  input logic clk,
  input logic n_rst,

  input logic [6:0] buffer_occupancy,
  input logic [3:0] tx_packet,
  input logic [7:0] tx_packet_data,
  output logic get_tx_packet_data,
  output logic tx_transfer_active,
  output logic tx_error,
  output logic d_plus_out,
  output logic d_minus_out
);
  logic [7:0] d_par;
  logic d_orig;
  logic d_encoded;
  logic eop;
  logic timer_clear;
  logic timer_enable;
  logic byte_transmitted;
  logic strobe;
  logic sync_start;
  logic pid_start;
  logic idle;
  logic pts_load_enable;
  logic pts_shift_enable;

  packet_selecter packet_selecter (
    .sync_start(sync_start),
    .pid_start(pid_start),
    .tx_packet_data(tx_packet_data),
    .tx_packet(tx_packet),
    .d_par(d_par),
    .crc_start(crc_start)
  );

  pts_sr_8_lsb pts_sr_8_lsb (
    .clk(clk),
    .n_rst(n_rst),
    .strobe(strobe),
    .strobe_middle(strobe_middle),
    .pts_load_enable(pts_load_enable),
    .pts_shift_enable(pts_shift_enable),
    .d_par(d_par),
    .d_orig(d_orig)
  );

  encoder encoder (
    .clk(clk),
    .strobe(strobe),
    .strobe_middle(strobe_middle),
    .n_rst(n_rst),
    .d_orig(d_orig),
    .d_encoded(d_encoded)
  );

  d_plus_selecter d_plus_selecter (
    .eop(eop),
    .d_encoded(d_encoded),
    .d_plus_out(d_plus_out),
    .idle(idle)
  );

  d_minus_selecter d_minus_selecter (
    .eop(eop),
    .d_encoded(d_encoded),
    .d_minus_out(d_minus_out),
    .idle(idle)
  );

  timer_transmit timer(
    .clk(clk),
    .n_rst(n_rst),
    .timer_enable(timer_enable),
    .timer_clear(timer_clear),
    .tx_transfer_active(tx_transfer_active),
    .byte_transmitted(byte_transmitted),
    .strobe(strobe),
    .strobe_middle(strobe_middle)
  );

  tmu tmu(
    .clk(clk),
    .n_rst(n_rst),
    .byte_transmitted(byte_transmitted),
    .pts_load_enable(pts_load_enable),
    .pts_shift_enable(pts_shift_enable),
    .strobe(strobe),
    .buffer_occupancy(buffer_occupancy),
    .sync_start(sync_start),
    .pid_start(pid_start),
    .timer_enable(timer_enable),
    .timer_clear(timer_clear),
    .get_tx_packet_data(get_tx_packet_data),
    .tx_transfer_active(tx_transfer_active),
    .tx_error(tx_error),
    .eop(eop),
    .tx_packet(tx_packet),
    .idle(idle),
    .crc_start(crc_start)
  );

endmodule
