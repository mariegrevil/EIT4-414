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
	
	-- Input-værdi i form af vektor med 8 bits.
	signal Binary				: std_logic_vector (7 downto 0) := (others => '0');
	signal DecimalOutput		: std_logic_vector (23 downto 0);
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
	
		-- Testproces. Får input til at ændre sig med et fast interval for at se om systemet kan følge med.
	-- process is
	-- begin

		-- Binary <= std_logic_vector(to_unsigned(to_integer(unsigned(Binary)) + 1, Binary'length));
		
		-- wait for 1700 ms;
		
		-- Binary <= std_logic_vector(to_unsigned(to_integer(unsigned(Binary)) + 1, Binary'length));
		
		-- wait for 250 ms;
		
		-- if Binary = "11111111" then
			-- wait;
		-- end if;
	
	-- end process;
	
end architecture;