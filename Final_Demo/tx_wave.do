onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_usb_transmitter/tb_test_case
add wave -noupdate /tb_usb_transmitter/tb_test_case_num
add wave -noupdate /tb_usb_transmitter/tb_check
add wave -noupdate /tb_usb_transmitter/tb_check_tag
add wave -noupdate /tb_usb_transmitter/tb_clk
add wave -noupdate /tb_usb_transmitter/tb_n_rst
add wave -noupdate -radix unsigned /tb_usb_transmitter/tb_buffer_occupancy
add wave -noupdate /tb_usb_transmitter/tb_tx_packet
add wave -noupdate -radix unsigned /tb_usb_transmitter/tb_tx_packet_data
add wave -noupdate -divider {Output Divider}
add wave -noupdate -expand -group Output /tb_usb_transmitter/tb_d_plus_out
add wave -noupdate -expand -group Output /tb_usb_transmitter/tb_d_minus_out
add wave -noupdate -expand -group Output /tb_usb_transmitter/tb_tx_transfer_active
add wave -noupdate -expand -group Output /tb_usb_transmitter/tb_tx_error
add wave -noupdate -expand -group Output /tb_usb_transmitter/tb_get_tx_packet_data
add wave -noupdate -divider {Output Divider}
add wave -noupdate -color Yellow /tb_usb_transmitter/expected_d_plus_out
add wave -noupdate -color Yellow /tb_usb_transmitter/expected_d_minus_out
add wave -noupdate -color Yellow /tb_usb_transmitter/expected_tx_transfer_active
add wave -noupdate -color Yellow /tb_usb_transmitter/expected_tx_error
add wave -noupdate -divider encoder
add wave -noupdate -color {Medium Sea Green} /tb_usb_transmitter/DUT/encoder/d_encoded
add wave -noupdate -color {Medium Sea Green} /tb_usb_transmitter/DUT/encoder/d_orig
add wave -noupdate -divider rcu
add wave -noupdate /tb_usb_transmitter/DUT/rcu/state
add wave -noupdate /tb_usb_transmitter/DUT/rcu/eop
add wave -noupdate -divider timer
add wave -noupdate /tb_usb_transmitter/DUT/timer/strobe
add wave -noupdate /tb_usb_transmitter/DUT/pts_sr_8_lsb/strobe_middle
add wave -noupdate /tb_usb_transmitter/DUT/timer/byte_transmitted
add wave -noupdate -divider packet_selecter
add wave -noupdate /tb_usb_transmitter/DUT/packet_selecter/sync_start
add wave -noupdate /tb_usb_transmitter/DUT/packet_selecter/pid_start
add wave -noupdate /tb_usb_transmitter/DUT/pts_sr_8_lsb/pts_shift_enable
add wave -noupdate /tb_usb_transmitter/DUT/pts_sr_8_lsb/pts_load_enable
add wave -noupdate /tb_usb_transmitter/DUT/pts_sr_8_lsb/d_par
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1675000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 206
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {5199841 ps}
