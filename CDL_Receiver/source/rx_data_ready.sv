module rx_data_ready
(
    input wire clk,
    input wire n_rst,
    input wire ready,
    input wire [6:0] buffer_occupancy,
    output reg rx_data_ready
);

typedef enum logic  { RIDLE, READY } statetype;

statetype nxt_state;
statetype state;

always_comb begin: NEXT_STATE_LOGIC
    nxt_state = state;
    case(state)
        RIDLE: begin
            if(ready)
                nxt_state = READY;
        end
        READY: begin
            if(buffer_occupancy == '0)
                nxt_state = RIDLE;
        end
    endcase
end

always_comb begin: OUTPUT_LOGIC
    rx_data_ready = 0;
    if(state == READY)
        rx_data_ready = 1;
end

always_ff @(posedge clk, negedge n_rst) begin : REGISTER
    if(!n_rst)
    begin
        state <= RIDLE;
    end
    else
    begin
        state <= nxt_state;
    end
end

endmodule