// $Id: $
// File name:   encoder.sv
// Created:     4/12/2023
// Author:      Te Yu Hsin
// Lab Section: 337-17
// Version:     1.0  Initial Design Entry
// Description: .

module encoder (
    input logic clk,
    input logic strobe_middle,
    input logic strobe,
    input logic n_rst,
    input logic d_orig,
    output logic d_encoded
);

logic next_d_encoded;

always_ff @( posedge clk, negedge n_rst ) begin
    if (!n_rst) begin
        d_encoded <= '1;
    end
    else begin
        d_encoded <= next_d_encoded;
    end
end

always_comb begin
    if(strobe_middle) begin
        if (d_orig) begin
            next_d_encoded = d_encoded;       
        end
        else begin
            next_d_encoded = !d_encoded;        
        end
    end
    else begin
        next_d_encoded = d_encoded;  
    end
end

    
endmodule