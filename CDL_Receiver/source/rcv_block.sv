module rcv_block
(
    input wire clk,
    input wire n_rst,
    input wire d_plus,
    input wire d_minus,
    input wire [6:0] buffer_occupancy,
    output reg rx_error,
    output reg rx_transfer_active,
    output reg flush,
    output reg rx_data_ready,
    output reg [3:0] rx_packet,
    output reg w_enable,
    output reg [7:0] rcv_data
);

reg d_plus_sync;
reg d_minus_sync;
reg eop;
reg shift_enable;
reg byte_received;
reg d_orig;
reg d_edge;
reg disable_timer;
reg [7:0] p_out;
reg [7:0] new_2_byte;
reg [7:0] old_2_byte;
reg done_2;
reg done_64;
reg store_pid;
reg load_buf;
reg ready;

sync_high SYNC_HIGH(
    .clk(clk),
    .n_rst(n_rst),
    .async_in(d_plus),
    .sync_out(d_plus_sync)
);

sync_low SYNC_LOW(
    .clk(clk),
    .n_rst(n_rst),
    .async_in(d_minus),
    .sync_out(d_minus_sync)
);

eop_detect EOP_DETECTOR(
    .clk(clk),
    .n_rst(n_rst),
    .d_plus_sync(d_plus_sync),
    .d_minus_sync(d_minus_sync),
    .shift_enable(shift_enable),
    .eop(eop)
);

decoder DECODER(
    .clk(clk),
    .n_rst(n_rst),
    .d_plus_sync(d_plus_sync),
    .shift_enable(shift_enable),
    .d_orig(d_orig)
);

edge_detector EDGE_DETECTOR(
    .clk(clk),
    .n_rst(n_rst),
    .d_plus_sync(d_plus_sync),
    .d_edge(d_edge)
);

timer TIMER(
    .clk(clk),
    .n_rst(n_rst),
    .d_edge(d_edge),
    .disable_timer(disable_timer),
    .shift_enable(shift_enable),
    .byte_received(byte_received)
);

rcu RCU(
    .clk(clk),
    .n_rst(n_rst),
    .d_edge(d_edge),
    .shift_enable(shift_enable),
    .byte_received(byte_received),
    .p_out(p_out),
    .old_2_byte(old_2_byte),
    .new_2_byte(new_2_byte),
    .eop(eop),
    .done_2(done_2),
    .done_64(done_64),
    .disable_timer(disable_timer),
    .rcving(rx_transfer_active),
    .flush(flush),
    .r_error(rx_error),
    .store_pid(store_pid),
    .load_buf(load_buf),
    .w_enable(w_enable),
    .ready(ready)
);

stp_sr_8_lsb SHIFT_REGISTER(
    .clk(clk),
    .n_rst(n_rst),
    .d_orig(d_orig),
    .shift_enable(shift_enable),
    .p_out(p_out)
);

rx_data_ready READY(
    .clk(clk),
    .n_rst(n_rst),
    .ready(ready),
    .buffer_occupancy(buffer_occupancy),
    .rx_data_ready(rx_data_ready)
);

rx_packet PACKET(
    .clk(clk),
    .n_rst(n_rst),
    .store_pid(store_pid),
    .p_out(p_out),
    .rx_packet(rx_packet)
);

store_2_byte_buffer STORE_2_BYTE(
    .clk(clk),
    .n_rst(n_rst),
    .load_buf(load_buf),
    .flush(flush),
    .p_out(p_out),
    .new_2_byte(new_2_byte),
    .old_2_byte(old_2_byte),
    .rcv_data(rcv_data)
);

count_to_2 COUNT_TO_2(
    .clk(clk),
    .n_rst(n_rst),
    .flush(flush),
    .load_buf(load_buf),
    .done_2(done_2)
);

count_to_64 COUNT_TO_64(
    .clk(clk),
    .n_rst(n_rst),
    .flush(flush),
    .w_enable(w_enable),
    .done_64(done_64)
);
endmodule