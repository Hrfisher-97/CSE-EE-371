onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fifo_testbench/clk
add wave -noupdate /fifo_testbench/read_ready
add wave -noupdate /fifo_testbench/write_ready
add wave -noupdate /fifo_testbench/dut/wr_en
add wave -noupdate -radix decimal /fifo_testbench/in
add wave -noupdate -radix decimal /fifo_testbench/dut/fifo
add wave -noupdate -radix decimal /fifo_testbench/dut/w_addr_next
add wave -noupdate -radix decimal /fifo_testbench/dut/w_addr
add wave -noupdate -radix decimal /fifo_testbench/dut/r_addr_next
add wave -noupdate -radix decimal /fifo_testbench/dut/r_addr
add wave -noupdate /fifo_testbench/dut/empty_next
add wave -noupdate /fifo_testbench/dut/empty
add wave -noupdate /fifo_testbench/dut/full_next
add wave -noupdate /fifo_testbench/dut/full
add wave -noupdate /fifo_testbench/dut/rd_en
add wave -noupdate -radix decimal /fifo_testbench/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18 ps} 0}
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
WaveRestoreZoom {0 ps} {1 ns}
