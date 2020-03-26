-- TopDesign [By Johnni :D]

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
--use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity TopDesign is
	--setup:
	port	(	-- Switches:
				switch0	:	in std_logic;
				switch1	:	in std_logic;
				switch2	:	in std_logic;
				switch3	:	in std_logic;
				
				shift_btn : in std_logic;
				reset_btn : in std_logic;

				--Display:
				display : out std_logic_vector(41 downto 0) := (others => '0')

				);
								
end TopDesign;


architecture rtl of TopDesign is

signal Digit :	std_logic_vector	(3	downto 0) := (others => '0');

--	Setup DRAM array [7-bit per digit]: 
--				Digit0 = DRAM(0)
--				Digit1 = DRAM(7)
--				Digit2 = DRAM(14)
--				Digit3 = DRAM(21)
--				Digit4 = DRAM(28)
--				Digit5 = DRAM(35)
			
signal Decode_Data : std_logic_vector(6 downto 0); -- Her declares et 7 bit array for hvilke linjer i displaytallet som skal tændes
signal DRAM : std_logic_vector (41 downto 0) := (others => '0');

begin

-- De 4 dib switches state ligges i Digit arrayet
Digit(0) <= switch0;
Digit(1) <= switch1;
Digit(2) <= switch2;
Digit(3) <= switch3;

-- Display updateres:
display <= not DRAM;

	-- Dip switch fortolker til tal:
	process(Digit)

		begin
	
		-- Her "tegnes" tallene 0-9 på displayet(+HEX): se board manualen sektion 3.3
		case Digit is
			when "0000" => Decode_Data <= "1111110"; -- 0
			when "0001" => Decode_Data <= "0110000"; -- 1
			when "0010" => Decode_Data <= "1101101"; -- 2
			when "0011" => Decode_Data <= "1111001"; -- 3
			when "0100" => Decode_Data <= "1011011"; -- 4
			when "0101" => Decode_Data <= "1011011"; -- 5
			when "0110" => Decode_Data <= "1011111"; -- 6
			when "0111" => Decode_Data <= "1110000"; -- 7
			when "1000" => Decode_Data <= "1111111"; -- 8
			when "1001" => Decode_Data <= "1111011"; -- 9
			when "1010" => Decode_Data <= "1110111"; -- A
			when "1011" => Decode_Data <= "0011111"; -- B
			when "1100" => Decode_Data <= "1001110"; -- C
			when "1101" => Decode_Data <= "0111101"; -- D
			when "1110" => Decode_Data <= "1001111"; -- E
			when "1111" => Decode_Data <= "1000111"; -- F
			when others => Decode_Data <= "0110111"; -- Error 'H'
		end case;
		
	end process;
			
	process(DRAM, shift_btn, reset_btn, Decode_Data)

	begin
		-- Sender tallet valgt til DRAM:
		DRAM(6)	<=	  Decode_Data(6);
		DRAM(5)	<=	  Decode_Data(5);
		DRAM(4)	<=	  Decode_Data(4);
		DRAM(3)	<=	  Decode_Data(3);
		DRAM(2)	<=	  Decode_Data(2);
		DRAM(1)	<=	  Decode_Data(1);
		DRAM(0)	<=	  Decode_Data(0);
		
		
		if (shift_btn = '1') and (shift_btn'event) then --if hvis knappen trykkes
		-- Flyt tallet til næste plads:
			for i in 41 downto 7 loop
				DRAM(i) <= DRAM(i-7);
			end loop;
		end if;
		
--		if (reset_btn = '1') and (reset_btn'event) then --if hvis knappen trykkes
--		-- Reset display:
--			for i in 41 downto 0 loop
--				DRAM(i) <= '0';
--			end loop;
--		end if;
			
	end process;
		
end rtl;

