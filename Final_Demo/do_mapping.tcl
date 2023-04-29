# Step 1:  Read in the source file
analyze -format sverilog -lib WORK {sync_high.sv sync_low.sv eop_detect.sv decoder.sv edge_detector.sv timer.sv rcu.sv stp_sr_8_lsb.sv flex_stp_sr.sv rx_data_ready.sv rx_packet.sv store_2_byte_buffer.sv count_to_2.sv count_to_64.sv d_minus_selecter.sv d_plus_selecter.sv encoder.sv flex_counter.sv flex_pts_sr.sv packet_selecter.sv tmu.sv pts_sr_8_lsb.sv timer_transmit.sv get_ptr_controller.sv store_ptr_controller.sv fifo_ram.sv buffer.sv ahb_slave.sv rcv_block.sv usb_transmitter.sv flex_counter_rx.sv usb_top_level.sv}
elaborate usb_top_level -lib WORK
uniquify
# Step 2: Set design constraints
# Uncomment below to set timing, area, power, etc. constraints
# set_max_delay <delay> -from "<input>" -to "<output>"
# set_max_area <area>
# set_max_total_power <power> mW


# Step 3: Compile the design
compile -map_effort medium

# Step 4: Output reports
report_timing -path full -delay max -max_paths 1 -nworst 1 > reports/usb_top_level.rep
report_area >> reports/usb_top_level.rep
report_power -hier >> reports/usb_top_level.rep

# Step 5: Output final VHDL and Verilog files
write_file -format verilog -hierarchy -output "mapped/usb_top_level.v"
echo "\nScript Done\n"
echo "\nChecking Design\n"
check_design
quit
