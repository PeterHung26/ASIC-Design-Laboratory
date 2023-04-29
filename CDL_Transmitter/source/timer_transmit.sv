module timer_transmit(
  input logic clk,
  input logic n_rst,
  input logic timer_enable,
  input logic timer_clear,
  input logic tx_transfer_active,
  output logic byte_transmitted,
  output logic strobe,
  output logic strobe_middle
);

logic rollover_flag_8;
logic rollover_flag_9;
logic timer1_enable;
logic timer2_enable;

logic timer_inner_clear;
logic [3:0] count_out_bit;

typedef enum bit [3:0] { IDLE, CT8_1, CT8_1_CLEAR, CT8_2, CT8_2_CLEAR, CT9, CT9_CLEAR } stateType;
stateType state;
stateType next_state;

always_ff @( posedge clk, negedge n_rst ) begin
    if (!n_rst) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

assign byte_transmitted = (rollover_flag_8 || rollover_flag_9);

always_comb begin : NXT_LOGIC
    next_state = state;
      case (state)
          // 000
          IDLE: begin
              next_state = CT8_1;
          end
          // 011
          CT8_1: begin
              if (rollover_flag_8) begin
                  next_state = CT8_1_CLEAR;
              end
          end
          // 100
          CT8_1_CLEAR: begin
            next_state = CT8_2;
          end
          // 101
          CT8_2: begin
              if (rollover_flag_8) begin
                  next_state = CT8_2_CLEAR;
              end
          end
          // 110
          CT8_2_CLEAR: begin
            next_state = CT9;
          end
          // 111
          CT9: begin
              if (rollover_flag_9) begin
                  next_state = CT9_CLEAR;
              end
          end
          CT9_CLEAR: begin
            next_state = CT8_1;
          end
      endcase
end

always_comb begin : OUTPUT
  timer1_enable = 0;
  timer2_enable = 0;
  timer_inner_clear = 0;
  case (state)
      CT8_1: begin
          timer1_enable = 1;
      end
      CT8_1_CLEAR: begin
          timer_inner_clear = 1;
      end
      CT8_2: begin
          timer1_enable = 1;
      end
      CT8_2_CLEAR: begin
          timer_inner_clear = 1;
      end
      CT9: begin
          timer2_enable = 1;
      end
      CT9_CLEAR: begin
          timer_inner_clear = 1;
      end
  endcase
end
    
assign strobe_middle = tx_transfer_active ? (count_out_bit == 4'd4) : 0;

flex_counter #(
  .NUM_CNT_BITS(4)
) bit_counter_bit(
  .clk(clk),
  .n_rst(n_rst),
  .clear(timer_clear),
  .count_enable(timer1_enable || timer2_enable),
  .rollover_val(4'd8),
  .count_out(count_out_bit),
  .rollover_flag(strobe)
);

flex_counter #(
  .NUM_CNT_BITS(4)
) bit_counter_byte_8(
  .clk(clk),
  .n_rst(n_rst),
  .clear(timer_clear || timer_inner_clear),
  .count_enable(timer1_enable && strobe),
  .rollover_val(4'd8),
  .count_out(),
  .rollover_flag(rollover_flag_8)
);

flex_counter #(
  .NUM_CNT_BITS(4)
) bit_counter_byte_9(
  .clk(clk),
  .n_rst(n_rst),
  .clear(timer_clear || timer_inner_clear),
  .count_enable(timer2_enable && strobe),
  .rollover_val(4'd9),
  .count_out(),
  .rollover_flag(rollover_flag_9)
);



endmodule
