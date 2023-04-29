// $Id: $
// File name:   d_plus_selecter.sv
// Created:     4/12/2023
// Author:      Te Yu Hsin
// Lab Section: 337-17
// Version:     1.0  Initial Design Entry
// Description: .

module d_plus_selecter (
    input logic d_encoded,
    input logic eop,
    input logic idle,
    output logic d_plus_out
);

always_comb begin
    if (eop) begin
        d_plus_out = 0;
    end
    else if (idle) begin
        d_plus_out = 1;
    end
    else begin
        d_plus_out = d_encoded;
    end
end

    
endmodule