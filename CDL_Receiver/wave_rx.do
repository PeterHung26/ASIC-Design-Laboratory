onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {Clk & N_rst} /tb_rcv_block/tb_clk
add wave -noupdate -expand -group {Clk & N_rst} /tb_rcv_block/tb_n_rst
add wave -noupdate -expand -group Case /tb_rcv_block/tb_test_num
add wave -noupdate -expand -group Case /tb_rcv_block/tb_test_case
add wave -noupdate -expand -group Input /tb_rcv_block/tb_d_plus
add wave -noupdate -expand -group Input /tb_rcv_block/tb_d_minus
add wave -noupdate -expand -group Input -radix unsigned /tb_rcv_block/tb_buffer_occupancy
add wave -noupdate -expand -group {Test case input} /tb_rcv_block/tb_test_prev_d_plus
add wave -noupdate -expand -group {Test case input} -radix unsigned /tb_rcv_block/tb_test_count
add wave -noupdate -expand -group Output /tb_rcv_block/tb_rx_error
add wave -noupdate -expand -group Output /tb_rcv_block/tb_rx_transfer_active
add wave -noupdate -expand -group Output /tb_rcv_block/tb_flush
add wave -noupdate -expand -group Output /tb_rcv_block/tb_rx_data_ready
add wave -noupdate -expand -group Output -radix binary /tb_rcv_block/tb_rx_data_packet
add wave -noupdate -expand -group Output /tb_rcv_block/tb_w_enable
add wave -noupdate -expand -group Output /tb_rcv_block/tb_rcv_data
add wave -noupdate -expand -group {Expected Output} /tb_rcv_block/tb_expected_rx_error
add wave -noupdate -expand -group {Expected Output} /tb_rcv_block/tb_expected_rx_transfer_active
add wave -noupdate -expand -group {Expected Output} /tb_rcv_block/tb_expected_rx_data_ready
add wave -noupdate -expand -group {Expected Output} /tb_rcv_block/tb_expected_rx_data_packet
add wave -noupdate -expand -group {Expected Output} /tb_rcv_block/tb_expected_rcv_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2756369 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 247
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
WaveRestoreZoom {26779567 ps} {33017450 ps}
