onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /avgfilter_testbench/dut/clk
add wave -noupdate -radix decimal /avgfilter_testbench/dut/in
add wave -noupdate -radix decimal -childformat {{{/avgfilter_testbench/dut/in_divided[23]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[22]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[21]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[20]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[19]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[18]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[17]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[16]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[15]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[14]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[13]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[12]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[11]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[10]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[9]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[8]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[7]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[6]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[5]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[4]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[3]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[2]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[1]} -radix decimal} {{/avgfilter_testbench/dut/in_divided[0]} -radix decimal}} -subitemconfig {{/avgfilter_testbench/dut/in_divided[23]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[22]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[21]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[20]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[19]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[18]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[17]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[16]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[15]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[14]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[13]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[12]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[11]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[10]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[9]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[8]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[7]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[6]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[5]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[4]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[3]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[2]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[1]} {-radix decimal} {/avgfilter_testbench/dut/in_divided[0]} {-radix decimal}} /avgfilter_testbench/dut/in_divided
add wave -noupdate -radix decimal /avgfilter_testbench/dut/q0
add wave -noupdate -radix decimal -childformat {{{/avgfilter_testbench/dut/res0[23]} -radix decimal} {{/avgfilter_testbench/dut/res0[22]} -radix decimal} {{/avgfilter_testbench/dut/res0[21]} -radix decimal} {{/avgfilter_testbench/dut/res0[20]} -radix decimal} {{/avgfilter_testbench/dut/res0[19]} -radix decimal} {{/avgfilter_testbench/dut/res0[18]} -radix decimal} {{/avgfilter_testbench/dut/res0[17]} -radix decimal} {{/avgfilter_testbench/dut/res0[16]} -radix decimal} {{/avgfilter_testbench/dut/res0[15]} -radix decimal} {{/avgfilter_testbench/dut/res0[14]} -radix decimal} {{/avgfilter_testbench/dut/res0[13]} -radix decimal} {{/avgfilter_testbench/dut/res0[12]} -radix decimal} {{/avgfilter_testbench/dut/res0[11]} -radix decimal} {{/avgfilter_testbench/dut/res0[10]} -radix decimal} {{/avgfilter_testbench/dut/res0[9]} -radix decimal} {{/avgfilter_testbench/dut/res0[8]} -radix decimal} {{/avgfilter_testbench/dut/res0[7]} -radix decimal} {{/avgfilter_testbench/dut/res0[6]} -radix decimal} {{/avgfilter_testbench/dut/res0[5]} -radix decimal} {{/avgfilter_testbench/dut/res0[4]} -radix decimal} {{/avgfilter_testbench/dut/res0[3]} -radix decimal} {{/avgfilter_testbench/dut/res0[2]} -radix decimal} {{/avgfilter_testbench/dut/res0[1]} -radix decimal} {{/avgfilter_testbench/dut/res0[0]} -radix decimal}} -subitemconfig {{/avgfilter_testbench/dut/res0[23]} {-radix decimal} {/avgfilter_testbench/dut/res0[22]} {-radix decimal} {/avgfilter_testbench/dut/res0[21]} {-radix decimal} {/avgfilter_testbench/dut/res0[20]} {-radix decimal} {/avgfilter_testbench/dut/res0[19]} {-radix decimal} {/avgfilter_testbench/dut/res0[18]} {-radix decimal} {/avgfilter_testbench/dut/res0[17]} {-radix decimal} {/avgfilter_testbench/dut/res0[16]} {-radix decimal} {/avgfilter_testbench/dut/res0[15]} {-radix decimal} {/avgfilter_testbench/dut/res0[14]} {-radix decimal} {/avgfilter_testbench/dut/res0[13]} {-radix decimal} {/avgfilter_testbench/dut/res0[12]} {-radix decimal} {/avgfilter_testbench/dut/res0[11]} {-radix decimal} {/avgfilter_testbench/dut/res0[10]} {-radix decimal} {/avgfilter_testbench/dut/res0[9]} {-radix decimal} {/avgfilter_testbench/dut/res0[8]} {-radix decimal} {/avgfilter_testbench/dut/res0[7]} {-radix decimal} {/avgfilter_testbench/dut/res0[6]} {-radix decimal} {/avgfilter_testbench/dut/res0[5]} {-radix decimal} {/avgfilter_testbench/dut/res0[4]} {-radix decimal} {/avgfilter_testbench/dut/res0[3]} {-radix decimal} {/avgfilter_testbench/dut/res0[2]} {-radix decimal} {/avgfilter_testbench/dut/res0[1]} {-radix decimal} {/avgfilter_testbench/dut/res0[0]} {-radix decimal}} /avgfilter_testbench/dut/res0
add wave -noupdate -radix decimal /avgfilter_testbench/dut/q1
add wave -noupdate -radix decimal /avgfilter_testbench/dut/res1
add wave -noupdate -radix decimal /avgfilter_testbench/dut/q2
add wave -noupdate -radix decimal /avgfilter_testbench/dut/res2
add wave -noupdate -radix decimal /avgfilter_testbench/dut/q3
add wave -noupdate -radix decimal /avgfilter_testbench/dut/res3
add wave -noupdate -radix decimal /avgfilter_testbench/dut/q4
add wave -noupdate -radix decimal /avgfilter_testbench/dut/res4
add wave -noupdate -radix decimal /avgfilter_testbench/dut/q5
add wave -noupdate -radix decimal /avgfilter_testbench/dut/res5
add wave -noupdate -radix decimal /avgfilter_testbench/dut/q6
add wave -noupdate -radix decimal /avgfilter_testbench/dut/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1378 ps} 0}
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
