onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Clock
add wave -noupdate /minicputb/HugeClock
add wave -noupdate /minicputb/TinyClock
add wave -noupdate /minicputb/ClockCycle
add wave -noupdate -divider CU
add wave -noupdate /minicputb/i_CU/IR
add wave -noupdate /minicputb/i_CU/PC
add wave -noupdate /minicputb/i_CU/OPCODE
add wave -noupdate -divider Program
add wave -noupdate /minicputb/DataBusProgram
add wave -noupdate /minicputb/AddrBusProgram
add wave -noupdate -divider MainData
add wave -noupdate -group Reg /minicputb/AddrBusReg
add wave -noupdate -group Reg /minicputb/DataBusReg
add wave -noupdate -group MemInput /minicputb/AddrBusMemInput
add wave -noupdate -group MemInput /minicputb/EnRamInput
add wave -noupdate -group MemInput /minicputb/DataBusMemInput
add wave -noupdate -group MemOutput /minicputb/AddrBusMemOutput
add wave -noupdate -group MemOutput /minicputb/EnRamOutput
add wave -noupdate -group MemOutput /minicputb/DataBusMemOutput
add wave -noupdate /minicputb/ConBusALU
add wave -noupdate /minicputb/NumpadReg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2450000000000 ps} 0}
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
configure wave -timelineunits ms
update
WaveRestoreZoom {0 ps} {5250 ms}
