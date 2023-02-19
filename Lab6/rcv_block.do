onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Control /tb_rcv_block/tb_clk
add wave -noupdate -expand -group Control /tb_rcv_block/tb_n_rst
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand -group Case /tb_rcv_block/tb_test_num
add wave -noupdate -expand -group Case /tb_rcv_block/tb_test_case
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand -group Data /tb_rcv_block/tb_serial_in
add wave -noupdate -expand -group Data /tb_rcv_block/tb_rx_data
add wave -noupdate -expand -group Data /tb_rcv_block/tb_test_data
add wave -noupdate -expand -group Data /tb_rcv_block/tb_test_stop_bit
add wave -noupdate -expand -group Data /tb_rcv_block/tb_test_bit_period
add wave -noupdate -expand -group Data /tb_rcv_block/tb_test_data_read
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand -group Flag /tb_rcv_block/tb_data_read
add wave -noupdate -expand -group Flag /tb_rcv_block/tb_data_ready
add wave -noupdate -expand -group Flag /tb_rcv_block/tb_overrun_error
add wave -noupdate -expand -group Flag /tb_rcv_block/tb_framing_error
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand -group {Expected Output} /tb_rcv_block/tb_expected_rx_data
add wave -noupdate -expand -group {Expected Output} /tb_rcv_block/tb_expected_framing_error
add wave -noupdate -expand -group {Expected Output} /tb_rcv_block/tb_expected_data_ready
add wave -noupdate -expand -group {Expected Output} /tb_rcv_block/tb_expected_overrun
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 168
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
WaveRestoreZoom {0 ps} {985 ps}
