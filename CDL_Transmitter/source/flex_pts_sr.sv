// $Id: $
// File name:   flex_pts_sr.sv
// Created:     2/8/2023
// Author:      Te Yu Hsin
// Lab Section: 337-17
// Version:     1.0  Initial Design Entry
// Description: .

module flex_pts_sr #(
    parameter NUM_BITS = 4,
    parameter SHIFT_MSB = 1
) (
    input logic clk,
    input logic n_rst,
    input logic shift_enable,
    input logic load_enable,
    input logic [NUM_BITS - 1:0] parallel_in,
    output logic serial_out
);
    logic [NUM_BITS - 1:0] next_parallel_out;
    logic [NUM_BITS - 1:0] parallel_out;

    always_ff @( posedge clk, negedge n_rst ) begin
        if(!n_rst) begin
            parallel_out <= '1;
        end
        else begin
            parallel_out <= next_parallel_out;
        end
    end

    always_comb begin
        if (load_enable) begin
            next_parallel_out = parallel_in;
        end
        else if (shift_enable) begin
            if (SHIFT_MSB) begin

                //mapped version will be wrong when using this, may because it will cause metastability
                //next_parallel_out = next_parallel_out << 1;
                //next_parallel_out[0] = 1;
                next_parallel_out = {parallel_out[NUM_BITS - 2:0], 1'b1};
            end
            else begin

                //mapped version will be wrong when using this, may because it will cause metastability
                //next_parallel_out = next_parallel_out >> 1;
                //next_parallel_out[NUM_BITS - 1] = 1;
                next_parallel_out = {1'b1, parallel_out[NUM_BITS - 1:1]};
            end
        end
        else begin
            next_parallel_out = parallel_out;
        end
    end

    always_comb begin
        if(!n_rst) begin
            serial_out = '1;
        end
        else begin
            if (SHIFT_MSB) begin
            // left shift
                serial_out = parallel_out[NUM_BITS - 1];
            end
            else begin
            // right shift
                serial_out = parallel_out[0];
            end
        end
    end
        
endmodule