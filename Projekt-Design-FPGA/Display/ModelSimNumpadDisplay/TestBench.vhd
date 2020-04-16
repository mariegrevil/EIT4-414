library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TestBench is
end  TestBench;

architecture sim of TestBench is

	-- signaler
	signal HugeClock			: std_logic;
	signal TinyClock			: std_logic;
	signal ClockCycle			: std_logic_vector(2 downto 0);
	
	-- Input-værdi til displayet i form af vektor med 8 bits.
	signal Binary				: std_logic_vector (7 downto 0) := (others => '0');
	
	-- Input-værdi konverteret fra binær til BCD.
	signal DecimalOutput		: std_logic_vector (23 downto 0);
	
	-- Input-værdi konverteret fra BCD til 7-segment-mønster.
	signal DisplayOutput		: std_logic_vector (41 downto 0);
	
begin
	
	-- Henter clock ind for at kunne reagere på TinyClock.
	i_Clock : entity work.ClockDividerModule(sim)
	port map(
		HugeClock		=> HugeClock,
		TinyClock		=> TinyClock,
		ClockCycle		=> ClockCycle);
	
	i_BCD : entity work.BinaryToBCD(sim)
	port map(
		TinyClock		=> TinyClock,
		Binary			=> Binary,
		DecimalOutput	=> DecimalOutput);
		
	i_Display : entity work.Display(sim)
	port map(
		TinyClock		=> TinyClock,
		DecimalOutput	=> DecimalOutput,
		DisplayOutput 	=> DisplayOutput);
		
	i_Numpad : entity work.Numpad(sim)
	port map(
		TinyClock		=> TinyClock,
		Binary 			=> Binary
		);
	
end architecture;