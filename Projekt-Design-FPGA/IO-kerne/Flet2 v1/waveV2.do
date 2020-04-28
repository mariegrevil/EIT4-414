onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Clock
add wave -noupdate /testbench/HugeClock
add wave -noupdate /testbench/TinyClock
add wave -noupdate /testbench/ClockCycle
add wave -noupdate -divider BUS's
add wave -noupdate /testbench/AddrBusProgram
add wave -noupdate /testbench/DataBusProgram
add wave -noupdate /testbench/AddrBusMemInput
add wave -noupdate /testbench/DataBusMemInput
add wave -noupdate /testbench/EnRamInput
add wave -noupdate /testbench/AddrBusReg
add wave -noupdate /testbench/DataBusReg
add wave -noupdate /testbench/AddrBusMemOutput
add wave -noupdate /testbench/DataBusMemOutput
add wave -noupdate /testbench/EnRamOutput
add wave -noupdate /testbench/ConBusALU
add wave -noupdate /testbench/NSelOut
add wave -noupdate /testbench/SkipProgram
add wave -noupdate /testbench/TooBigResult
add wave -noupdate -divider IO-BUS's
add wave -noupdate /testbench/IO_AddrBusProgram
add wave -noupdate /testbench/IO_DataBusProgram
add wave -noupdate /testbench/IO_AddrBusReg
add wave -noupdate /testbench/IO_DataBusReg
add wave -noupdate /testbench/IO_AddrBusMemOutput
add wave -noupdate /testbench/IO_DataBusMemOutput
add wave -noupdate /testbench/IO_ConBusALU
add wave -noupdate /testbench/IO_NSelOut
add wave -noupdate /testbench/IO_TBR
add wave -noupdate -divider IO
add wave -noupdate /testbench/Binary
add wave -noupdate /testbench/Result
add wave -noupdate -radix hexadecimal /testbench/DecimalOutput
add wave -noupdate /testbench/i_BCD/Busy
add wave -noupdate /testbench/ActionJackson
add wave -noupdate /testbench/InputValueOne
add wave -noupdate /testbench/InputValueTwo
add wave -noupdate /testbench/DisplayOutput
add wave -noupdate -divider Mem
add wave -noupdate -childformat {{/testbench/i_Memory/REG(30) -radix decimal} {/testbench/i_Memory/REG(29) -radix decimal} {/testbench/i_Memory/REG(28) -radix decimal} {/testbench/i_Memory/REG(27) -radix decimal} {/testbench/i_Memory/REG(26) -radix decimal} {/testbench/i_Memory/REG(25) -radix decimal} {/testbench/i_Memory/REG(24) -radix decimal} {/testbench/i_Memory/REG(23) -radix decimal} {/testbench/i_Memory/REG(22) -radix decimal} {/testbench/i_Memory/REG(21) -radix decimal} {/testbench/i_Memory/REG(20) -radix decimal} {/testbench/i_Memory/REG(19) -radix decimal} {/testbench/i_Memory/REG(18) -radix decimal} {/testbench/i_Memory/REG(17) -radix decimal} {/testbench/i_Memory/REG(16) -radix decimal} {/testbench/i_Memory/REG(15) -radix decimal} {/testbench/i_Memory/REG(14) -radix decimal} {/testbench/i_Memory/REG(13) -radix decimal} {/testbench/i_Memory/REG(12) -radix decimal} {/testbench/i_Memory/REG(11) -radix decimal} {/testbench/i_Memory/REG(10) -radix decimal} {/testbench/i_Memory/REG(9) -radix decimal} {/testbench/i_Memory/REG(8) -radix decimal} {/testbench/i_Memory/REG(7) -radix decimal} {/testbench/i_Memory/REG(6) -radix decimal} {/testbench/i_Memory/REG(5) -radix decimal} {/testbench/i_Memory/REG(4) -radix decimal} {/testbench/i_Memory/REG(3) -radix decimal} {/testbench/i_Memory/REG(2) -radix decimal} {/testbench/i_Memory/REG(1) -radix decimal} {/testbench/i_Memory/REG(0) -radix decimal}} -expand -subitemconfig {/testbench/i_Memory/REG(30) {-height 15 -radix decimal} /testbench/i_Memory/REG(29) {-height 15 -radix decimal} /testbench/i_Memory/REG(28) {-height 15 -radix decimal} /testbench/i_Memory/REG(27) {-height 15 -radix decimal} /testbench/i_Memory/REG(26) {-height 15 -radix decimal} /testbench/i_Memory/REG(25) {-height 15 -radix decimal} /testbench/i_Memory/REG(24) {-height 15 -radix decimal} /testbench/i_Memory/REG(23) {-height 15 -radix decimal} /testbench/i_Memory/REG(22) {-height 15 -radix decimal} /testbench/i_Memory/REG(21) {-height 15 -radix decimal} /testbench/i_Memory/REG(20) {-height 15 -radix decimal} /testbench/i_Memory/REG(19) {-height 15 -radix decimal} /testbench/i_Memory/REG(18) {-height 15 -radix decimal} /testbench/i_Memory/REG(17) {-height 15 -radix decimal} /testbench/i_Memory/REG(16) {-height 15 -radix decimal} /testbench/i_Memory/REG(15) {-height 15 -radix decimal} /testbench/i_Memory/REG(14) {-height 15 -radix decimal} /testbench/i_Memory/REG(13) {-height 15 -radix decimal} /testbench/i_Memory/REG(12) {-height 15 -radix decimal} /testbench/i_Memory/REG(11) {-height 15 -radix decimal} /testbench/i_Memory/REG(10) {-height 15 -radix decimal} /testbench/i_Memory/REG(9) {-height 15 -radix decimal} /testbench/i_Memory/REG(8) {-height 15 -radix decimal} /testbench/i_Memory/REG(7) {-height 15 -radix decimal} /testbench/i_Memory/REG(6) {-height 15 -radix decimal} /testbench/i_Memory/REG(5) {-height 15 -radix decimal} /testbench/i_Memory/REG(4) {-height 15 -radix decimal} /testbench/i_Memory/REG(3) {-height 15 -radix decimal} /testbench/i_Memory/REG(2) {-height 15 -radix decimal} /testbench/i_Memory/REG(1) {-height 15 -radix decimal} /testbench/i_Memory/REG(0) {-height 15 -radix decimal}} /testbench/i_Memory/REG
add wave -noupdate /testbench/i_Memory/RAM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {81259468231343 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 106
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
configure wave -timelineunits sec
update
WaveRestoreZoom {78648326102247 ps} {84010861280479 ps}
