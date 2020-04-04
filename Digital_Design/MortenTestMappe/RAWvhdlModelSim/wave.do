onerror {resume}
quietly set dataset_list [list sim vsim]
if {[catch {datasetcheck $dataset_list}]} {abort}
quietly WaveActivateNextPane {} 0
add wave -noupdate sim:/clockdividermodule/TinyClock
add wave -noupdate -radix hexadecimal sim:/clockdividermodule/Cycle
add wave -noupdate -radix hexadecimal sim:/numpad/NumpadReg
add wave -noupdate -expand -group DataBus sim:/memory/DataBusMemInput
add wave -noupdate -expand -group DataBus sim:/memory/DataBusReg
add wave -noupdate -expand -group DataBus sim:/memory/DataBusMemOutput
add wave -noupdate -expand -group AddrBus sim:/memory/AddrBusMemInput
add wave -noupdate -expand -group AddrBus sim:/memory/AddrBusMemOutput
add wave -noupdate -expand -group AddrBus sim:/memory/AddrBusReg
add wave -noupdate -expand -group EnableRAM sim:/memory/EnRamInput
add wave -noupdate -expand -group EnableRAM sim:/memory/EnRamOutput
add wave -noupdate -expand -group Memory sim:/memory/REG
add wave -noupdate -expand -group Memory sim:/memory/RAM
add wave -noupdate -expand -group CU sim:/cu/IR
add wave -noupdate -expand -group CU sim:/cu/PC
add wave -noupdate -expand -group CU sim:/cu/OPCODE
add wave -noupdate -expand -group CU sim:/cu/ConBusALU
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 194
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
WaveRestoreZoom {0 ps} {2100 ms}
