onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /getNewClock_testbench/reset
add wave -noupdate -radix decimal /getNewClock_testbench/frequency
add wave -noupdate /getNewClock_testbench/CLOCK50
add wave -noupdate -radix decimal /getNewClock_testbench/dut/counter
add wave -noupdate /getNewClock_testbench/dut/halfPeriod
add wave -noupdate /getNewClock_testbench/newClock
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
