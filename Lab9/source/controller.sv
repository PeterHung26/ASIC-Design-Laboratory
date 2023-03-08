// $Id: $
// File name:   controller.sv
// Created:     2/22/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Controller

module controller (
    input wire clk,
    input wire n_rst,
    input wire dr,
    input wire lc,
    input wire overflow,
    output reg cnt_up,
    output reg clear,
    output reg modwait,
    output reg [2:0] op,
    output reg [3:0] src1,
    output reg [3:0] src2,
    output reg [3:0] dest,
    output reg err
);

typedef enum logic [4:0] { IDLE, EIDLE, STORE, ZERO, SORT1, SORT2, SORT3, SORT4, MUL1, SUB1, MUL2, ADD1, MUL3, SUB2, MUL4, ADD2, CO1, DONE1, CO2, DONE2, CO3, DONE3, CO4} statetype;
statetype state;
statetype next_state;

typedef enum logic [2:0] {NOP = 3'b000, COPY = 3'b001, LOAD1 = 3'b010, LOAD2 = 3'b011, ADD = 3'b100, SUB = 3'b101, MUL = 3'b110} optype;
reg next_modwait;

always_ff @(posedge clk, negedge n_rst) begin : STATE_REGISTER 
    if(!n_rst) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always_ff @(posedge clk, negedge n_rst) begin : MODWAIT_REGISTER 
    if(!n_rst) begin
        modwait <= 1'b0;
    end
    else begin
        modwait <= next_modwait;
    end
end

always_comb begin : NEXT_STATE
    next_state = state;
    case (state)
        IDLE: begin
            if(dr == 1)
                next_state = STORE;
            else if(lc == 1)
                next_state = CO1;
            else
                next_state = IDLE;
        end
        EIDLE: begin
            if(dr == 1)
                next_state = STORE;
            else if(lc == 1)
                next_state = CO1;
            else
                next_state = EIDLE;
        end
        STORE: begin
            if(dr == 0)
                next_state = EIDLE;
            else
                next_state = ZERO;
        end
        ZERO: begin
            next_state = SORT1;
        end
        SORT1: begin
            next_state = SORT2;
        end
        SORT2: begin
            next_state = SORT3;
        end
        SORT3: begin
            next_state = SORT4;
        end
        SORT4: begin
            next_state = MUL1;
        end
        MUL1: begin
            next_state = SUB1;
        end  
        SUB1: begin
            if(overflow == 1)
                next_state = EIDLE;
            else
                next_state = MUL2;
        end
        MUL2: begin
            next_state = ADD1;
        end
        ADD1: begin
            if(overflow == 1)
                next_state = EIDLE;
            else
                next_state = MUL3;
        end
        MUL3: begin
            next_state = SUB2;
        end
        SUB2: begin
            if(overflow == 1)
                next_state = EIDLE;
            else
                next_state = MUL4;
        end
        MUL4: begin
            next_state = ADD2;
        end
        ADD2: begin
            if(overflow == 1)
                next_state = EIDLE;
            else
                next_state = IDLE;
        end
        CO1: begin
            next_state = DONE1;
        end
        DONE1: begin
            if(lc == 0)
                next_state = DONE1;
            else
                next_state = CO2;
        end
        CO2: begin
            next_state = DONE2;
        end
        DONE2: begin
            if(lc == 0)
                next_state = DONE2;
            else
                next_state = CO3;
        end
        CO3: begin
            next_state = DONE3;
        end
        DONE3: begin
            if(lc == 0)
                next_state = DONE3;
            else
                next_state = CO4;
        end
        CO4: begin
            next_state = IDLE;
        end
    endcase
end

always_comb begin: OUTPUT_LOGIC
    if(state == STORE) // output of op
        op = LOAD1;
    else if((state == CO1) || (state == CO2) || (state == CO3) || (state == CO4))
        op = LOAD2;
    else if((state == SORT1) || (state == SORT2) || (state == SORT3) || (state == SORT4))
        op = COPY;
    else if((state == ADD1) ||(state == ADD2))
        op = ADD;
    else if((state == SUB1) || (state == SUB2) || (state == ZERO))
        op = SUB;
    else if((state == MUL1) || (state == MUL2) || (state == MUL3) || (state == MUL4))
        op = MUL;
    else
        op = NOP;
    /*if((state == IDLE) || (state == EIDLE) || (state == DONE1) || (state == DONE2) || (state == DONE3))
        modwait = 1'b0;
    else
        modwait = 1'b1;*/
    if(state == EIDLE)
        err = 1'b1;
    else
        err = 1'b0;
    if(state == STORE)
        cnt_up = 1'b1;
    else
        cnt_up = 1'b0;
    if(state == CO1)
        clear = 1'b1;
    else
        clear = 1'b0;
    if(state == CO1)
        dest = 4'd8;
    else if(state == CO2)
        dest = 4'd7;
    else if(state == CO3)
        dest = 4'd6;
    else if(state == CO4)
        dest = 4'd5;
    else if(state == STORE)
        dest = 4'd9;
    else if(state == SORT1)
        dest = 4'd1;
    else if(state == SORT2)
        dest = 4'd2;
    else if(state == SORT3)
        dest = 4'd3;
    else if(state == SORT4)
        dest = 4'd4;
    else if((state == ZERO) || (state == SUB1) || (state == SUB2) || (state == ADD1) || (state == ADD2))
        dest = 4'd0;
    else if((state == MUL1) || (state == MUL2) || ( state == MUL3) || (state == MUL4))
        dest = 4'd10;
    else
        dest = 4'd15;
    if((state == ZERO) || (state == SUB1) || (state == SUB2) || (state == ADD1) || (state == ADD2))
        src1 = 4'd0;
    else if((state == SORT1) || (state == MUL3))
        src1 = 4'd2;
    else if((state == SORT2) || (state == MUL2))
        src1 = 4'd3;
    else if((state == SORT3) || (state == MUL1))
        src1 = 4'd4;
    else if(state == SORT4)
        src1 = 4'd9;
    else if(state == MUL4)
        src1 = 4'd1;
    else
        src1 = 4'd15;
    if(state == ZERO)
        src2 = 4'd0;
    else if(state == MUL1)
        src2 = 4'd8;
    else if(state == MUL2)
        src2 = 4'd7;
    else if(state == MUL3)
        src2 = 4'd6;
    else if(state == MUL4)
        src2 = 4'd5;
    else if((state == ADD1) || (state == ADD2) || (state == SUB1) || (state == SUB2))
        src2 = 4'd10;
    else
        src2 = 4'd15;
end

always_comb begin: NEXT_MODWAIT
    if(((state == IDLE) && (dr == 1'b0) && (lc == 1'b0)) || ((state == EIDLE) && (dr == 1'b0) && (lc == 1'b0))
    || (state == ADD2) || (state == CO1) || (state == CO2) || (state == CO3) || (state == CO4) ||
    ((state == DONE1) && (lc == 1'b0)) || ((state == DONE2) && (lc == 1'b0)) || ((state == DONE3) && (lc == 1'b0)))
        next_modwait = 1'b0;
    else
        next_modwait = 1'b1;
end
endmodule