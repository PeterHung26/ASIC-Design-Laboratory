// $Id: $
// File name:   magnitude.sv
// Created:     2/22/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: .

module magnitude(
    input wire [16:0] in,
    output reg [15:0] out
);

always_comb begin : CONVERT
    if(in[16] == 1'b1) begin
        out = ~in[15:0] + 1;
    end
    else
        out = in[15:0];
end

endmodule