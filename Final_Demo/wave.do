onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {Clk and N_rst} /tb_usb_top_level/tb_clk
add wave -noupdate -group {Clk and N_rst} /tb_usb_top_level/tb_n_rst
add wave -noupdate -expand -group Case /tb_usb_top_level/tb_test_case
add wave -noupdate -expand -group Case /tb_usb_top_level/tb_test_case_num
add wave -noupdate -expand -group {Rx Input} /tb_usb_top_level/tb_d_plus_in
add wave -noupdate -expand -group {Rx Input} /tb_usb_top_level/tb_d_minus_in
add wave -noupdate /tb_usb_top_level/tb_get_rx_data
add wave -noupdate -radix unsigned /tb_usb_top_level/tb_buffer_occupancy
add wave -noupdate /tb_usb_top_level/tb_tx_packet
add wave -noupdate /tb_usb_top_level/tb_tx_transfer_active
add wave -noupdate -expand -group {Rx testing Signal} /tb_usb_top_level/tb_test_prev_d_plus
add wave -noupdate -expand -group {Rx testing Signal} -radix unsigned /tb_usb_top_level/tb_test_rx_count
add wave -noupdate -expand -group Tx_output /tb_usb_top_level/tb_d_plus_out
add wave -noupdate -expand -group Tx_output /tb_usb_top_level/tb_d_minus_out
add wave -noupdate -expand -group {AHB Input} /tb_usb_top_level/tb_hsel
add wave -noupdate -expand -group {AHB Input} -radix hexadecimal /tb_usb_top_level/tb_haddr
add wave -noupdate -expand -group {AHB Input} /tb_usb_top_level/tb_htrans
add wave -noupdate -expand -group {AHB Input} /tb_usb_top_level/tb_hsize
add wave -noupdate -expand -group {AHB Input} /tb_usb_top_level/tb_hwrite
add wave -noupdate -expand -group {AHB Input} /tb_usb_top_level/tb_hwdata
add wave -noupdate -expand -group AHB_Output -radix hexadecimal /tb_usb_top_level/tb_hrdata
add wave -noupdate -expand -group AHB_Output /tb_usb_top_level/tb_hresp
add wave -noupdate -expand -group AHB_Output /tb_usb_top_level/tb_hready
add wave -noupdate -expand -group AHB_Output /tb_usb_top_level/tb_d_mode
add wave -noupdate -group Check /tb_usb_top_level/tb_check_tag
add wave -noupdate -group Check /tb_usb_top_level/tb_mismatch
add wave -noupdate -group Check /tb_usb_top_level/tb_check
add wave -noupdate -group {Expected Outputs} /tb_usb_top_level/tb_expected_d_mode
add wave -noupdate -group {Expected Outputs} /tb_usb_top_level/tb_expected_d_plus_out
add wave -noupdate -group {Expected Outputs} /tb_usb_top_level/tb_expected_d_minus_out
add wave -noupdate -group {Bus Model Signal} /tb_usb_top_level/tb_enqueue_transaction
add wave -noupdate -group {Bus Model Signal} /tb_usb_top_level/tb_transaction_write
add wave -noupdate -group {Bus Model Signal} /tb_usb_top_level/tb_transaction_fake
add wave -noupdate -group {Bus Model Signal} /tb_usb_top_level/tb_transaction_addr
add wave -noupdate -group {Bus Model Signal} /tb_usb_top_level/tb_transaction_error
add wave -noupdate -group {Bus Model Signal} /tb_usb_top_level/tb_transaction_size
add wave -noupdate -group {Bus Model Signal} /tb_usb_top_level/tb_enable_transactions
add wave -noupdate -group {Bus Model Signal} /tb_usb_top_level/tb_current_addr_transaction_num
add wave -noupdate -group {Bus Model Signal} /tb_usb_top_level/tb_current_addr_beat_num
add wave -noupdate -group {Bus Model Signal} /tb_usb_top_level/tb_current_addr_transaction_error
add wave -noupdate -group {Bus Model Signal} /tb_usb_top_level/tb_current_data_transaction_num
add wave -noupdate -group {Bus Model Signal} /tb_usb_top_level/tb_current_data_beat_num
add wave -noupdate -group {Bus Model Signal} /tb_usb_top_level/tb_current_data_transaction_error
add wave -noupdate -group {Bus Model Signal} /tb_usb_top_level/tb_model_reset
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {111653703 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 154
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
WaveRestoreZoom {99476371 ps} {124624277 ps}
