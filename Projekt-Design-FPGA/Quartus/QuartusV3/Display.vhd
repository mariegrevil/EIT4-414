library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Display is
	
	port	(TinyClock		: in std_logic;
			-- Input i form af BCD.
			DecimalOutput	: in std_logic_vector (23 downto 0);
			-- Output i form a 7-segment-mønstre.
			DisplayOutput 	: out std_logic_vector(41 downto 0)
			);

end  Display;

architecture sim of Display is
	-- Array der holder BCD for hver cifferplads.
	type BCD is array (5 downto 0) of std_logic_vector (3 downto 0);
	signal Digit			: BCD;
	-- Array der holder 7-segment-mønstret for hver ciffer-plads.
	type SevenSeg is array (5 downto 0) of std_logic_vector (6 downto 0);
	signal DisplayRAM				: SevenSeg;

begin

	-- Kører hver gang input til displayet har ændret sig.
	process (DecimalOutput)
	begin
		-- Opdatér samtlige lokale ciffer-variable, så de matcher input.
		Digit(0) <= DecimalOutput(3 downto 0);
		Digit(1) <= DecimalOutput(7 downto 4);
		Digit(2) <= DecimalOutput(11 downto 8);
		Digit(3) <= DecimalOutput(15 downto 12);
		Digit(4) <= DecimalOutput(19 downto 16);
		Digit(5) <= DecimalOutput(23 downto 20);
	end process;

	-- Opdatér display-hukommelsen med 7-segment-mønstre ud fra BCD.
	process(TinyClock)
		begin
		for i in 0 to 5 loop
			-- Her "tegnes" tallene 0-9 på displayet(+HEX): se board manualen sektion 3.3
			case Digit(i) is
				when "0000" => DisplayRAM(i) <= "1111110"; -- 0
				when "0001" => DisplayRAM(i) <= "0110000"; -- 1
				when "0010" => DisplayRAM(i) <= "1101101"; -- 2
				when "0011" => DisplayRAM(i) <= "1111001"; -- 3
				when "0100" => DisplayRAM(i) <= "0110011"; -- 4
				when "0101" => DisplayRAM(i) <= "1011011"; -- 5
				when "0110" => DisplayRAM(i) <= "1011111"; -- 6
				when "0111" => DisplayRAM(i) <= "1110000"; -- 7
				when "1000" => DisplayRAM(i) <= "1111111"; -- 8
				when "1001" => DisplayRAM(i) <= "1111011"; -- 9
				when "1010" => DisplayRAM(i) <= "1110111"; -- A
				when "1011" => DisplayRAM(i) <= "1001111"; -- B - [E] skal tegnes
				when "1100" => DisplayRAM(i) <= "0000101"; -- C - [r] skal tegnes
				when "1101" => DisplayRAM(i) <= "0011101"; -- D - [o] skal tegnes
				when "1110" => DisplayRAM(i) <= "0000001"; -- Minus
				when "1111" => DisplayRAM(i) <= "0000000"; -- Slukket
				when others => DisplayRAM(i) <= "0110111"; -- Error 'H'
			end case;
		end loop;
		
		-- Send 7-segment-mønstrene til displayet.
		DisplayOutput <= not (DisplayRAM(5) & DisplayRAM(4) & DisplayRAM(3) & DisplayRAM(2) & DisplayRAM(1) & DisplayRAM(0));
		
	end process;
	
end architecture;