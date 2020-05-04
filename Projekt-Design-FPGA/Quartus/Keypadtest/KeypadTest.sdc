create_clock -period 20 -name Clk -waveform {0 10} [get_ports Clk]
#create_clock -period 1000000 -name ClockCnt -waveform {0 500000} -add [get_ports Clk]