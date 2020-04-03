library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MiniCPUTb is
end  MiniCPUTb;

architecture sim of MiniCPUTb is

	--Clock
	constant ClockFrequencyHz : integer := 10; -- 10 Hz
    constant ClockPeriod 	  : time := 1000 ms / ClockFrequencyHz;

	signal CLK : std_logic := '0';
	signal CLK1 : std_logic := '0';
	
	signal DataBusA : std_logic_vector(31 downto 0);
	signal AddrBusA : std_logic_vector(7 downto 0);
	signal AddrBusC : std_logic_vector(7 downto 0);
	signal AddrBusD : std_logic_vector(7 downto 0);
	signal AddrBusD2: std_logic_vector(7 downto 0);
	signal EnRam 	: std_logic;
	signal EnRam2 	: std_logic;
	signal ConBusA	: std_logic_vector(3 downto 0);
	
begin
	
	i_CU : entity work.CU(rtl) 
	port map(
		DataBusA 	=> DataBusA,
		AddrBusA 	=> AddrBusA,
		AddrBusC 	=> AddrBusC,
		AddrBusD 	=> AddrBusD,
		AddrBusD2	=> AddrBusD2,
		EnRam 		=> EnRam,
		EnRam2	 	=> EnRam2,
		ConBusA 	=>  ConBusA,
		CLK 		=> CLK,
		CLK1		=> CLK1);
	
	i_ProgramCode: entity work.ProgramCode(rtl)
	
	port map(
		DataBusA => DataBusA,
		AddrBusA => AddrBusA,
		CLK 	 => CLK
	);
	
	
	-- Proces for genarating Clk
	CLK <= not CLK after ClockPeriod / 2;
	CLK1 <= not CLK1 after ClockPeriod*4 / 2;
	
end architecture;