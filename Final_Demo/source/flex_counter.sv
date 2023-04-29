// $Id: $
// File name:   flex_counter.sv
// Created:     2/1/2023
// Author:      Te Yu Hsin
// Lab Section: 337-17
// Version:     1.0  Initial Design Entry
// Description: .

module flex_counter #(
    parameter NUM_CNT_BITS = 4
)
(
    input logic clk,
    input logic n_rst,
    input logic clear,
    input logic count_enable,
    input logic [NUM_CNT_BITS - 1:0] rollover_val,
    output logic [NUM_CNT_BITS - 1:0] count_out,
    output logic rollover_flag
);
logic [NUM_CNT_BITS - 1:0] count_next;
logic rollover_flag_next;

always_ff @( posedge clk, negedge n_rst ) begin
    if (!n_rst) begin
        count_out <= '0;
        rollover_flag <= '0;
    end
    else begin
        count_out <= count_next;
        rollover_flag <= rollover_flag_next;

    end
end

always_comb begin
    if(clear) begin
        count_next = '0;
    end
    else if (count_enable) begin
        if (rollover_val == count_out) begin
            count_next = 4'b1;               
        end
        else begin
            count_next = count_out + 1;
        end
    end
    else begin
        count_next = count_out;
    end

    if (clear) begin
        rollover_flag_next = 0;
    end
    else if (rollover_val == count_next) begin
        rollover_flag_next = 1;  
    end          
    else begin
        rollover_flag_next = 0;
    end
end
    
endmodule