library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Numpad is
	port	(-- Inputs:
			TinyClock		: in std_logic;
			Result			: in std_logic_vector(7 downto 0);
			
			-- Outputs:
			Binary			: out std_logic_vector(7 downto 0); -- Tallet som outputtes til displayet
			IO_TBR			: in std_logic;
			ActionJackson	: buffer std_logic_vector(7 downto 0) := "00000000";
			-- ActionJackson = [SW15, SW11, SW7, SW3, SW14][+, -, *, /, =]
			InputValueOne	: out std_logic_vector(7 downto 0) := (others => '0'); -- Første tal til ALU
			InputValueTwo	: out std_logic_vector(7 downto 0) := (others => '0'); -- Andet tal til ALU
			KEY0				: in std_logic;
			KEY1				: in std_logic;
			KEY2				: in std_logic;
			KEY3				: in std_logic
			
			);
end  Numpad;

architecture sim of Numpad is
begin

process(TinyClock)
begin

if rising_edge(TinyClock) then

		if KEY0 = '0' then -- Inputte 2 og 3

		InputValueOne <= "00000010";
		InputValueTwo <= "00000011";

		end if;

		if KEY1 = '0' then -- skriv +
		ActionJackson(4) <= '1'; --+
		ActionJackson(5) <= '0'; -- not clear
		end if;

		if KEY2 = '0' then -- Skrive =
		ActionJackson(0) <= '1'; --=
		end if;

		if KEY3 = '0' then -- Clear
		InputValueOne <= "00000000";
		InputValueTwo <= "00000000";
		ActionJackson <= "00100000";
		end if;
end if;

end process;
	
end architecture;