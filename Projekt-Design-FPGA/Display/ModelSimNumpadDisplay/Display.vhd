library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Display is
	
	port	(TinyClock		: in std_logic;
			 DecimalOutput	: in std_logic_vector (23 downto 0);
			 
			 DisplayOutput 	: out std_logic_vector(41 downto 0)
			 );

end  Display;

architecture sim of Display is
	
	type BCD is array (5 downto 0) of std_logic_vector (3 downto 0);
	signal Digit			: BCD;
	
	type SevenSeg is array (5 downto 0) of std_logic_vector (6 downto 0);
	signal DRAM				: SevenSeg;

begin

	process (DecimalOutput)
	begin
	
		Digit(0) <= DecimalOutput(3 downto 0);
		Digit(1) <= DecimalOutput(7 downto 4);
		Digit(2) <= DecimalOutput(11 downto 8);
		Digit(3) <= DecimalOutput(15 downto 12);
		Digit(4) <= DecimalOutput(19 downto 16);
		Digit(5) <= DecimalOutput(23 downto 20);
	
	end process;


	process(TinyClock)

		begin
	
		for i in 0 to 5 loop
			-- Her "tegnes" tallene 0-9 på displayet(+HEX): se board manualen sektion 3.3
			case Digit(i) is
				when "0000" => DRAM(i) <= "1111110"; -- 0
				when "0001" => DRAM(i) <= "0110000"; -- 1
				when "0010" => DRAM(i) <= "1101101"; -- 2
				when "0011" => DRAM(i) <= "1111001"; -- 3
				when "0100" => DRAM(i) <= "1011011"; -- 4
				when "0101" => DRAM(i) <= "1011011"; -- 5
				when "0110" => DRAM(i) <= "1011111"; -- 6
				when "0111" => DRAM(i) <= "1110000"; -- 7
				when "1000" => DRAM(i) <= "1111111"; -- 8
				when "1001" => DRAM(i) <= "1111011"; -- 9
				when "1010" => DRAM(i) <= "1110111"; -- A
				when "1011" => DRAM(i) <= "0011111"; -- B
				when "1100" => DRAM(i) <= "1001110"; -- C
				when "1101" => DRAM(i) <= "0111101"; -- D
				when "1110" => DRAM(i) <= "1001111"; -- E
				when "1111" => DRAM(i) <= "1000111"; -- F
				when others => DRAM(i) <= "0110111"; -- Error 'H'
			end case;
		end loop;
		
		DisplayOutput <= not (DRAM(5) & DRAM(4) & DRAM(3) & DRAM(2) & DRAM(1) & DRAM(0));
		
	end process;
	
end architecture;