// $Id: $
// File name:   rcu.sv
// Created:     2/16/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Receiver Control Unit (RCU)

module rcu (
    input wire clk,
    input wire n_rst,
    input wire new_packet_detected,
    input wire packet_done,
    input wire framing_error,
    output reg sbc_clear,
    output reg sbc_enable,
    output reg load_buffer,
    output reg enable_timer
);

typedef enum logic [3:0] { IDLE, CLEAR, WAIT1, DATA, DONE,CHECK, LOAD } statetype;

reg [3:0] next_state;
reg [3:0] state;

always_ff @( posedge clk, negedge n_rst ) begin : REGISTER
    if(!n_rst)
    begin
        state <= IDLE;
    end
    else
    begin
        state <= next_state;
    end
end

always_comb begin : NEXT_STATE
    next_state = state;
    case (state)
        IDLE: begin
            if(new_packet_detected)
                next_state = CLEAR;
            else
                next_state = IDLE;
        end
        CLEAR: begin
            next_state = WAIT1;
        end
        WAIT1: begin
            next_state = DATA;
        end
        DATA: begin
            if(packet_done)
                next_state = DONE;
            else
                next_state = DATA;
        end
        DONE: begin
            next_state = CHECK;
        end
        CHECK: begin
            if(!framing_error)
                next_state = LOAD;
            else
                next_state = IDLE;
        end
        LOAD: begin
            next_state = IDLE;
        end  
    endcase
end

always_comb begin: OUTPUT_LOGIC
    if(state == CLEAR) begin
        sbc_clear = 1;
        enable_timer = 1;
    end
    else begin
        sbc_clear = 0;
        enable_timer = 0;
    end
    if(state == DONE)
        sbc_enable = 1;
    else
        sbc_enable = 0;
    if(state == LOAD)
        load_buffer = 1;
    else
        load_buffer = 0;
end
endmodule