`timescale 1ns / 10ps
module tb_rcv_block();

parameter CLK_PERIOD        = 10;
parameter DATA_PERIOD  = 83.3333;

localparam OUTPUT_CHECK_DELAY = (CLK_PERIOD - 0.2);

// Endpoint Address constant
localparam USB_ADDR = 16'b0110000010000001; // Address: 7'b0000001, Endpoint number: 4'b0001, CRC:5'b01100
localparam CRC_BITS1 = 8'b00001101;
localparam CRC_BITS0 = 8'b10000000;

//PID Constants
localparam SYNC_BYTE  = 8'b10000000;
localparam PID_OUT    = 4'b0001; //11100001 -> 00001010
localparam PID_IN     = 4'b1001; //01101001 -> 01110010
localparam PID_DATA_0 = 4'b0011; //11000011 -> 00010100
localparam PID_DATA_1 = 4'b1011; //01001011 -> 01101100
localparam PID_ACK    = 4'b0010; //11010010 -> 00011011
localparam PID_NAK    = 4'b1010; //01011010 -> 01100011
localparam PID_STALL  = 4'b1110; //00011110 -> 01011111

// DUT Inputs
reg tb_clk;
reg tb_n_rst;
reg tb_d_plus;
reg tb_d_minus;
reg [6:0] tb_buffer_occupancy;

// DUT Outputs
reg tb_rx_error;
reg tb_rx_transfer_active;
//reg tb_nak;
reg tb_flush;
reg tb_rx_data_ready;
reg [3:0] tb_rx_data_packet;
reg tb_w_enable;
reg [7:0] tb_rcv_data;

// Define custom test vector
typedef struct
{
    reg [3:0] pid;
    reg [7:0] data[];
} testVector;

//Test Bench Debug Signal
// Overall test case number for reference
integer tb_test_num;
string tb_test_case;
integer j;
// Test case 'inputs' used for test stimulus
reg tb_test_prev_d_plus;
reg [6:0] tb_test_count; // record how many bytes received
testVector tb_test_vectors;
// Expected outputs for test cases
reg tb_expected_rx_error;
reg tb_expected_rx_transfer_active;
//reg tb_expected_nak;
reg tb_expected_rx_data_ready;
reg [3:0] tb_expected_rx_data_packet;
reg [7:0] tb_expected_rcv_data;

// DUT Portmap
rcv_block DUT
(
    .clk(tb_clk),
    .n_rst(tb_n_rst),
    .d_plus(tb_d_plus),
    .d_minus(tb_d_minus),
    .buffer_occupancy(tb_buffer_occupancy),
    .rx_error(tb_rx_error),
    .rx_transfer_active(tb_rx_transfer_active),
    .flush(tb_flush),
    .rx_data_ready(tb_rx_data_ready),
    .rx_packet(tb_rx_data_packet),
    .w_enable(tb_w_enable),
    .rcv_data(tb_rcv_data)
);

task reset_dut;
begin
    // Activate the design's reset (does not need to be synchronize with clock)
    tb_n_rst = 1'b0;
    tb_test_count = '0;
    tb_d_plus = 1'b1;
    tb_d_minus = 1'b0;
    tb_test_prev_d_plus = 1'b1;
    tb_buffer_occupancy = '0;
    tb_expected_rx_error = 1'b0;
    tb_expected_rx_transfer_active = 1'b0;
    //tb_expected_nak = 1'b0;
    tb_expected_rx_data_ready = 1'b0;
    tb_expected_rx_data_packet = '0;
    tb_expected_rcv_data = '0;
    // Wait for a couple clock cycles
    @(posedge tb_clk);
    @(posedge tb_clk);

    // Release the reset
    @(negedge tb_clk);
    tb_n_rst = 1;

    // Wait for a while before activating the design
    @(posedge tb_clk);
    @(posedge tb_clk);
    end
endtask

task check_outputs;
begin
    // Data recieved should match the data sent
    assert(tb_expected_rx_error == tb_rx_error)
        $info("Test case %0d: rx_error is as expected during %s", tb_test_num, tb_test_case);
    else
        $error("Test case %0d: rx_error is not as expected during %s", tb_test_num, tb_test_case);
    assert(tb_expected_rx_transfer_active == tb_rx_transfer_active)
        $info("Test case %0d: rx_transfer_active is as expected during %s", tb_test_num, tb_test_case);
    else
        $error("Test case %0d: rx_transfer_active is not as expected during %s", tb_test_num, tb_test_case);
    /*assert(tb_expected_nak == tb_nak)
        $info("Test case %0d: nak value is as expected during %s", tb_test_num, tb_test_case);
    else
        $error("Test case %0d: nak value is not as expected during %s", tb_test_num, tb_test_case);*/
    assert(tb_expected_rx_data_packet == tb_rx_data_packet)
        $info("Test case %0d: PID is as expected during %s", tb_test_num, tb_test_case);
    else
        $error("Test case %0d: PID is not as expected during %s", tb_test_num, tb_test_case);
    assert(tb_expected_rx_data_ready == tb_rx_data_ready)
        $info("Test case %0d: rx_data_ready value is as expected during %s", tb_test_num, tb_test_case);
    else
        $error("Test case %0d: rx_data_ready value is not as expected during %s", tb_test_num, tb_test_case);
    assert(tb_expected_rcv_data == tb_rcv_data)
        $info("Test case %0d: rcv_data value is as expected during %s", tb_test_num, tb_test_case);
    else
        $error("Test case %0d: rcv_data value is not as expected during %s", tb_test_num, tb_test_case);
end
endtask

task send_byte;
    input [7:0] data;
    integer i;
begin
    for(i = 0; i < 8; i = i + 1)
    begin
        if(data[i] == 0) begin
            tb_d_plus = !tb_test_prev_d_plus;
            tb_d_minus = tb_test_prev_d_plus;
            tb_test_prev_d_plus = !tb_test_prev_d_plus;
        end
        else begin
            tb_d_plus = tb_test_prev_d_plus;
            tb_d_minus = !tb_test_prev_d_plus;
        end
        #(DATA_PERIOD);
        if((tb_test_count >=4) && (tb_buffer_occupancy <= 64) && (i == 6))
            tb_buffer_occupancy = tb_buffer_occupancy + 1;
    end
    tb_test_count = tb_test_count + 1;
end
endtask

task send_bit;
    input one_bit;
begin
    if(one_bit == 1'b0) begin
        tb_d_plus = !tb_test_prev_d_plus;
        tb_d_minus = tb_test_prev_d_plus;
        tb_test_prev_d_plus = !tb_test_prev_d_plus;
    end
    else begin
        tb_d_plus = tb_test_prev_d_plus;
        tb_d_minus = !tb_test_prev_d_plus;
    end
    #(DATA_PERIOD);
end
endtask

task send_eop;
begin
    tb_d_plus = 1'b0;
    tb_d_minus = 1'b0;
    #(DATA_PERIOD*2);
    tb_d_plus = 1'b1;
    tb_d_minus = 1'b0;
    tb_test_prev_d_plus = 1'b1;
end
endtask

task test_stream;
    input testVector tv;
    integer i;
begin
    logic [7:0] pidd;
    pidd = {~tv.pid, tv.pid};
    send_byte(SYNC_BYTE); // send sync byte
    send_byte(pidd);
    for(i = 0; i < tv.data.size; i++) begin
        send_byte(tv.data[i]);
    end
    send_eop();
end
endtask

always
begin : CLK_GEN
    tb_clk = 1'b0;
    #(CLK_PERIOD / 2);
    tb_clk = 1'b1;
    #(CLK_PERIOD / 2);
end

initial
begin
    //Initialize all test bench signals
    tb_test_num = -1;
    tb_test_case = "TB Init";
    tb_test_prev_d_plus = 1'b1;
    tb_test_count = '0;
    tb_expected_rx_error = 1'b0;
    tb_expected_rx_transfer_active = 1'b0;
    //tb_expected_nak = 1'b0;
    tb_expected_rx_data_ready = 1'b0;
    tb_expected_rx_data_packet = '0;
    tb_expected_rcv_data = '0;
    //Initialize all inputs
    tb_n_rst = 1'b1;
    tb_d_plus = 1'b1;
    tb_d_minus = 1'b0;
    tb_buffer_occupancy = '0;

    //get away from time 0
    #0.1;

    //Test Case 0 : Basic Power on Reset
    tb_test_num = 0;
    tb_test_case = "Power-on reset";
    reset_dut;
    check_outputs;
    #1;
    //Test Case 1 : Send pid IN with valid address and endpoint number
    tb_test_num += 1;
    tb_test_case = "PID IN with valid address and endpoint number";
    reset_dut;
    tb_expected_rx_error = 1'b0;
    tb_expected_rx_transfer_active = 1'b0;;
    //tb_expected_nak = 1'b0;
    tb_expected_rx_data_ready = 1'b0;
    tb_expected_rx_data_packet = 4'b1001;
    tb_expected_rcv_data = 8'b00000000;
    tb_test_vectors.data = new[2];
    tb_test_vectors.pid = PID_IN;
    tb_test_vectors.data[0] = USB_ADDR[7:0];//ADDRESS: 7'b0000001, Endpoint number: 4'b0001, CRC number: 5'b00000
    tb_test_vectors.data[1] = USB_ADDR[15:8];
    @(negedge tb_clk);
    test_stream(tb_test_vectors);
    #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder
    check_outputs;
    #1;
    //Test Case 2 : Send pid IN with wrong address or endpoint number
    tb_test_num += 1;
    tb_test_case = "Pid IN with wrong address or endpoint number";
    reset_dut;
    tb_expected_rx_error = 1'b1;
    tb_expected_rx_transfer_active = 1'b0;;
    //tb_expected_nak = 1'b0;
    tb_expected_rx_data_ready = 1'b0;
    tb_expected_rx_data_packet = 4'b1001;
    tb_expected_rcv_data = 8'b00000000;
    tb_test_vectors.data = new[2];
    tb_test_vectors.pid = PID_IN;
    tb_test_vectors.data[0] = 8'b11001011;//ADDRESS: 7'b0000001, Endpoint number: 4'b0001, CRC number: 5'b00000
    tb_test_vectors.data[1] = 8'b01010000;
    @(negedge tb_clk);
    test_stream(tb_test_vectors);
    #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder
    check_outputs;
    #1;
    //Test Case 3 : Send pid DATA0 with 3 bytes valid data and valid eop
    tb_test_num += 1;
    tb_test_case = "Pid DATA0 with 3 bytes valid data and eop";
    reset_dut;
    tb_expected_rx_error = 1'b0;
    tb_expected_rx_transfer_active = 1'b0;;
    //tb_expected_nak = 1'b0;
    tb_expected_rx_data_ready = 1'b1;
    tb_expected_rx_data_packet = 4'b0011;
    tb_expected_rcv_data = 8'b00101100;
    tb_test_vectors.data = new[5];
    tb_test_vectors.pid = PID_DATA_0; // DATA0
    tb_test_vectors.data[0] = 8'b10101101;
    tb_test_vectors.data[1] = 8'b11010111;
    tb_test_vectors.data[2] = 8'b00101100;
    tb_test_vectors.data[3] = CRC_BITS0;// last 2 bytes are CRC
    tb_test_vectors.data[4] = CRC_BITS1;
    @(negedge tb_clk);
    test_stream(tb_test_vectors);
    #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder
    check_outputs;
    #1;
    //Test Case 4 : Send pid DATA0 with 25 bytes valid data and valid eop
    tb_test_num += 1;
    tb_test_case = "Pid DATA0 with 25 bytes valid data and eop";
    reset_dut;
    tb_expected_rx_error = 1'b0;
    tb_expected_rx_transfer_active = 1'b0;;
    //tb_expected_nak = 1'b0;
    tb_expected_rx_data_ready = 1'b1;
    tb_expected_rx_data_packet = 4'b0011;
    tb_expected_rcv_data = 8'b10111100;
    tb_test_vectors.data = new[27];
    tb_test_vectors.pid = PID_DATA_0; // DATA0
    for(j = 0; j < tb_test_vectors.data.size - 2; j++)
    begin
        tb_test_vectors.data[j] = 8'b10111100;
    end
    tb_test_vectors.data[25] = CRC_BITS0;// last 2 bytes are CRC
    tb_test_vectors.data[26] = CRC_BITS1;
    @(negedge tb_clk);
    test_stream(tb_test_vectors);
    #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder
    check_outputs;
    #1;
    //Test Case 5 : Send pid DATA0 with early eop
    tb_test_num += 1;
    tb_test_case = "Pid DATA0 with early eop";
    reset_dut;
    tb_expected_rx_error = 1'b1;
    tb_expected_rx_transfer_active = 1'b0;;
    //tb_expected_nak = 1'b0;
    tb_expected_rx_data_ready = 1'b1;
    tb_expected_rx_data_packet = 4'b0011;
    tb_expected_rcv_data = 8'b00001011;
    @(negedge tb_clk);
    send_byte(8'b10000000); //send sync byte
    send_byte(8'b11000011); //send pid
    send_byte(8'b00001011); // send a byte data
    send_bit(1'b1);
    send_byte(CRC_BITS0); // CRC
    send_byte(CRC_BITS1);
    send_eop; // send an eop during sending a byte
    #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder
    check_outputs;
    #1;
    //Test Case 6 : Send pid DATA0 with over 64 bytes data
    tb_test_num += 1;
    tb_test_case = "Pid DATA0 with over 64 bytes data";
    reset_dut;
    tb_expected_rx_error = 1'b1;
    tb_expected_rx_transfer_active = 1'b0;;
    //tb_expected_nak = 1'b1;
    tb_expected_rx_data_ready = 1'b1;
    tb_expected_rx_data_packet = 4'b0011;
    tb_expected_rcv_data = 8'b10111100;
    tb_test_vectors.data = new[67]; // 65 bytes + 2 bytes CRC
    for(j = 0; j < tb_test_vectors.data.size - 2; j++)
    begin
        tb_test_vectors.data[j] = 8'b10111100;
    end
    tb_test_vectors.pid = PID_DATA_0;
    tb_test_vectors.data[65] = CRC_BITS0;// last 2 bytes are CRC
    tb_test_vectors.data[66] = CRC_BITS1;
    @(negedge tb_clk);
    test_stream(tb_test_vectors);
    #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder
    check_outputs;
    #1;
    //Test Case 7 : Send pid DATA0 with less than 2 bytes valid data and valid eop
    tb_test_num += 1;
    tb_test_case = "Pid DATA0 with less than 2 bytes valid data and eop";
    reset_dut;
    tb_expected_rx_error = 1'b1;
    tb_expected_rx_transfer_active = 1'b0;
    //tb_expected_nak = 1'b0;
    tb_expected_rx_data_ready = 1'b0;
    tb_expected_rx_data_packet = 4'b0011;
    tb_expected_rcv_data = 8'b00000000;
    tb_test_vectors.data = new[1];
    tb_test_vectors.pid = PID_DATA_0; // DATA0
    tb_test_vectors.data[0] = 8'b10101101;
    @(negedge tb_clk);
    test_stream(tb_test_vectors);
    #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder
    check_outputs;
    #1;
    //Test Case 8 : Send pid ACK 
    tb_test_num += 1;
    tb_test_case = "Pid ACK";
    reset_dut;
    tb_expected_rx_error = 1'b0;
    tb_expected_rx_transfer_active = 1'b0;
    //tb_expected_nak = 1'b0;
    tb_expected_rx_data_ready = 1'b0;
    tb_expected_rx_data_packet = 4'b0010;
    tb_expected_rcv_data = 8'b00000000;
    tb_test_vectors.data = new[0];
    tb_test_vectors.pid = PID_ACK; // ACK
    @(negedge tb_clk);
    test_stream(tb_test_vectors);
    #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder
    check_outputs;
    #1;
    //Test Case 9 : Send pid NAK
    tb_test_num += 1;
    tb_test_case = "Pid NAK";
    reset_dut;
    tb_expected_rx_error = 1'b0;
    tb_expected_rx_transfer_active = 1'b0;
    //tb_expected_nak = 1'b0;
    tb_expected_rx_data_ready = 1'b0;
    tb_expected_rx_data_packet = 4'b1010;
    tb_expected_rcv_data = 8'b00000000;
    tb_test_vectors.data = new[0];
    tb_test_vectors.pid = PID_NAK; // NAK
    @(negedge tb_clk);
    test_stream(tb_test_vectors);
    #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder
    check_outputs;
    #1;
    //Test Case 10 : Send pid STALL
    tb_test_num += 1;
    tb_test_case = "Pid STALL";
    reset_dut;
    tb_expected_rx_error = 1'b0;
    tb_expected_rx_transfer_active = 1'b0;
    //tb_expected_nak = 1'b0;
    tb_expected_rx_data_ready = 1'b0;
    tb_expected_rx_data_packet = 4'b1110;
    tb_expected_rcv_data = 8'b00000000;
    tb_test_vectors.data = new[0];
    tb_test_vectors.pid = PID_STALL; // STALL
    @(negedge tb_clk);
    test_stream(tb_test_vectors);
    #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder
    check_outputs;
    #1;
    //Test Case 11 : Send invalid Pid
    tb_test_num += 1;
    tb_test_case = "Invalid Pid";
    reset_dut;
    tb_expected_rx_error = 1'b1;
    tb_expected_rx_transfer_active = 1'b0;
    //tb_expected_nak = 1'b0;
    tb_expected_rx_data_ready = 1'b0;
    tb_expected_rx_data_packet = 3'd0;
    tb_expected_rcv_data = 8'b00000000;
    tb_test_vectors.data = new[3];
    tb_test_vectors.pid = 8'b11000000; // Invalid pid
    tb_test_vectors.data[0] = 8'b00101100;
    tb_test_vectors.data[1] = 8'b00001101;// last 2 bytes are CRC
    tb_test_vectors.data[2] = 8'b10000000;
    @(negedge tb_clk);
    test_stream(tb_test_vectors);
    #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder
    check_outputs;
    #1;
    //Test Case 12 : Send invalid sync byte
    tb_test_num += 1;
    tb_test_case = "Invalid Sync Byte";
    reset_dut;
    tb_expected_rx_error = 1'b1;
    tb_expected_rx_transfer_active = 1'b0;
    //tb_expected_nak = 1'b0;
    tb_expected_rx_data_ready = 1'b0;
    tb_expected_rx_data_packet = 3'd0;
    tb_expected_rcv_data = 8'b00000000;
    @(negedge tb_clk);
    send_byte(8'b00100000); //send invalid sync byte
    send_byte(8'b11000011); //send pid data0
    send_byte(8'b00001011); // send a byte data
    send_byte(CRC_BITS0); // CRC
    send_byte(CRC_BITS1);
    send_eop; // send an eop during sending a byte
    #(DATA_PERIOD); // Data will delay a bit period because of the flipflop in the decoder
    check_outputs;
    #1;
    $stop();
end
endmodule