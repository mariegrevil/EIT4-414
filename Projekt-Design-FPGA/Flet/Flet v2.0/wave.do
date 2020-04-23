onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/TinyClock
add wave -noupdate /testbench/Binary
add wave -noupdate /testbench/Result
add wave -noupdate /testbench/DecimalOutput
add wave -noupdate /testbench/ActionJackson
add wave -noupdate /testbench/InputValueOne
add wave -noupdate /testbench/InputValueTwo
add wave -noupdate /testbench/DisplayOutput
add wave -noupdate /testbench/i_CU/PC
add wave -noupdate /testbench/i_CU/OPCODE
add wave -noupdate /testbench/i_Display/DisplayRAM
add wave -noupdate /testbench/i_Numpad/TestButton
add wave -noupdate /testbench/i_Numpad/ButtonEnable
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
configure wave -gridperiod 100000000
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ms
update
WaveRestoreZoom {0 ps} {1 ns}
