onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Clock
add wave -noupdate /minicputb/HugeClock
add wave -noupdate /minicputb/TinyClock
add wave -noupdate /minicputb/ClockCycle
add wave -noupdate -divider CU
add wave -noupdate /minicputb/i_CU/IR
add wave -noupdate -radix unsigned /minicputb/i_CU/PC
add wave -noupdate /minicputb/i_CU/OPCODE
add wave -noupdate -divider Program
add wave -noupdate /minicputb/DataBusProgram
add wave -noupdate -radix unsigned /minicputb/AddrBusProgram
add wave -noupdate -divider MainData
add wave -noupdate -group Reg /minicputb/AddrBusReg
add wave -noupdate -group Reg /minicputb/DataBusReg
add wave -noupdate -group MemInput /minicputb/AddrBusMemInput
add wave -noupdate -group MemInput /minicputb/EnRamInput
add wave -noupdate -group MemInput /minicputb/DataBusMemInput
add wave -noupdate -expand -group MemOutput /minicputb/AddrBusMemOutput
add wave -noupdate -expand -group MemOutput /minicputb/EnRamOutput
add wave -noupdate -expand -group MemOutput -radix unsigned /minicputb/DataBusMemOutput
add wave -noupdate /minicputb/ConBusALU
add wave -noupdate /minicputb/NumpadReg
add wave -noupdate -divider Mem
add wave -noupdate /minicputb/i_Memory/NSelOut
add wave -noupdate -radix unsigned -childformat {{/minicputb/i_Memory/REG(31) -radix unsigned} {/minicputb/i_Memory/REG(30) -radix unsigned} {/minicputb/i_Memory/REG(29) -radix unsigned} {/minicputb/i_Memory/REG(28) -radix unsigned} {/minicputb/i_Memory/REG(27) -radix unsigned} {/minicputb/i_Memory/REG(26) -radix unsigned} {/minicputb/i_Memory/REG(25) -radix unsigned} {/minicputb/i_Memory/REG(24) -radix unsigned} {/minicputb/i_Memory/REG(23) -radix unsigned} {/minicputb/i_Memory/REG(22) -radix unsigned} {/minicputb/i_Memory/REG(21) -radix unsigned} {/minicputb/i_Memory/REG(20) -radix binary} {/minicputb/i_Memory/REG(19) -radix binary} {/minicputb/i_Memory/REG(18) -radix binary} {/minicputb/i_Memory/REG(17) -radix binary} {/minicputb/i_Memory/REG(16) -radix binary} {/minicputb/i_Memory/REG(15) -radix binary} {/minicputb/i_Memory/REG(14) -radix unsigned} {/minicputb/i_Memory/REG(13) -radix unsigned} {/minicputb/i_Memory/REG(12) -radix unsigned} {/minicputb/i_Memory/REG(11) -radix unsigned} {/minicputb/i_Memory/REG(10) -radix unsigned} {/minicputb/i_Memory/REG(9) -radix unsigned} {/minicputb/i_Memory/REG(8) -radix unsigned} {/minicputb/i_Memory/REG(7) -radix unsigned} {/minicputb/i_Memory/REG(6) -radix unsigned} {/minicputb/i_Memory/REG(5) -radix unsigned} {/minicputb/i_Memory/REG(4) -radix unsigned} {/minicputb/i_Memory/REG(3) -radix unsigned} {/minicputb/i_Memory/REG(2) -radix unsigned} {/minicputb/i_Memory/REG(1) -radix unsigned} {/minicputb/i_Memory/REG(0) -radix unsigned}} -subitemconfig {/minicputb/i_Memory/REG(31) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(30) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(29) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(28) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(27) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(26) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(25) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(24) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(23) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(22) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(21) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(20) {-height 15 -radix binary} /minicputb/i_Memory/REG(19) {-height 15 -radix binary} /minicputb/i_Memory/REG(18) {-height 15 -radix binary} /minicputb/i_Memory/REG(17) {-height 15 -radix binary} /minicputb/i_Memory/REG(16) {-height 15 -radix binary} /minicputb/i_Memory/REG(15) {-height 15 -radix binary} /minicputb/i_Memory/REG(14) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(13) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(12) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(11) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(10) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(9) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(8) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(7) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(6) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(5) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(4) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(3) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(2) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(1) {-height 15 -radix unsigned} /minicputb/i_Memory/REG(0) {-height 15 -radix unsigned}} /minicputb/i_Memory/REG
add wave -noupdate /minicputb/i_Memory/RAM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15599878494764 ps} 0}
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
WaveRestoreZoom {10204724409448 ps} {15454724409448 ps}
