onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /audioLooper_testbench/clk
add wave -noupdate /audioLooper_testbench/dut/rwClock
add wave -noupdate /audioLooper_testbench/reset
add wave -noupdate /audioLooper_testbench/write
add wave -noupdate /audioLooper_testbench/read
add wave -noupdate /audioLooper_testbench/reverse
add wave -noupdate /audioLooper_testbench/dut/loopExists
add wave -noupdate -radix decimal /audioLooper_testbench/dut/nextLoopAddr
add wave -noupdate -radix decimal /audioLooper_testbench/dut/loopAddr
add wave -noupdate -radix decimal /audioLooper_testbench/dut/nextLoopMax
add wave -noupdate -radix decimal /audioLooper_testbench/dut/loopMax
add wave -noupdate -radix decimal /audioLooper_testbench/dut/in
add wave -noupdate -radix decimal /audioLooper_testbench/dut/loopMem
add wave -noupdate -radix decimal /audioLooper_testbench/dut/memOut
add wave -noupdate -radix decimal /audioLooper_testbench/dut/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {165 ps} 0}
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
configure wave -gridperiod 100
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
