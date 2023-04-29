// $Id: $
// File name:   d_minus_selecter.sv
// Created:     4/12/2023
// Author:      Te Yu Hsin
// Lab Section: 337-17
// Version:     1.0  Initial Design Entry
// Description: .
module d_minus_selecter (
    input logic d_encoded,
    input logic eop,
    input logic idle,
    output logic d_minus_out
);

always_comb begin
    if (eop) begin
        d_minus_out = 0;
    end
    else if (idle) begin
        d_minus_out = 0;
    end
    else begin
        d_minus_out = !d_encoded;
    end
end

    
endmodule