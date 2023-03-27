// $Id: $
// File name:   ahb_lite_slave.sv
// Created:     3/9/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: AHB-Lite-Slave Interface
module ahb_lite_slave(
    input wire clk,
    input wire n_rst,
    input wire [1:0] coefficient_num,
    input wire modwait,
    input wire [15:0] fir_out,
    input wire err,
    input wire hsel,
    input wire [3:0] haddr,
    input wire hsize,
    input wire [1:0] htrans,
    input wire hwrite,
    input wire [15:0] hwdata,
    input wire clear_new_coeff,
    output reg [15:0] sample_data,
    output reg data_ready,
    output reg new_coefficient_set,
    output reg [15:0] fir_coefficient,
    output reg [15:0] hrdata,
    output reg hresp
);
reg [15:0] f0;
reg [15:0] f1;
reg [15:0] f2;
reg [15:0] f3;
reg [3:0] write_select;
reg next_new_coefficient_set;
reg [15:0] next_f0;
reg [15:0] next_f1;
reg [15:0] next_f2;
reg [15:0] next_f3;
reg [15:0] next_hrdata;
reg [15:0] next_sample_data;
reg [3:0] next_write_select;
reg next_data_ready;
reg size;
reg next_size;

parameter [1:0] IDLE = 2'b00, DELAY_BURST = 2'b01, NON_SEQUENTIAL = 2'b10, SEQUENTIAL = 2'b11;

always_ff @( posedge clk, negedge n_rst ) begin : REGISTER
    if(!n_rst)
    begin
        hrdata <= '0;
        f0 <= '0;
        f1 <= '0;
        f2 <= '0;
        f3 <= '0;
        new_coefficient_set <= '0;
        sample_data <= '0;
        write_select <= 4'hF;
        data_ready <= '0;
        size <= '0;
    end
    else
    begin
        hrdata <= next_hrdata;
        f0 <= next_f0;
        f1 <= next_f1;
        f2 <= next_f2;
        f3 <= next_f3;
        new_coefficient_set <= next_new_coefficient_set;
        sample_data <= next_sample_data;
        write_select <= next_write_select;
        data_ready <= next_data_ready;
        size <= next_size;
    end
end

always_comb begin : READ_AND_WRITE_SELECT
    next_hrdata = hrdata;
    next_write_select = 4'hF;
    hresp = 1'b0;
    next_size = size;
    if(hsel) begin
        if(htrans == NON_SEQUENTIAL) begin
            if(hwrite) begin
                case (haddr)
                    4'd4: begin 
                        next_write_select = haddr;
                        next_size = hsize;
                    end
                    4'd5: begin 
                        next_write_select = haddr;
                        next_size = hsize;
                    end
                    4'd6: begin 
                        next_write_select = haddr;
                        next_size = hsize;
                    end
                    4'd7: begin 
                        next_write_select = haddr;
                        next_size = hsize;
                    end
                    4'd8: begin 
                        next_write_select = haddr;
                        next_size = hsize;
                    end
                    4'd9: begin 
                        next_write_select = haddr;
                        next_size = hsize;
                    end
                    4'hA: begin 
                        next_write_select = haddr;
                        next_size = hsize;
                    end
                    4'hB: begin 
                        next_write_select = haddr;
                        next_size = hsize;
                    end
                    4'hC: begin 
                        next_write_select = haddr;
                        next_size = hsize;
                    end
                    4'hD: begin 
                        next_write_select = haddr;
                        next_size = hsize;
                    end
                    4'hE: begin
                        next_write_select = haddr;
                    end
                    default: begin
                        hresp = 1'b1;
                    end
                endcase
            end
            else begin
                case (haddr)
                    4'd0: begin
                        if(hsize == 1'b0)
                            next_hrdata = {15'b0, modwait | new_coefficient_set};
                        else
                            next_hrdata = {7'b0, err, 7'b0, modwait | new_coefficient_set};
                    end
                    4'd1: begin
                        if(hsize == 1'b0)
                            next_hrdata = {15'b0, err};
                        else
                            next_hrdata = {7'b0000000, err, 7'b0000000, modwait | new_coefficient_set};
                    end 
                    4'd2: begin
                        if(hsize == 1'b0)
                            next_hrdata = {8'b0, fir_out[7:0]};
                        else
                            next_hrdata = fir_out;
                    end
                    4'd3: begin
                        if(hsize == 1'b0)
                            next_hrdata = {8'b0, fir_out[15:8]};
                        else
                            next_hrdata = fir_out;
                    end
                    4'd4: begin
                        if(hsize == 1'b0)
                            next_hrdata = {8'b0, next_sample_data[7:0]};
                        else
                            next_hrdata = next_sample_data;
                    end
                    4'd5: begin
                        if(hsize == 1'b0)
                            next_hrdata = {8'b0, next_sample_data[15:8]};
                        else
                            next_hrdata = next_sample_data; 
                    end
                    4'd6: begin
                        if(hsize == 1'b0)
                            next_hrdata = {8'b0, next_f0[7:0]};
                        else
                            next_hrdata = next_f0;
                    end
                    4'd7: begin
                        if(hsize == 1'b0)
                            next_hrdata = {8'b0, next_f0[15:8]};
                        else
                            next_hrdata = next_f0; 
                    end
                    4'd8: begin
                        if(hsize == 1'b0)
                            next_hrdata = {8'b0, next_f1[7:0]};
                        else
                            next_hrdata = next_f1; 
                    end
                    4'd9: begin
                        if(hsize == 1'b0)
                            next_hrdata = {8'b0, next_f1[15:8]};
                        else
                            next_hrdata = next_f1; 
                    end
                    4'hA: begin
                        if(hsize == 1'b0)
                            next_hrdata = {8'b0, next_f2[7:0]};
                        else
                            next_hrdata = next_f2; 
                    end
                    4'hB: begin
                            if(hsize == 1'b0)
                                next_hrdata = {8'b0, next_f2[15:8]};
                            else
                                next_hrdata = next_f2; 
                    end
                    4'hC: begin
                        if(hsize == 1'b0)
                            next_hrdata = {8'b0, next_f3[7:0]};
                        else
                            next_hrdata = next_f3; 
                    end
                    4'hD: begin
                        if(hsize == 1'b0)
                            next_hrdata = {8'b0, next_f3[15:8]};
                        else
                            next_hrdata = next_f3; 
                    end
                    4'hE: begin
                        if(hsize == 1'b0)
                            next_hrdata = {15'b0, next_new_coefficient_set};
                        else
                            hresp = 1'b1;
                    end
                    default: begin
                        hresp = 1'b1;
                    end
                endcase
            end
        end
    end
end

always_comb begin : FIR_COEFFICIENT
    case (coefficient_num)
        3'd0: begin
            fir_coefficient = f0;
        end 
        3'd1: begin
            fir_coefficient = f1;
        end
        3'd2: begin 
            fir_coefficient = f2;
        end
        3'd3: begin
            fir_coefficient = f3;
        end
    endcase
end

always_comb begin : WRITE
    next_f0 = f0;
    next_f1 = f1;
    next_f2 = f2;
    next_f3 = f3;
    next_new_coefficient_set = new_coefficient_set;
    next_sample_data = sample_data;
    next_data_ready = data_ready;
    if(clear_new_coeff)
        next_new_coefficient_set = 1'b0;
    if(modwait) begin
        next_data_ready = 1'b0;
    end
    case (write_select)
        4'h4: begin
            if(size == 1'b0)
                next_sample_data = {sample_data[15:8],hwdata[7:0]};
            else
                next_sample_data = hwdata;
            if(!modwait)
                next_data_ready = 1'b1;
            else
                next_data_ready = 1'b0;
        end
        4'h5: begin
            if(size == 1'b0)
                next_sample_data = {hwdata[7:0],sample_data[7:0]};
            else
                next_sample_data = hwdata;
            if(!modwait)
                next_data_ready = 1'b1;
            else
                next_data_ready = 1'b0;
        end
        4'h6: begin
            if(size == 1'b0)
                next_f0 = {f0[15:8],hwdata[7:0]};
            else
                next_f0 = hwdata;
        end
        4'h7: begin
            if(size == 1'b0)
                next_f0 = {hwdata[7:0],f0[7:0]};
            else
                next_f0 = hwdata;
        end
        4'h8: begin
            if(size == 1'b0)
                next_f1 = {f1[15:8],hwdata[7:0]};
            else
                next_f1 = hwdata;
        end
        4'h9: begin
            if(size == 1'b0)
                next_f1 = {hwdata[7:0],f1[7:0]};
            else
                next_f1 = hwdata;
        end
        4'hA: begin
            if(size == 1'b0)
                next_f2 = {f2[15:8],hwdata[7:0]};
            else
                next_f2 = hwdata;
        end
        4'hB: begin
            if(size == 1'b0)
                next_f2 = {hwdata[7:0],f2[7:0]};
            else
                next_f2 = hwdata;
        end
        4'hC: begin
            if(size == 1'b0)
                next_f3 = {f3[15:8],hwdata[7:0]};
            else
                next_f3 = hwdata;
        end
        4'hD: begin
            if(size == 1'b0)
                next_f3 = {hwdata[7:0],f3[7:0]};
            else
                next_f3 = hwdata;
        end
        4'hE: begin
            if(clear_new_coeff)
                next_new_coefficient_set = 1'b0;
            else
                next_new_coefficient_set = hwdata[0];
        end
    endcase
end

endmodule