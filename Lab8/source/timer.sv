// $Id: $
// File name:   timer.sv
// Created:     2/16/2023
// Author:      Wen-Bo Hung
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Timing Controller

module timer (
    input wire clk,
    input wire n_rst,
    input wire enable_timer,
    output reg shift_strobe,
    output reg packet_done,
    input wire [13:0] bit_period,
    input wire [3:0] data_size
);
reg [1:0] state;
reg [1:0] next_state;
reg [13:0] bit_count;
reg [13:0] clk_count;
reg clear;
reg enable_clk;
reg enable_bit;
reg rollflag_clk;
reg rollflag_bit;

flex_counter #(.NUM_CNT_BITS(14)) CLK_COUNT (
    .clk(clk),
    .n_rst(n_rst),
    .clear(clear),
    .count_enable(enable_clk),
    .rollover_val(bit_period),
    .count_out(clk_count),
    .rollover_flag(rollflag_clk)
  );

flex_counter #(.NUM_CNT_BITS(14)) BIT_COUNT  (
    .clk(clk),
    .n_rst(n_rst),
    .clear(clear),
    .count_enable(enable_bit),
    .rollover_val(14'd10),
    .count_out(bit_count),
    .rollover_flag(rollflag_bit)
  );


typedef enum logic [3:0] { IDLE, CLEAR, COUNT, DONE} statetype;

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
            if(enable_timer == 1)
                next_state = CLEAR;
            else
                next_state = state;
        end 
        CLEAR: begin
            next_state = COUNT;
        end
        COUNT: begin
            if((bit_count == data_size + 1))
                next_state = DONE;
            else
                next_state = state;
        end
        DONE: begin
            next_state = IDLE;
        end
    endcase
end

always_comb begin : OUTPUT_LOGIC
    if(state == CLEAR)
        clear = 1;
    else
        clear = 0;
    if(state == COUNT) begin
        enable_clk = 1;
    end
    else begin
        enable_clk = 0;
    end
    if(state == DONE)
        packet_done = 1;
    else
        packet_done = 0;
    if(rollflag_clk) begin
        enable_bit = 1;
        shift_strobe = 1;
    end
    else begin
        enable_bit = 0;
        shift_strobe = 0;
    end
end




endmodule
