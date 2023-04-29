onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Case /tb_ahb_slave_cdl/tb_test_case
add wave -noupdate -expand -group Case /tb_ahb_slave_cdl/tb_test_case_num
add wave -noupdate -expand -group {Clk and N-rst} /tb_ahb_slave_cdl/tb_clk
add wave -noupdate -expand -group {Clk and N-rst} /tb_ahb_slave_cdl/tb_n_rst
add wave -noupdate -expand -group Check /tb_ahb_slave_cdl/tb_check_tag
add wave -noupdate -expand -group Check /tb_ahb_slave_cdl/tb_mismatch
add wave -noupdate -expand -group Check /tb_ahb_slave_cdl/tb_check
add wave -noupdate -expand -group {AHB Signal} /tb_ahb_slave_cdl/tb_hsel
add wave -noupdate -expand -group {AHB Signal} /tb_ahb_slave_cdl/tb_htrans
add wave -noupdate -expand -group {AHB Signal} /tb_ahb_slave_cdl/tb_haddr
add wave -noupdate -expand -group {AHB Signal} /tb_ahb_slave_cdl/tb_hsize
add wave -noupdate -expand -group {AHB Signal} /tb_ahb_slave_cdl/tb_hwrite
add wave -noupdate -expand -group {AHB Signal} /tb_ahb_slave_cdl/tb_hwdata
add wave -noupdate -expand -group {AHB Signal} /tb_ahb_slave_cdl/tb_hrdata
add wave -noupdate -expand -group {AHB Signal} /tb_ahb_slave_cdl/tb_hresp
add wave -noupdate -expand -group {AHB Signal} /tb_ahb_slave_cdl/tb_hready
add wave -noupdate -group {Bus Signal} /tb_ahb_slave_cdl/tb_enqueue_transaction
add wave -noupdate -group {Bus Signal} /tb_ahb_slave_cdl/tb_transaction_write
add wave -noupdate -group {Bus Signal} /tb_ahb_slave_cdl/tb_transaction_fake
add wave -noupdate -group {Bus Signal} /tb_ahb_slave_cdl/tb_transaction_addr
add wave -noupdate -group {Bus Signal} /tb_ahb_slave_cdl/tb_transaction_error
add wave -noupdate -group {Bus Signal} /tb_ahb_slave_cdl/tb_transaction_size
add wave -noupdate -group {Bus Signal} /tb_ahb_slave_cdl/tb_enable_transactions
add wave -noupdate -group {Bus Signal} /tb_ahb_slave_cdl/tb_model_reset
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {585953 ps} 0}
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
WaveRestoreZoom {0 ps} {1438500 ps}
