module timer
(
    input wire clk,
    input wire n_rst,
    input wire d_edge,
    input wire disable_timer,
    output reg shift_enable,
    output reg byte_received
);

typedef enum logic [1:0] { STROBE_CLEAR, COUNT_TO_4, COUNT_TO_8 } statetype1;
typedef enum logic [1:0] { BYTE_IDLE, BYTE_CLEAR, BYTE_COUNT } statetype2;

statetype1 state1;
statetype1 nxt_state1;
statetype2 state2;
statetype2 nxt_state2;

//shift enable timer output
reg strobe_clear;
reg strobe_enable;
reg [3:0] strobe_rollovervalue;
reg [3:0] strobe_count;

//byte received timer output
reg byte_disable;
reg byte_enable;
reg byte_clear;
reg [3:0] byte_rollovervalue;
reg [3:0] byte_count;

always_comb begin: SHIFT_ENABLE_NEXT_STATE
    nxt_state1 = state1;
    case(state1)
        STROBE_CLEAR: begin
            nxt_state1 = COUNT_TO_4;
        end
        COUNT_TO_4: begin
            if(shift_enable)
                nxt_state1 = COUNT_TO_8;
        end
        COUNT_TO_8: begin
            if(d_edge)
                nxt_state1 = STROBE_CLEAR;
        end
    endcase
end

always_ff @(posedge clk, negedge n_rst) begin: SHIFT_ENABLE_REGISTER
    if(!n_rst) begin
        state1 <= STROBE_CLEAR;
    end
    else begin
        state1 <= nxt_state1;
    end
end

always_comb begin:  SHIFT_ENABLE_OUTPUT_LOGIC
    strobe_clear = 1'b0;
    strobe_enable = 1'b0;
    strobe_rollovervalue = '0;
    case(state1)
        STROBE_CLEAR: begin
            strobe_clear = 1'b1;
        end
        COUNT_TO_4: begin
            strobe_enable = 1'b1;
            strobe_rollovervalue = 4'd3;
        end
        COUNT_TO_8: begin
            strobe_enable = 1'b1;
            strobe_rollovervalue = 4'd8;
        end
    endcase
end

flex_counter
CORE1(
    .clk(clk),
    .n_rst(n_rst),
    .clear(strobe_clear),
    .count_enable(strobe_enable),
    .rollover_val(strobe_rollovervalue),
    .count_out(strobe_count),
    .rollover_flag(shift_enable)
);

always_comb begin: BYTE_RECEIVED_NEXT_STATE
    nxt_state2 = state2;
    case(state2)
        BYTE_IDLE: begin
            if(d_edge)
                nxt_state2 = BYTE_CLEAR;
        end
        BYTE_CLEAR: begin
            nxt_state2 = BYTE_COUNT;
        end
        BYTE_COUNT: begin
            if(disable_timer)
                nxt_state2 = BYTE_IDLE;
        end
    endcase
end

always_ff @(posedge clk, negedge n_rst) begin: BYTE_RECEIVED_REGISTER
    if(!n_rst) begin
        state2 <= BYTE_IDLE;
    end
    else begin
        state2 <= nxt_state2;
    end
end

always_comb begin:  BYTE_RECEIVED_OUTPUT_LOGIC
    byte_disable = 1'b0;
    byte_clear = 1'b0;
    byte_rollovervalue = '0;
    case(state2)
        BYTE_IDLE: begin
            byte_disable = 1'b1;
        end
        BYTE_CLEAR: begin
            byte_clear = 1'b1;
        end
        BYTE_COUNT: begin
            byte_rollovervalue = 4'd8;
        end
    endcase
end

always_comb begin: BYTE_TIMER_ENABLE_LOGIC
    byte_enable = 1'b0;
    if(byte_disable)
        byte_enable = 1'b0;
    else if(shift_enable)
        byte_enable = 1'b1;
end

flex_counter
CORE2(
    .clk(clk),
    .n_rst(n_rst),
    .clear(byte_clear),
    .count_enable(byte_enable),
    .rollover_val(byte_rollovervalue),
    .count_out(byte_count),
    .rollover_flag(byte_received)
);

endmodule