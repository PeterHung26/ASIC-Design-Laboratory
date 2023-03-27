onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {AHB Bus Control Signal} /tb_ahb_lite_fir_filter/tb_enqueue_transaction
add wave -noupdate -group {AHB Bus Control Signal} /tb_ahb_lite_fir_filter/tb_transaction_write
add wave -noupdate -group {AHB Bus Control Signal} /tb_ahb_lite_fir_filter/tb_transaction_fake
add wave -noupdate -group {AHB Bus Control Signal} /tb_ahb_lite_fir_filter/tb_transaction_addr
add wave -noupdate -group {AHB Bus Control Signal} /tb_ahb_lite_fir_filter/tb_transaction_data
add wave -noupdate -group {AHB Bus Control Signal} /tb_ahb_lite_fir_filter/tb_transaction_error
add wave -noupdate -group {AHB Bus Control Signal} /tb_ahb_lite_fir_filter/tb_transaction_size
add wave -noupdate -group {AHB Bus Control Signal} /tb_ahb_lite_fir_filter/tb_enable_transactions
add wave -noupdate -group {AHB Bus Control Signal} /tb_ahb_lite_fir_filter/tb_current_transaction_num
add wave -noupdate -group {AHB Bus Control Signal} /tb_ahb_lite_fir_filter/tb_current_transaction_error
add wave -noupdate -group {AHB Bus Control Signal} /tb_ahb_lite_fir_filter/tb_model_reset
add wave -noupdate -expand -group {Clk and Reset} /tb_ahb_lite_fir_filter/tb_clk
add wave -noupdate -expand -group {Clk and Reset} /tb_ahb_lite_fir_filter/tb_n_rst
add wave -noupdate -expand -group {AHB Signal} /tb_ahb_lite_fir_filter/tb_hsel
add wave -noupdate -expand -group {AHB Signal} /tb_ahb_lite_fir_filter/tb_htrans
add wave -noupdate -expand -group {AHB Signal} /tb_ahb_lite_fir_filter/tb_haddr
add wave -noupdate -expand -group {AHB Signal} /tb_ahb_lite_fir_filter/tb_hsize
add wave -noupdate -expand -group {AHB Signal} /tb_ahb_lite_fir_filter/tb_hwrite
add wave -noupdate -expand -group {AHB Signal} -radix unsigned /tb_ahb_lite_fir_filter/tb_hwdata
add wave -noupdate -expand -group {AHB Signal} -radix unsigned /tb_ahb_lite_fir_filter/tb_hrdata
add wave -noupdate -expand -group {AHB Signal} /tb_ahb_lite_fir_filter/tb_hresp
add wave -noupdate -expand -group {Expected Output} -radix unsigned /tb_ahb_lite_fir_filter/tb_expected_fir_out
add wave -noupdate -expand -group {Expected Output} /tb_ahb_lite_fir_filter/tb_expected_err
add wave -noupdate -expand -group Case /tb_ahb_lite_fir_filter/tb_test_case
add wave -noupdate -expand -group Case /tb_ahb_lite_fir_filter/tb_test_case_num
add wave -noupdate -expand -group Case /tb_ahb_lite_fir_filter/tb_std_test_case
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {632222 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 217
configure wave -valuecolwidth 192
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
WaveRestoreZoom {0 ps} {1192956 ps}
