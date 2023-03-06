// $Id: $
// File name:   apb_slave.sv
// Created:     3/1/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: APB Slave Interface

module apb_slave (
    input wire clk,
    input wire n_rst,
    input wire [7:0] rx_data,
    input wire data_ready,
    input wire overrun_error,
    input wire framing_error,
    input wire psel,
    input wire [2:0] paddr,
    input wire penable,
    input wire pwrite,
    input wire [7:0] pwdata,
    output reg data_read,
    output reg [7:0] prdata,
    output reg pslverr,
    output reg [3:0] data_size,
    output reg [13:0] bit_period
);
reg next_data_read;
reg [7:0] next_prdata;
reg [5:0] upper_bit_period;
reg [7:0] lower_bit_period;
reg [3:0] next_data_size;
reg next_pslverr;

always_ff @( posedge clk, negedge n_rst ) begin : REGISTER
    if(!n_rst)
    begin
        prdata <= '0;
        bit_period <= '0;
        data_size <= '0;
        data_read <= '0;
        pslverr <= '0;
    end
    else
    begin
        prdata <= next_prdata;
        bit_period[7:0] <= lower_bit_period;
        bit_period[13:8] <= upper_bit_period;
        data_size <= next_data_size;
        data_read <= next_data_read;
        pslverr <= next_pslverr;
    end
end

always_comb begin
    next_data_read = 1'b0;
    next_data_size = data_size;
    next_prdata = prdata;
    lower_bit_period = bit_period[7:0];
    upper_bit_period = bit_period[13:8];
    next_pslverr = 1'b0;
    if(psel) begin
        if(pwrite == 1'b0) begin
            case (paddr)
                3'd0: begin
                    next_prdata = {7'b0000000, data_ready};
                end 
                3'd1: begin
                    next_prdata = {6'b000000, overrun_error, framing_error};
                end
                3'd2: begin // Lower bit_period
                    next_prdata = bit_period[7:0];
                end
                3'd3: begin
                    next_prdata = {2'b00, bit_period[13:8]};
                end
                3'd4: begin
                    next_prdata = {4'b0000, data_size};
                end
                3'd6: begin
                    next_prdata = rx_data;
                    next_data_read = 1'b1;
                end
                default: begin
                    next_pslverr = 1'b1;
                end
            endcase
        end
        else begin
            case (paddr)
                3'd2: begin
                    lower_bit_period = pwdata;
                end 
                3'd3: begin
                    upper_bit_period = pwdata[5:0];
                end
                3'd4: begin // Lower bit_period
                    next_data_size = pwdata[3:0];
                end
                default: begin
                    next_pslverr = 1'b1;
                end
            endcase
        end
    end
end

endmodule