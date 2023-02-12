// $Id: $
// File name:   mealy.sv
// Created:     2/11/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Mealy Machine ‘1101’ Detector Design

module mealy 
(
    input wire clk,
    input wire n_rst,
    input wire i,
    output reg o
);

reg [2:0] state, nextstate;
parameter [2:0] WAITING = 3'b000,
RCV1 = 3'b001,
RCV11 = 3'b010,
RCV110 = 3'b011;

//typedef enum logic [2:0] { WAITING, RCV1, RCV11, RCV110} statetype;
//statetype nextstate;
//statetype state;

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
            nextstate = RCV1;
            else
            nextstate = WAITING;
        end
    endcase
end

always_comb
begin: Output
    if(state == RCV110)
    begin
        if(i == 1)
        begin
            o = 1;
        end
        else
        begin
            o = 0;
        end
    end
    else
    begin
        o = 0;
    end
end

endmodule