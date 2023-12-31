onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mux256_64_testbench/inThree
add wave -noupdate -radix hexadecimal /mux256_64_testbench/inTwo
add wave -noupdate -radix hexadecimal /mux256_64_testbench/inOne
add wave -noupdate -radix hexadecimal /mux256_64_testbench/inZero
add wave -noupdate -radix hexadecimal /mux256_64_testbench/out
add wave -noupdate -radix hexadecimal /mux256_64_testbench/sel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2477 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 232
configure wave -valuecolwidth 116
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {9149 ps}
