onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_ahb_slave_cdl/tb_test_case_num
add wave -noupdate /tb_ahb_slave_cdl/tb_test_case
add wave -noupdate /tb_ahb_slave_cdl/tb_clk
add wave -noupdate /tb_ahb_slave_cdl/tb_n_rst
add wave -noupdate /tb_ahb_slave_cdl/rx_packet
add wave -noupdate /tb_ahb_slave_cdl/rx_data_ready
add wave -noupdate /tb_ahb_slave_cdl/rx_transfer_active
add wave -noupdate /tb_ahb_slave_cdl/rx_error
add wave -noupdate /tb_ahb_slave_cdl/buffer_occupancy
add wave -noupdate /tb_ahb_slave_cdl/rx_data
add wave -noupdate /tb_ahb_slave_cdl/get_rx_data
add wave -noupdate /tb_ahb_slave_cdl/store_tx_data
add wave -noupdate /tb_ahb_slave_cdl/tx_data
add wave -noupdate /tb_ahb_slave_cdl/clear
add wave -noupdate /tb_ahb_slave_cdl/tx_packet
add wave -noupdate /tb_ahb_slave_cdl/tx_transfer_active
add wave -noupdate /tb_ahb_slave_cdl/tx_error
add wave -noupdate /tb_ahb_slave_cdl/d_mode
add wave -noupdate /tb_ahb_slave_cdl/expected_get_rx_data
add wave -noupdate /tb_ahb_slave_cdl/expected_store_tx_data
add wave -noupdate /tb_ahb_slave_cdl/expected_tx_data
add wave -noupdate /tb_ahb_slave_cdl/expected_clear
add wave -noupdate /tb_ahb_slave_cdl/expected_tx_packet
add wave -noupdate /tb_ahb_slave_cdl/expected_d_mode
add wave -noupdate /tb_ahb_slave_cdl/tb_test_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {45000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 222
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
configure wave -timelineunits ps
update
WaveRestoreZoom {37409 ps} {174481 ps}
