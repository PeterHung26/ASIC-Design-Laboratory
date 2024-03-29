onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_apb_slave/tb_enqueue_transaction
add wave -noupdate /tb_apb_slave/tb_transaction_write
add wave -noupdate /tb_apb_slave/tb_transaction_fake
add wave -noupdate /tb_apb_slave/tb_transaction_addr
add wave -noupdate /tb_apb_slave/tb_transaction_data
add wave -noupdate /tb_apb_slave/tb_transaction_error
add wave -noupdate /tb_apb_slave/tb_enable_transactions
add wave -noupdate /tb_apb_slave/tb_current_transaction_num
add wave -noupdate /tb_apb_slave/tb_model_reset
add wave -noupdate /tb_apb_slave/tb_test_case
add wave -noupdate /tb_apb_slave/tb_test_case_num
add wave -noupdate /tb_apb_slave/tb_test_data
add wave -noupdate /tb_apb_slave/tb_check_tag
add wave -noupdate -radix unsigned /tb_apb_slave/tb_test_bit_period
add wave -noupdate /tb_apb_slave/tb_mismatch
add wave -noupdate /tb_apb_slave/tb_check
add wave -noupdate -expand -group {Clk and Reset} /tb_apb_slave/tb_clk
add wave -noupdate -expand -group {Clk and Reset} /tb_apb_slave/tb_n_rst
add wave -noupdate -expand -group {APB Control Signal} /tb_apb_slave/tb_psel
add wave -noupdate -expand -group {APB Control Signal} /tb_apb_slave/tb_paddr
add wave -noupdate -expand -group {APB Control Signal} /tb_apb_slave/tb_penable
add wave -noupdate -expand -group {APB Control Signal} /tb_apb_slave/tb_pwrite
add wave -noupdate -expand -group {APB Write and Read Data} /tb_apb_slave/tb_pwdata
add wave -noupdate -expand -group {APB Write and Read Data} /tb_apb_slave/tb_prdata
add wave -noupdate -expand -group {APB Output Signal} /tb_apb_slave/tb_pslverr
add wave -noupdate -expand -group {APB Output Signal} /tb_apb_slave/tb_data_read
add wave -noupdate -expand -group {Read Only} /tb_apb_slave/tb_rx_data
add wave -noupdate -expand -group {Read Only} /tb_apb_slave/tb_data_ready
add wave -noupdate -expand -group {Read Only} /tb_apb_slave/tb_overrun_error
add wave -noupdate -expand -group {Read Only} /tb_apb_slave/tb_framing_error
add wave -noupdate -expand -group {Read and Write} /tb_apb_slave/tb_data_size
add wave -noupdate /tb_apb_slave/tb_bit_period
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand -group {Expected Output} /tb_apb_slave/tb_expected_data_read
add wave -noupdate -expand -group {Expected Output} /tb_apb_slave/tb_expected_data_size
add wave -noupdate -expand -group {Expected Output} /tb_apb_slave/tb_expected_bit_period
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {213090 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 228
configure wave -valuecolwidth 290
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
WaveRestoreZoom {0 ps} {1291859 ps}
