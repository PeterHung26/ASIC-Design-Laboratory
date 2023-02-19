onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {CLK and N_RST} /tb_rcu/tb_clk
add wave -noupdate -expand -group {CLK and N_RST} /tb_rcu/tb_n_rst
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand -group Case /tb_rcu/tb_test_num
add wave -noupdate -expand -group Case /tb_rcu/tb_test_case
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand -group Checking /tb_rcu/tb_mismatch
add wave -noupdate -expand -group Checking /tb_rcu/tb_check
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand -group Input /tb_rcu/tb_new_packet_detected
add wave -noupdate -expand -group Input /tb_rcu/tb_packet_done
add wave -noupdate -expand -group Input /tb_rcu/tb_framing_error
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand -group Output /tb_rcu/tb_expected_ouput
add wave -noupdate -expand -group Output /tb_rcu/tb_sbc_clear
add wave -noupdate -expand -group Output /tb_rcu/tb_sbc_enable
add wave -noupdate -expand -group Output /tb_rcu/tb_load_buffer
add wave -noupdate -expand -group Output /tb_rcu/tb_enable_timer
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {44351 ps} 0}
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
WaveRestoreZoom {0 ps} {129306 ps}
