// $Id: $
// File name:   moore.sv
// Created:     2/10/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Moore Machine ‘1101’ Detector Design
module moore 
(
    input wire clk,
    input wire n_rst,
    input wire i,
    output wire o
);

typedef enum logic [2:0] { WAITING, RCV1, RCV11, RCV110, RCV1101 } statetype;
statetype nextstate;
statetype state;

always_ff @(posedge clk,negedge n_rst)
begin:StateReg
    if (n_rst == 0)
        state <= WAITING;
    else
        state <= nextstate;
end

always_comb 
begin : Next_state
    nextstate = state;
    case (state)
        WAITING: begin
            if (i == 0)
                nextstate = WAITING;
            else
                nextstate = RCV1;
        end
        RCV1: begin
            if (i == 1)
                nextstate = RCV11;
            else
                nextstate = WAITING;
        end
        RCV11: begin
            if (i == 1)
            nextstate = RCV11;
            else
            nextstate = RCV110;
        end
        RCV110: begin
            if (i == 1)
            nextstate = RCV1101;
            else
            nextstate = WAITING;
        end
        RCV1101: begin
            if (i == 1)
            nextstate = RCV11;
            else
            nextstate = WAITING;
        end
    endcase
end

assign o = (state == RCV1101);

endmodule