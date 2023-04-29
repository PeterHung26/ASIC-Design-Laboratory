// $Id: $
// File name:   rcu.sv
// Created:     2/16/2023
// Author:      Te Yu Hsin
// Lab Section: 337-17
// Version:     1.0  Initial Design Entry
// Description: .

module tmu (
    input logic clk,
    input logic n_rst,
    input logic strobe,
    input logic byte_transmitted,
    input logic [6:0] buffer_occupancy,
    input logic [3:0] tx_packet,
    output logic get_tx_packet_data,
    output logic tx_transfer_active,
    output logic tx_error,
    output logic timer_enable,
    output logic pid_start,
    output logic sync_start,
    output logic idle,
    output logic pts_load_enable,
    output logic pts_shift_enable,
    output logic timer_clear,
    output logic eop,
    output logic crc_start
);
    typedef enum bit [3:0] { IDLE, SYNC_load, SYNC, PID_load, PID, DATA_load, DATA, DATA_check, CRC_load_1, CRC_1, CRC_load_2, CRC_2, EOP_1, EOP_2, ERROR} stateType;
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

    always_comb begin : NXT_LOGIC
    next_state = state;
        case (state)
            // 0000
            IDLE: begin
                if (tx_packet != 0) begin
                    if ((tx_packet == 4'b0011) && (!buffer_occupancy)) begin
                        next_state = ERROR;
                    end                    
                    else begin
                        next_state = SYNC_load; 
                    end 
                end
            end
            // 0001
            SYNC_load: begin
                next_state = SYNC;
            end
            // 0010
            SYNC: begin
                if (byte_transmitted) begin
                    next_state = PID_load;  
                end
            end
            // 0011
            PID_load: begin
                next_state = PID;
            end
            // 0100
            PID: begin
                if (byte_transmitted) begin
                    if ((tx_packet == 4'b0011) || (tx_packet == 4'b1011)) begin
                        next_state = DATA_load;
                    end
                    else if ((tx_packet == 4'b0001) || (tx_packet == 4'b1001)) begin
                        next_state = CRC_load_1;
                    end
                    else begin
                        next_state = EOP_1;
                    end
                end
            end
            // 0101
            DATA_load: begin
                next_state = DATA;
            end
            // 0110
            DATA: begin
                if (byte_transmitted) begin
                    next_state = DATA_check;
                end
            end
            // 0111
            DATA_check: begin
                if (buffer_occupancy) begin
                    next_state = DATA_load;
                end
                else begin
                    next_state = CRC_load_1;
                end
            end
            // 1000
            CRC_load_1: begin
                next_state = CRC_1;
            end
            // 1001
            CRC_1: begin
                if (byte_transmitted) begin
                    next_state = CRC_load_2;
                end
            end
            // 1010
            CRC_load_2: begin
                next_state = CRC_2;
            end
            // 1011
            CRC_2: begin
                if (byte_transmitted) begin
                    next_state = EOP_1;
                end
            end
            // 1100
            EOP_1: begin
                if (strobe) begin
                    next_state = EOP_2;
                end
            end
            // 1101
            EOP_2: begin
                if (strobe) begin
                    next_state = IDLE;
                end
            end
            // 1110
            ERROR: begin
                if (byte_transmitted) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    always_comb begin : OUTPUT
        timer_enable = 0;
        timer_clear = 0;
        sync_start = 0;
        pid_start = 0;
        get_tx_packet_data = 0;
        tx_error = 0;
        eop = 0;
        tx_transfer_active = 0;
        pts_load_enable = 0;
        pts_shift_enable = 0;
        idle = 0;
        crc_start = 0;
        case (state)
            IDLE: begin
                timer_clear = 1;
                idle = 1;
            end
            SYNC_load: begin
                pts_load_enable = 1;
                sync_start = 1;
            end
            SYNC: begin
                timer_enable = 1;
                // sync_start = 1;
                tx_transfer_active = 1;
                pts_shift_enable = 1;
            end
            PID_load: begin
                pts_load_enable = 1;
                pid_start = 1;
            end
            PID: begin
                timer_enable = 1;
                // pid_start = 1;
                tx_transfer_active = 1;
                pts_shift_enable = 1;
            end
            DATA_load: begin
                pts_load_enable = 1;
            end
            DATA: begin
                tx_transfer_active = 1;
                pts_shift_enable = 1;
                timer_enable = 1;
            end
            DATA_check: begin
                get_tx_packet_data = 1;
                tx_transfer_active = 1;
            end
            CRC_load_1: begin
                pts_load_enable = 1;
                crc_start = 1;
            end
            CRC_1: begin
                timer_enable = 1;
                tx_transfer_active = 1;
                pts_shift_enable = 1;
            end
            CRC_load_2: begin
                pts_load_enable = 1;
                crc_start = 1;
            end
            CRC_2: begin
                timer_enable = 1;
                tx_transfer_active = 1;
                pts_shift_enable = 1;
            end
            EOP_1: begin
                eop = 1;
                tx_transfer_active = 1;
            end
            EOP_2: begin
                eop = 1;
                tx_transfer_active = 1;
            end
            ERROR: begin
                tx_error = 1;
                tx_transfer_active = 1;
                pts_load_enable = 1;
            end
        endcase
    end
    
endmodule
