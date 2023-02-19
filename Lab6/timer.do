onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group Control /tb_timer/tb_clk
add wave -noupdate -expand -group Control /tb_timer/tb_n_rst
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand -group Case /tb_timer/tb_test_num
add wave -noupdate -expand -group Case /tb_timer/tb_test_case
add wave -noupdate -expand -group Case /tb_timer/tb_stream_check_tag
add wave -noupdate -expand -group Case /tb_timer/tb_bit_num
add wave -noupdate -expand -group Case /tb_timer/tb_cycle_num
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand -group Input /tb_timer/tb_enable_timer
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand -group Checking /tb_timer/tb_mismatch
add wave -noupdate -expand -group Checking /tb_timer/tb_check
add wave -noupdate -divider {New Divider}
add wave -noupdate -expand -group Output /tb_timer/tb_expected_ouput
add wave -noupdate -expand -group Output /tb_timer/tb_shift_strobe
add wave -noupdate -expand -group Output /tb_timer/tb_packet_done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {59135 ps} 0}
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
WaveRestoreZoom {0 ps} {127744 ps}
