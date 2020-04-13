library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Numpad is
	port	(TinyClock		: in std_logic;
	
			Binary			: out std_logic_vector(7 downto 0)
	
			);

end  Numpad;

architecture sim of Numpad is

	signal Row			: std_logic_vector(3 downto 0) := (others => '0');
	signal Column		: std_logic_vector(3 downto 0) := (others => '0');
	
	-- KUN TIL TEST
	signal TestButton	: std_logic_vector(15 downto 0) := (others => '0');
	
	signal Counter		: integer := 0;
	
begin

	process (TinyClock) is
	begin
	
		if (rising_edge(TinyClock)) then
			Row <= (others => '0');
			Row(Counter) <= '1';
		elsif (falling_edge(TinyClock)) then
			if (Counter < 3) then
				Counter <= Counter + 1;
			else
				Counter <= 0;
			end if;
		end if;
		
	end process;
	
	process (Row) is
	begin
		Column <= (others => '0');
		for i in 0 to 15 loop
			
			if (TestButton(i) = '1') then
				Column(i rem 4) <= Row(i / 4);
			end if;

		end loop;
	
	end process;

	
	
	-- KUN TIL TEST
	process is
	begin
		
		for i in 0 to 15 loop
			wait for 1000 ms;
			TestButton(i) <= '1';
			wait for 500 ms;
			TestButton <= (others => '0');
		end loop;
		
		wait;
	
	end process;
	

	
end architecture;