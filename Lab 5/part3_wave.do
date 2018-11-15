onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /part3_testbench/dut/clk
add wave -noupdate /part3_testbench/dut/reset
add wave -noupdate /part3_testbench/dut/read_ready
add wave -noupdate /part3_testbench/dut/write_ready
add wave -noupdate -radix decimal /part3_testbench/dut/in
add wave -noupdate -radix decimal /part3_testbench/dut/fractioned_in
add wave -noupdate -radix decimal /part3_testbench/dut/fifoBuff/fifo
add wave -noupdate -radix decimal /part3_testbench/dut/fifo_out
add wave -noupdate -radix decimal /part3_testbench/dut/negative_fifo_out
add wave -noupdate -radix decimal /part3_testbench/dut/first_sum
add wave -noupdate -radix decimal /part3_testbench/dut/accumulator_q
add wave -noupdate -radix decimal /part3_testbench/dut/next_sum
add wave -noupdate -radix decimal /part3_testbench/dut/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {188 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {700 ps} {1700 ps}
