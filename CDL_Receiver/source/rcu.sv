module rcu
(
    input wire clk,
    input wire n_rst,
    input wire d_edge,
    input wire shift_enable,
    input wire byte_received,
    input wire [7:0] p_out,
    input wire [7:0] old_2_byte,
    input wire [7:0] new_2_byte,
    input wire eop,
    input wire done_2,
    input wire done_64,
    output reg disable_timer,
    output reg rcving,
    output reg flush,
    output reg r_error,
    output reg store_pid,
    output reg load_buf,
    output reg w_enable,
    output reg ready
    //output reg nak
);

typedef enum logic [4:0] { IDLE, EIDLE, RESET, READING_SYNC, CHECKING_SYNC, READ_PID, CHECKSTORE_PID,
                            READ_DATA, RECEIVED_DATA, STORE_DATA, WAIT_FOR_EOP, READ_ADRESS, RECEIVED_ADRESS,
                            ADRESS_DONE, ADRESS_CHECK, ADRESS_CORRECT, WAIT, EOP1, ERROR, ERROR_EOP1  
                            } statetype;

statetype state;
statetype nxt_state;

always_comb begin: NEXT_STATE
    nxt_state = state;
    case(state)
        IDLE: begin
            if(d_edge)
                nxt_state = RESET;
        end
        EIDLE: begin
            if(d_edge)
                nxt_state = RESET;
        end
        RESET: begin
            nxt_state = READING_SYNC;
        end
        READING_SYNC: begin
            if(byte_received)
                nxt_state = CHECKING_SYNC;
        end
        CHECKING_SYNC: begin
            if(p_out == 8'b10000000)
                nxt_state = READ_PID;
            else
                nxt_state = ERROR;
        end
        READ_PID: begin
            if(byte_received)
                nxt_state = CHECKSTORE_PID;
        end
        CHECKSTORE_PID: begin
            if((p_out == 8'b11010010) || (p_out == 8'b01011010) || (p_out == 8'b00011110))
                nxt_state = WAIT;
            else if((p_out == 8'b11100001) || (p_out == 8'b01101001))
                nxt_state = READ_ADRESS;
            else if((p_out == 8'b11000011) || (p_out == 8'b01001011))
                nxt_state = READ_DATA;
            else
                nxt_state = ERROR;
        end
        WAIT: begin
            if(eop && shift_enable)
                nxt_state = EOP1;
        end
        READ_ADRESS: begin
            if(byte_received)
                nxt_state = RECEIVED_ADRESS;
            else if(eop && shift_enable)
                nxt_state = ERROR_EOP1;
        end
        RECEIVED_ADRESS: begin
            nxt_state = ADRESS_DONE;
        end
        ADRESS_DONE: begin
            if(!done_2)
                nxt_state = READ_ADRESS;
            else
                nxt_state = ADRESS_CHECK;
        end
        ADRESS_CHECK: begin
            if((old_2_byte[6:0] == 7'b0000001) && ({new_2_byte[2:0], old_2_byte[7]} == 4'b0001))
                nxt_state = ADRESS_CORRECT;
            else
                nxt_state = ERROR;
        end
        ADRESS_CORRECT: begin
            if(eop && shift_enable)
                nxt_state = EOP1;
        end
        READ_DATA: begin
            if(byte_received)
                nxt_state = RECEIVED_DATA;
            else if(eop && shift_enable)
                nxt_state = ERROR_EOP1;
        end
        RECEIVED_DATA: begin
            if(!done_2)
                nxt_state = WAIT_FOR_EOP;
            else
                nxt_state = STORE_DATA;
        end
        STORE_DATA: begin
            if(!done_64)
                nxt_state = WAIT_FOR_EOP;
            else
                nxt_state = ERROR;
        end
        WAIT_FOR_EOP: begin
            if(!eop && shift_enable)
                nxt_state = READ_DATA;
            else if(eop && shift_enable && done_2)
                nxt_state = EOP1;
            else if(eop && shift_enable && !done_2)
                nxt_state = ERROR_EOP1;
        end
        EOP1: begin
            if(eop && shift_enable)
                nxt_state = IDLE;
        end
        ERROR: begin
            if(eop && shift_enable)
                nxt_state = ERROR_EOP1;
        end
        ERROR_EOP1: begin
            if(eop && shift_enable)
                nxt_state = EIDLE;
        end
    endcase
end

always_ff @(posedge clk, negedge n_rst) begin: STATE_REGISTER
    if(!n_rst)
        state <= IDLE;
    else
        state <= nxt_state;
end

always_comb begin: OUTPUT_LOGIC
    disable_timer = 1'b0;
    rcving = 1'b0;
    flush = 1'b0;
    r_error = 1'b0;
    store_pid = 1'b0;
    load_buf = 1'b0;
    w_enable = 1'b0;
    ready = 1'b0;
    //nak = 1'b0;
    case(state)
        IDLE: begin
            disable_timer = 1'b1;
        end
        EIDLE: begin
            r_error = 1'b1;
            disable_timer = 1'b1;
        end
        RESET: begin
            rcving = 1'b1;
            flush = 1'b1;
        end
        READING_SYNC: begin
            rcving = 1'b1;
        end
        CHECKING_SYNC: begin
            rcving = 1'b1;
        end
        READ_PID: begin
            rcving = 1'b1;
        end
        CHECKSTORE_PID: begin
            rcving = 1'b1;
            store_pid = 1'b1;
        end
        WAIT: begin
            rcving = 1'b1;
        end
        READ_ADRESS: begin
            rcving = 1'b1;
        end
        RECEIVED_ADRESS: begin
            rcving = 1'b1;
            load_buf = 1'b1;
        end
        ADRESS_DONE: begin
            rcving = 1'b1;
        end
        ADRESS_CHECK: begin
            rcving = 1'b1;
        end
        ADRESS_CORRECT: begin
            rcving = 1'b1;
        end
        READ_DATA: begin
            rcving = 1'b1;
        end
        RECEIVED_DATA: begin
            rcving = 1'b1;
            load_buf = 1'b1;
        end
        STORE_DATA: begin
            rcving = 1'b1;
            w_enable = 1'b1;
            ready = 1'b1;
        end
        WAIT_FOR_EOP: begin
            rcving = 1'b1;
        end
        ERROR: begin
            r_error = 1'b1;
            rcving = 1'b1;
        end
        ERROR_EOP1: begin
            r_error = 1'b1;
        end
    endcase
end
endmodule