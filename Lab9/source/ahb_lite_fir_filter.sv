// $Id: $
// File name:   ahb_lite_fir_filter.sv
// Created:     3/9/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: AHB-Lite FIR Filter Accelerator

module ahb_lite_fir_filter(
    input wire clk,
    input wire n_rst,
    input wire hsel,
    input wire [3:0] haddr,
    input wire hsize,
    input wire [1:0] htrans,
    input wire hwrite,
    input wire [15:0] hwdata,
    output reg [15:0] hrdata,
    output reg hresp
);
reg [1:0] coefficient_num;
reg modwait;
reg [15:0] fir_out;
reg err;
reg clear_new_coeff;
reg [15:0] sample_data;
reg data_ready;
reg new_coefficient_set;
reg [15:0] fir_coefficient;
reg load_coeff;
reg one_k_samples;

ahb_lite_slave AHB_LITE_SLAVE(
    .clk(clk),
    .n_rst(n_rst),
    .coefficient_num(coefficient_num),
    .modwait(modwait),
    .fir_out(fir_out),
    .err(err),
    .hsel(hsel),
    .haddr(haddr),
    .hsize(hsize),
    .htrans(htrans),
    .hwrite(hwrite),
    .hwdata(hwdata),
    .clear_new_coeff(clear_new_coeff),
    .sample_data(sample_data),
    .data_ready(data_ready),
    .new_coefficient_set(new_coefficient_set),
    .fir_coefficient(fir_coefficient),
    .hrdata(hrdata),
    .hresp(hresp)
);

coefficient_loader  COEFFICIENT_LOADER(
    .clk(clk),
    .n_reset(n_rst),
    .new_coefficient_set(new_coefficient_set),
    .modwait(modwait),
    .load_coeff(load_coeff),
    .coefficient_num(coefficient_num),
    .clear_new_coeff(clear_new_coeff)
);

fir_filter FIR_FILTER(
    .clk(clk),
    .n_reset(n_rst),
    .sample_data(sample_data),
    .fir_coefficient(fir_coefficient),
    .load_coeff(load_coeff),
    .data_ready(data_ready),
    .one_k_samples(one_k_samples),
    .modwait(modwait),
    .fir_out(fir_out),
    .err(err)
);
endmodule