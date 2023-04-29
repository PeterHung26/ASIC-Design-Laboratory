module usb_top_level(
    input logic clk,
    input logic n_rst,
    //AHB input and output
    input logic hsel,
    input logic [3:0] haddr,
    input logic [1:0] htrans,
    input logic  [1:0] hsize,
    input logic hwrite,
    input logic [31:0] hwdata,
    output logic [31:0] hrdata,
    output logic hresp,
    output logic hready,
    output logic d_mode,
    //Receiver input
    input logic d_plus_in,
    input logic d_minus_in,
    //Transmitter output
    output logic d_plus_out,
    output logic d_minus_out,
    output logic [6:0] buffer_occupancy,
    output logic get_rx_data,
    output logic [3:0] tx_packet,
    output logic tx_transfer_active
);

logic [3:0] rx_packet;
logic rx_data_ready;
logic rx_transfer_active;
logic rx_error;
logic store_rx_packet_data;
logic [7:0] rx_packet_data;
logic flush;

//logic [6:0] buffer_occupancy;
logic [7:0] rx_data;
// logic get_rx_data;
logic store_tx_data;
logic [7:0] tx_data;
logic clear;

//logic [3:0] tx_packet;
//logic tx_transfer_active;
logic tx_error;
logic get_tx_packet_data;
logic [7:0] tx_packet_data;

ahb_slave AHB_SLAVE(
    .clk(clk),
    .n_rst(n_rst),
    .hsel(hsel),
    .hwrite(hwrite),
    .hsize(hsize),
    .haddr(haddr),
    .htrans(htrans),
    .hwdata(hwdata),
    .hrdata(hrdata),
    .hresp(hresp),
    .hready(hready),
    .dmode(d_mode),
    .rx_packet(rx_packet),
    .rx_data_ready(rx_data_ready),
    .rx_transfer_active(rx_transfer_active),
    .rx_error(rx_error),
    .buffer_occupancy(buffer_occupancy),
    .rx_data(rx_data),
    .get_rx_data(get_rx_data),
    .store_tx_data(store_tx_data),
    .tx_data(tx_data),
    .clear(clear),
    .tx_packet(tx_packet),
    .tx_transfer_active(tx_transfer_active),
    .tx_error(tx_error)
);

buffer BUFFER(
    .clk(clk),
    .n_rst(n_rst),
    .store_tx_data(store_tx_data),
    .store_rx_packet_data(store_rx_packet_data),
    .get_rx_data(get_rx_data),
    .get_tx_packet_data(get_tx_packet_data),
    .tx_data(tx_data),
    .rx_packet_data(rx_packet_data),
    .clear(clear),
    .flush(flush),
    .buffer_occupancy(buffer_occupancy),
    .rx_data(rx_data),
    .tx_packet_data(tx_packet_data)
);

usb_transmitter TRANSMITTER(
    .clk(clk),
    .n_rst(n_rst),
    .buffer_occupancy(buffer_occupancy),
    .tx_packet(tx_packet),
    .tx_packet_data(tx_packet_data),
    .get_tx_packet_data(get_tx_packet_data),
    .tx_transfer_active(tx_transfer_active),
    .tx_error(tx_error),
    .d_plus_out(d_plus_out),
    .d_minus_out(d_minus_out)
);

rcv_block RECEIVER(
    .clk(clk),
    .n_rst(n_rst),
    .d_plus(d_plus_in),
    .d_minus(d_minus_in),
    .buffer_occupancy(buffer_occupancy),
    .rx_error(rx_error),
    .rx_transfer_active(rx_transfer_active),
    .flush(flush),
    .rx_data_ready(rx_data_ready),
    .rx_packet(rx_packet),
    .w_enable(store_rx_packet_data),
    .rcv_data(rx_packet_data)
);

endmodule