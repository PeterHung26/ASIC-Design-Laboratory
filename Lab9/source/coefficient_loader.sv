// $Id: $
// File name:   coefficient_loader.sv
// Created:     3/9/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Coefficient Loader Module

module coefficient_loader(
    input wire clk,
    input wire n_reset,
    input wire new_coefficient_set,
    input wire modwait,
    output reg load_coeff,
    output reg [1:0] coefficient_num,
    output reg clear_new_coeff
);

parameter [3:0] IDLE = 4'b0000, PRIOR_F0 = 4'b0001, LOAD_F0 = 4'b0010, PRIOR_F1 = 4'b0011, LOAD_F1 = 4'b0100,
                PRIOR_F2 = 4'b0101, LOAD_F2 = 4'b0110, PRIOR_F3 = 4'b0111, LOAD_F3 = 4'b1000;

reg [3:0] state;
reg [3:0] next_state;

always_ff @(posedge clk, negedge n_reset) begin: REGISTER
    if(!n_reset) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always_comb begin
    load_coeff = 1'b0;
    coefficient_num = 2'd0;
    clear_new_coeff = 1'b0;
    next_state = state;
    case (state)
        IDLE: begin
            if((new_coefficient_set == 1) && (modwait == 0))
                next_state = PRIOR_F0;
            else
                next_state = IDLE;
        end
        PRIOR_F0: begin
            load_coeff = 1'b1;
            next_state = LOAD_F0;
        end
        LOAD_F0: begin
            load_coeff = 1'b1;
            coefficient_num = 2'd0;
            next_state = PRIOR_F1;
        end
        PRIOR_F1: begin
            load_coeff = 1'b1;
            next_state = LOAD_F1;
        end
        LOAD_F1: begin
            load_coeff = 1'b1;
            coefficient_num = 2'd1;
            next_state = PRIOR_F2;
        end
        PRIOR_F2: begin
            load_coeff = 1'b1;
            next_state = LOAD_F2;
        end
        LOAD_F2: begin
            load_coeff = 1'b1;
            coefficient_num = 2'd2;
            next_state = PRIOR_F3;
        end
        PRIOR_F3: begin
            load_coeff = 1'b1;
            next_state = LOAD_F3;
        end
        LOAD_F3: begin
            load_coeff = 1'b1;
            coefficient_num = 2'd3;
            clear_new_coeff = 1'b1;
            next_state = IDLE;
        end
    endcase
end

endmodule