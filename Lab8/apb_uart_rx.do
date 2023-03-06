onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {APB Bus} /tb_apb_uart_rx/tb_enqueue_transaction
add wave -noupdate -expand -group {APB Bus} /tb_apb_uart_rx/tb_transaction_write
add wave -noupdate -expand -group {APB Bus} /tb_apb_uart_rx/tb_transaction_fake
add wave -noupdate -expand -group {APB Bus} /tb_apb_uart_rx/tb_transaction_addr
add wave -noupdate -expand -group {APB Bus} /tb_apb_uart_rx/tb_transaction_data
add wave -noupdate -expand -group {APB Bus} /tb_apb_uart_rx/tb_transaction_error
add wave -noupdate -expand -group {APB Bus} /tb_apb_uart_rx/tb_enable_transactions
add wave -noupdate -expand -group {APB Bus} /tb_apb_uart_rx/tb_current_transaction_num
add wave -noupdate -expand -group {APB Bus} /tb_apb_uart_rx/tb_model_reset
add wave -noupdate -expand -group {Clk and N_rst} /tb_apb_uart_rx/tb_clk
add wave -noupdate -expand -group {Clk and N_rst} /tb_apb_uart_rx/tb_n_rst
add wave -noupdate -expand -group {Test Case} /tb_apb_uart_rx/tb_test_case
add wave -noupdate -expand -group {Test Case} /tb_apb_uart_rx/tb_test_case_num
add wave -noupdate -expand -group {Test Case} /tb_apb_uart_rx/tb_test_num
add wave -noupdate -expand -group {Test Case} /tb_apb_uart_rx/tb_check_tag
add wave -noupdate -expand -group {Test Case} /tb_apb_uart_rx/tb_mismatch
add wave -noupdate -expand -group {Test Case} /tb_apb_uart_rx/tb_check
add wave -noupdate -expand -group {Test Signal} /tb_apb_uart_rx/tb_test_data
add wave -noupdate -expand -group {Test Signal} -radix unsigned /tb_apb_uart_rx/tb_test_bit_period
add wave -noupdate -expand -group {Test Signal} /tb_apb_uart_rx/tb_test_stop_bit
add wave -noupdate -expand -group {Test Signal} -radix unsigned /tb_apb_uart_rx/tb_test_bit_period_rcv
add wave -noupdate -expand -group {Test Signal} /tb_apb_uart_rx/tb_test_data_size
add wave -noupdate -expand -group {Control Signal of APB} /tb_apb_uart_rx/tb_psel
add wave -noupdate -expand -group {Control Signal of APB} /tb_apb_uart_rx/tb_penable
add wave -noupdate -expand -group {Control Signal of APB} /tb_apb_uart_rx/tb_paddr
add wave -noupdate -expand -group {Control Signal of APB} /tb_apb_uart_rx/tb_pwrite
add wave -noupdate -expand -group {Control Signal of APB} /tb_apb_uart_rx/tb_pslverr
add wave -noupdate -expand -group {Write and Read Data of APB} /tb_apb_uart_rx/tb_pwdata
add wave -noupdate -expand -group {Write and Read Data of APB} /tb_apb_uart_rx/tb_prdata
add wave -noupdate -expand -group {Input of UART} /tb_apb_uart_rx/tb_serial_in
add wave -noupdate -expand -group {Input of UART} /tb_apb_uart_rx/tb_data_read
add wave -noupdate -expand -group {Input of UART} -radix unsigned /tb_apb_uart_rx/tb_data_size
add wave -noupdate -expand -group {Input of UART} -radix unsigned /tb_apb_uart_rx/tb_bit_period
add wave -noupdate -expand -group {Output of UART} /tb_apb_uart_rx/tb_rx_data
add wave -noupdate -expand -group {Output of UART} /tb_apb_uart_rx/tb_data_ready
add wave -noupdate -expand -group {Output of UART} /tb_apb_uart_rx/tb_overrun_error
add wave -noupdate -expand -group {Output of UART} /tb_apb_uart_rx/tb_framing_error
add wave -noupdate -expand -group {Expected Signal} /tb_apb_uart_rx/tb_expected_data_read
add wave -noupdate -expand -group {Expected Signal} -radix unsigned /tb_apb_uart_rx/tb_expected_data_size
add wave -noupdate -expand -group {Expected Signal} -radix unsigned /tb_apb_uart_rx/tb_expected_bit_period
add wave -noupdate -expand -group {Expected Signal} /tb_apb_uart_rx/tb_expected_rx_data
add wave -noupdate -expand -group {Expected Signal} /tb_apb_uart_rx/tb_expected_framing_error
add wave -noupdate -expand -group {Expected Signal} /tb_apb_uart_rx/tb_expected_data_ready
add wave -noupdate -expand -group {Expected Signal} /tb_apb_uart_rx/tb_expected_overrun
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {52131 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 194
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
WaveRestoreZoom {0 ps} {446093 ps}
