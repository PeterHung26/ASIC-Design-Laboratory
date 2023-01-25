onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -itemcolor Gold -radix unsigned -subitemconfig {{/tb_adder_16bit/tb_test_case_num[31]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[30]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[29]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[28]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[27]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[26]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[25]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[24]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[23]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[22]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[21]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[20]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[19]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[18]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[17]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[16]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[15]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[14]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[13]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[12]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[11]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[10]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[9]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[8]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[7]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[6]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[5]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[4]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[3]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[2]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[1]} {-itemcolor Gold} {/tb_adder_16bit/tb_test_case_num[0]} {-itemcolor Gold}} /tb_adder_16bit/tb_test_case_num
add wave -noupdate -itemcolor Gold /tb_adder_16bit/tb_test_case
add wave -noupdate -itemcolor Gold /tb_adder_16bit/tb_test_case_stage
add wave -noupdate -itemcolor Gold /tb_adder_16bit/tb_test_case_err
add wave -noupdate -divider {DUT Signal}
add wave -noupdate -radix hexadecimal /tb_adder_16bit/tb_a
add wave -noupdate -radix hexadecimal /tb_adder_16bit/tb_b
add wave -noupdate -radix unsigned /tb_adder_16bit/tb_carry_in
add wave -noupdate -expand -group Sum -radix unsigned /tb_adder_16bit/tb_sum
add wave -noupdate -expand -group Sum -radix unsigned /tb_adder_16bit/tb_expected_sum
add wave -noupdate -expand -group Overflow -radix unsigned /tb_adder_16bit/tb_overflow
add wave -noupdate -expand -group Overflow -radix unsigned /tb_adder_16bit/tb_expected_overflow
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15684 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 174
configure wave -valuecolwidth 105
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
WaveRestoreZoom {0 ps} {108096 ps}
