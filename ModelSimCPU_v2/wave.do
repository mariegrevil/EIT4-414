onerror {resume}
quietly set dataset_list [list sim vsim]
if {[catch {datasetcheck $dataset_list}]} {abort}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal sim:/minicputb/DataBusProgram
add wave -noupdate -radix hexadecimal sim:/minicputb/AddrBusProgram
add wave -noupdate -group AddrBus -radix hexadecimal sim:/minicputb/AddrBusReg
add wave -noupdate -group AddrBus -radix hexadecimal sim:/minicputb/AddrBusMemInput
add wave -noupdate -group AddrBus -radix hexadecimal sim:/minicputb/AddrBusMemOutput
add wave -noupdate -group EnableRAM -radix hexadecimal sim:/minicputb/EnRamInput
add wave -noupdate -group EnableRAM -radix hexadecimal sim:/minicputb/EnRamOutput
add wave -noupdate -group CU -radix hexadecimal sim:/minicputb/ConBusALU
add wave -noupdate -group CU -radix hexadecimal sim:/minicputb/i_CU/IR
add wave -noupdate -group CU -radix hexadecimal sim:/minicputb/i_CU/PC
add wave -noupdate -group CU -radix hexadecimal sim:/minicputb/i_CU/OPCODE
add wave -noupdate -group Clock -radix hexadecimal sim:/minicputb/HugeClock
add wave -noupdate -group Clock -radix hexadecimal sim:/minicputb/TinyClock
add wave -noupdate -group Clock -radix hexadecimal sim:/minicputb/ClockCycle
add wave -noupdate -group DataBus -radix hexadecimal sim:/minicputb/DataBusMemInput
add wave -noupdate -group DataBus -radix hexadecimal sim:/minicputb/DataBusReg
add wave -noupdate -group DataBus -radix hexadecimal sim:/minicputb/DataBusMemOutput
add wave -noupdate -group Input -radix hexadecimal sim:/minicputb/i_Numpad/NumpadReg
add wave -noupdate -group Memory -radix hexadecimal sim:/minicputb/i_Memory/REG
add wave -noupdate -group Memory -radix hexadecimal sim:/minicputb/i_Memory/RAM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2226431718062 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 223
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
WaveRestoreZoom {0 ps} {3749779735683 ps}
