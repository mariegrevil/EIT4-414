library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T19_ProcedureTb is
end entity;

architecture sim of T19_ProcedureTb is

	--Clock
	constant ClockFrequencyHz : integer := 10; -- 10 Hz
    constant ClockPeriod 	  : time := 1000 ms / ClockFrequencyHz;

	signal Clk : std_logic := '1';
	signal nRst : std_logic := '0';
	signal Seconds : integer;
	signal Minutes : integer;
	signal Hours : integer;
	
begin
	
	-- An instens of T15_Mux with architecture rtl
	i_Timer : entity work.T19_Timer(rtl) 
	generic map(ClockFrequencyHz => ClockFrequencyHz)
	port map(
		Clk	 => Clk,
		nRst => nRst,
		Seconds => Seconds,
		Minutes => Minutes,
		Hours => Hours);
		
	-- Proces for genarating Clk
	Clk <= not Clk after ClockPeriod / 2;
	
	--Testbench process
	process is
	begin 
		wait until rising_edge(Clk);
		wait until rising_edge(Clk);
		
		nRst <= '1'; -- Take DUT out of rest
		
		wait;
	end process;
	
end architecture;