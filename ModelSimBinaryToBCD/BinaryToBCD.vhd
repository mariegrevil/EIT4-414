library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use IEEE.std_logic_unsigned.all;

entity BinaryToBCD is
end  BinaryToBCD;

architecture sim of BinaryToBCD is

	signal HugeClock			: std_logic;
	signal TinyClock			: std_logic;
	signal ClockCycle			: std_logic_vector(2 downto 0);
	
	signal Binary				: std_logic_vector (7 downto 0) := (others => '0');
	
	type BCD is array (5 downto 0) of std_logic_vector (3 downto 0);
	signal Decimal				: BCD := (0 => (others => '0'),
										  others => (others => '1'));
	
	signal CurrentValue			: integer := 0;
	signal Scratchpad			: integer := 0;
	
	signal Busy					: boolean := false;
	signal ConvProgress			: std_logic_vector(2 downto 0) := (others => '0');
	
begin
	
	i_Clock : entity work.ClockDividerModule(sim)
	port map(
		HugeClock		=> HugeClock,
		TinyClock		=> TinyClock,
		ClockCycle		=> ClockCycle);
	
	process (Busy, TinyClock, Binary) is
	begin
		
		if (Binary'event) and (not Busy) then
			if (to_integer(unsigned(Binary)) /= CurrentValue) then
				Busy <= true;
				ConvProgress <= (others => '0');
				CurrentValue <= to_integer(unsigned(Binary));
				Scratchpad <= to_integer(unsigned(Binary));
				Decimal <= (0 => (others => '0'),
							others => (others => '1'));
			end if;
		end if;
		
		if (Busy) and (rising_edge(TinyClock)) then

			case ConvProgress is
				when "000" =>
					if (Scratchpad > 100) then
						Decimal(2) <= std_logic_vector(to_unsigned(Scratchpad / 100, 4));
						Scratchpad <= Scratchpad rem 100;
					end if;
				when "001" =>
					if (Scratchpad > 10) then
						Decimal(1) <= std_logic_vector(to_unsigned(Scratchpad / 10, 4));
						Scratchpad <= Scratchpad rem 10;
					end if;
				when "010" =>
					if (Scratchpad > 1) then
						Decimal(0) <= std_logic_vector(to_unsigned(Scratchpad, 4));
					end if;
				when others =>
					Busy <= false;
			end case;
			
			ConvProgress <= std_logic_vector(to_unsigned(to_integer(unsigned(ConvProgress)) + 1, 3));
			
		end if;

	end process;
	
	process is
	begin

		Binary <= std_logic_vector(to_unsigned(to_integer(unsigned(Binary)) + 1, 8));
		
		wait for 1700 ms;
		
		if Binary = "11111111" then
			wait;
		end if;
	
	end process;
	
end architecture;