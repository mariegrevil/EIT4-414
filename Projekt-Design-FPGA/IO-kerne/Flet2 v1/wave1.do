onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Clock
add wave -noupdate /testbench/HugeClock
add wave -noupdate /testbench/TinyClock
add wave -noupdate /testbench/ClockCycle
add wave -noupdate -divider Program
add wave -noupdate /testbench/AddrBusProgram
add wave -noupdate /testbench/DataBusProgram
add wave -noupdate /testbench/SkipProgram
add wave -noupdate -divider MemBus's
add wave -noupdate /testbench/AddrBusMemInput
add wave -noupdate /testbench/DataBusMemInput
add wave -noupdate /testbench/EnRamInput
add wave -noupdate /testbench/AddrBusReg
add wave -noupdate /testbench/DataBusReg
add wave -noupdate /testbench/AddrBusMemOutput
add wave -noupdate /testbench/DataBusMemOutput
add wave -noupdate /testbench/EnRamOutput
add wave -noupdate /testbench/NSelOut
add wave -noupdate -divider I/O
add wave -noupdate /testbench/Binary
add wave -noupdate /testbench/Result
add wave -noupdate /testbench/DecimalOutput
add wave -noupdate /testbench/ActionJackson
add wave -noupdate /testbench/InputValueOne
add wave -noupdate /testbench/InputValueTwo
add wave -noupdate /testbench/DisplayOutput
add wave -noupdate /testbench/ConBusALU
add wave -noupdate /testbench/TooBigResult
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
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits sec
update
WaveRestoreZoom {0 ps} {1 ns}
