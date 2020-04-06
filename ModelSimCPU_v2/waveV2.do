onerror {resume}
quietly set dataset_list [list sim vsim]
if {[catch {datasetcheck $dataset_list}]} {abort}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group CU_Intern sim:/minicputb/i_CU/IR
add wave -noupdate -group CU_Intern sim:/minicputb/i_CU/PC
add wave -noupdate -group CU_Intern sim:/minicputb/i_CU/OPCODE
add wave -noupdate -group Clock sim:/minicputb/HugeClock
add wave -noupdate -group Clock sim:/minicputb/TinyClock
add wave -noupdate -group Clock sim:/minicputb/ClockCycle
add wave -noupdate -group BusProgram sim:/minicputb/AddrBusProgram
add wave -noupdate -group BusProgram sim:/minicputb/DataBusProgram
add wave -noupdate -group BusReg sim:/minicputb/AddrBusReg
add wave -noupdate -group BusReg sim:/minicputb/DataBusReg
add wave -noupdate -group BusMemInput sim:/minicputb/AddrBusMemInput
add wave -noupdate -group BusMemInput sim:/minicputb/DataBusMemInput
add wave -noupdate -group BusMemInput sim:/minicputb/EnRamInput
add wave -noupdate -group BusMemOutput sim:/minicputb/AddrBusMemOutput
add wave -noupdate -group BusMemOutput sim:/minicputb/DataBusMemOutput
add wave -noupdate -group BusMemOutput sim:/minicputb/EnRamOutput
add wave -noupdate sim:/minicputb/ConBusALU
add wave -noupdate sim:/minicputb/NumpadReg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 78
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
configure wave -timelineunits ms
update
WaveRestoreZoom {0 ps} {4440996184064 ps}
