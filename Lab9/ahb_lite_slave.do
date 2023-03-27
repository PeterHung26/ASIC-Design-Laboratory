onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {Bus Signal} /tb_ahb_lite_slave/tb_enqueue_transaction
add wave -noupdate -group {Bus Signal} /tb_ahb_lite_slave/tb_transaction_write
add wave -noupdate -group {Bus Signal} /tb_ahb_lite_slave/tb_transaction_fake
add wave -noupdate -group {Bus Signal} /tb_ahb_lite_slave/tb_transaction_addr
add wave -noupdate -group {Bus Signal} /tb_ahb_lite_slave/tb_transaction_data
add wave -noupdate -group {Bus Signal} /tb_ahb_lite_slave/tb_transaction_error
add wave -noupdate -group {Bus Signal} /tb_ahb_lite_slave/tb_transaction_size
add wave -noupdate -group {Bus Signal} /tb_ahb_lite_slave/tb_enable_transactions
add wave -noupdate -group {Bus Signal} /tb_ahb_lite_slave/tb_current_transaction_num
add wave -noupdate -group {Bus Signal} /tb_ahb_lite_slave/tb_current_transaction_error
add wave -noupdate -group {Bus Signal} /tb_ahb_lite_slave/tb_model_reset
add wave -noupdate -expand -group {Clk and Reset} /tb_ahb_lite_slave/tb_clk
add wave -noupdate -expand -group {Clk and Reset} /tb_ahb_lite_slave/tb_n_rst
add wave -noupdate -expand -group Case /tb_ahb_lite_slave/tb_test_case
add wave -noupdate -expand -group Case /tb_ahb_lite_slave/tb_test_case_num
add wave -noupdate -expand -group Case /tb_ahb_lite_slave/tb_test_data
add wave -noupdate -expand -group Check /tb_ahb_lite_slave/tb_check_tag
add wave -noupdate -expand -group Check /tb_ahb_lite_slave/tb_mismatch
add wave -noupdate -expand -group Check /tb_ahb_lite_slave/tb_check
add wave -noupdate -expand -group {AHB lite signal} /tb_ahb_lite_slave/tb_hsel
add wave -noupdate -expand -group {AHB lite signal} /tb_ahb_lite_slave/tb_htrans
add wave -noupdate -expand -group {AHB lite signal} -radix hexadecimal /tb_ahb_lite_slave/tb_haddr
add wave -noupdate -expand -group {AHB lite signal} -radix decimal /tb_ahb_lite_slave/tb_hsize
add wave -noupdate -expand -group {AHB lite signal} /tb_ahb_lite_slave/tb_hwrite
add wave -noupdate -expand -group {AHB lite signal} /tb_ahb_lite_slave/tb_hwdata
add wave -noupdate -expand -group {AHB lite signal} /tb_ahb_lite_slave/tb_hrdata
add wave -noupdate -expand -group {AHB lite signal} /tb_ahb_lite_slave/tb_hresp
add wave -noupdate -expand -group {Coefficient Loader Input} /tb_ahb_lite_slave/tb_clear_new_coeff
add wave -noupdate -expand -group {Coefficient Loader Input} /tb_ahb_lite_slave/tb_coeff_num
add wave -noupdate -expand -group {FIR Filter Input} /tb_ahb_lite_slave/tb_fir_out
add wave -noupdate -expand -group {FIR Filter Input} /tb_ahb_lite_slave/tb_modwait
add wave -noupdate -expand -group {FIR Filter Input} /tb_ahb_lite_slave/tb_err
add wave -noupdate -expand -group Output /tb_ahb_lite_slave/tb_data_ready
add wave -noupdate -expand -group Output /tb_ahb_lite_slave/tb_sample_data
add wave -noupdate -expand -group Output /tb_ahb_lite_slave/tb_new_coeff_set
add wave -noupdate -expand -group Output /tb_ahb_lite_slave/tb_fir_coefficient
add wave -noupdate -expand -group {Expected Output} /tb_ahb_lite_slave/tb_expected_data_ready
add wave -noupdate -expand -group {Expected Output} /tb_ahb_lite_slave/tb_expected_sample
add wave -noupdate -expand -group {Expected Output} /tb_ahb_lite_slave/tb_expected_new_coeff_set
add wave -noupdate -expand -group {Expected Output} /tb_ahb_lite_slave/tb_expected_coeff
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {373375 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 235
configure wave -valuecolwidth 206
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
WaveRestoreZoom {0 ps} {705869 ps}
