// $Id: $
// File name:   sync_high.sv
// Created:     1/29/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Reset to Logic High Synchronizer
module sync_high (
    input wire clk,
    input wire n_rst,
    input wire async_in,
    output reg sync_out
);
reg meta;
always_ff @( posedge clk, negedge n_rst ) 
begin : RESET_LOW_SYNCHRONIZER
    if(n_rst == 1'b0)
    begin
        meta <= 1'b1;
        sync_out <= 1'b1;
    end
    else
    begin
        meta <= async_in;
        sync_out <= meta;
    end
end
    
endmodule