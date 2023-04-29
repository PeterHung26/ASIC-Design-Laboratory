onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_buffer/tb_test_case
add wave -noupdate /tb_buffer/tb_test_case_num
add wave -noupdate /tb_buffer/tb_check
add wave -noupdate /tb_buffer/tb_model_reset
add wave -noupdate /tb_buffer/index
add wave -noupdate /tb_buffer/tb_clk
add wave -noupdate /tb_buffer/tb_n_rst
add wave -noupdate -radix unsigned /tb_buffer/tb_buffer_occupancy
add wave -noupdate /tb_buffer/tb_store_tx_data
add wave -noupdate /tb_buffer/tb_store_rx_packet_data
add wave -noupdate /tb_buffer/tb_get_rx_data
add wave -noupdate /tb_buffer/tb_get_tx_packet_data
add wave -noupdate -radix unsigned /tb_buffer/tb_tx_data
add wave -noupdate -radix unsigned /tb_buffer/tb_rx_packet_data
add wave -noupdate /tb_buffer/tb_clear
add wave -noupdate /tb_buffer/tb_flush
add wave -noupdate -divider Divider
add wave -noupdate -expand -group output -radix unsigned /tb_buffer/tb_rx_data
add wave -noupdate -expand -group output -radix unsigned /tb_buffer/tb_tx_packet_data
add wave -noupdate -divider Divider
add wave -noupdate -radix unsigned /tb_buffer/expected_buffer_occupancy
add wave -noupdate -radix unsigned /tb_buffer/expected_data
add wave -noupdate -radix unsigned /tb_buffer/DUT/fifo_ram/store_ptr
add wave -noupdate -radix unsigned /tb_buffer/DUT/fifo_ram/get_ptr
add wave -noupdate /tb_buffer/DUT/store_ptr_controller/clr
add wave -noupdate /tb_buffer/tb_clear
add wave -noupdate /tb_buffer/tb_flush
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2670856 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {2632906 ps} {2762579 ps}
