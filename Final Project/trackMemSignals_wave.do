onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /trackMemSignals_testbench/clk
add wave -noupdate /trackMemSignals_testbench/reset
add wave -noupdate /trackMemSignals_testbench/signalIn
add wave -noupdate -expand -group Cutter /trackMemSignals_testbench/dut/cutter/in
add wave -noupdate -expand -group Cutter /trackMemSignals_testbench/dut/cutter/temp
add wave -noupdate -expand -group Cutter /trackMemSignals_testbench/dut/cutter/out
add wave -noupdate /trackMemSignals_testbench/dut/signal
add wave -noupdate /trackMemSignals_testbench/write
add wave -noupdate /trackMemSignals_testbench/read
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {822 ps} 0}
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
WaveRestoreZoom {100 ps} {1100 ps}
