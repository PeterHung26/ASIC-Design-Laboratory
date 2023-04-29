A guide to the project files for the cooperative design lab in ECE33700.

Team members contributing to this project were:
	Wen-Bo Hung,
	Te-Yu Hsin,
	Hsuanling Lee

All files for this project can be found in
~mg173/ece337/Final_Demo
source/
Top Level:
usb_top_level.sv - top level RTL code for entire design
tb_usb_top_level.sv - testbench for top level RTL code

AHB Bus:
ahb_slave_cdl.sv - AHB Slave code for AHB-Lite
tb_slave_cdl.sv - AHB Slave testbench for testing the design of AHB-Lite 

Receiver:
rcv_block.sv - top level RTL code for usb receiver
rcu.sv - receiver unit for the usb receiver
timer.sv - timer used for strobe and counting byte
count_to_2.sv - counter used for counting 2 byte CRC or 2 byte address, endpoint number, and CRC
count_to_64.sv - counter used for counting maximum 64 bytes for buffer
decoder.sv - decoder that decodes the d_plus_in and d_minus_in to the original data
d_plus_sync_high.sv - synchronizer for d_plus_in
d_minus_sync_low.sv - synchronizer for d_minus_in
edge_detector.sv - edge detector detects the rising edge and falling edge of d_plus_in
eop_detect.sv - eop detector detects the eop
rx_data_ready.sv - it is responsible for output rx_data_ready
rx_packet.sv - it is responsible for output rx_packet
store_2_byte_buffer.sv - a buffer storing latest 3 bytes of decoded data
stp_sr_8_lsb.sv - a lsb-first, 8-byte, serial-to-parallel shift register
sync_high.sv - synchronizer module that will be high after resetting
sync_low.sv - synchronizer module that will be low after resetting
flex_counter_rx.sv - flex counter for rx timer
flex_stp_sr.sv - flex serial-to-parallel shift register
tb_rcv_block.sv - testbench for usb receiver

Transmitter:
usb_transmitter.sv - top level RTL code for usb transmitter
tmu.sv - transmit unit for the usb transmitter
timer_transmit.sv - timer for the usb transmitter
d_minus_selecter.sv - d_minus output for the usb transmitter
d_plus_selecter.sv - d_plus output for the usb transmitter
encoder.sv - encoder that encodes the original data to raw data sending to output selecter
flex_counter.sv - flex counter for the tx timer
flex_pts_sr.sv - shift register
pts_sr_8_lsb.sv - 8 bit least significant bit shift register
tb_usb_transmitter - testbench for usb transmitter

Buffer:
buffer.sv - top level RTL code for buffer
get_ptr_controller.sv - controller that controls the get pointer in buffer
store_ptr_controller.sv - controller that controls the store pointer in buffer
fifo_ram.sv - the fifo 64 bytes ram in the buffer
tb_buffer.sv - testbench for the buffer

reports/
usb_top_level.log - synthesis report file for top level
usb_top_level.rep - report file for top level
ahb_slave_cdl.log - synthesis report file for AHB
ahb_slave_cdl.rep - report file for AHB
buffer.log - synthesis report file for buffer
buffer.rep - report file for buffer
rcv_block.log - synthesis report file for receiver
rcv_block.rep - report file for receiver
usb_transmitter.log - synthesis report file transmitter
usb_transmitter.rep - report file transmitter

docs/
Test planning for Cooperative Design Lab.pdf - verification plan of top level, ahb, buffer, transmitter, and receiver
project-AHB-Lite-Slave Interface RTL.drawio.png - graph for AHB-lite slave
project-Top Diagram of Receiver.drawio.png - graph for usb receiver
project-USB Transmitter.drawio.png - graph for usb transmitter and buffer
