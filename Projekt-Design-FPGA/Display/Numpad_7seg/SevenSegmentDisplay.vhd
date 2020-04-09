library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
--use ieee.std_logic_unsigned.all;

entity SevenSegmentDisplay is
	port(
	
		-- Displaysegmenter:
		display			: out std_logic_vector(41 downto 0);
		
		-- Clock:
		TinyClock		: in std_logic;
		
		-- Cifferværdier:
		DisplayValue	: in std_logic_vector(3 downto 0);
		
		-- Puls når der trykkes på en cifferknap:
		NumBtnPush		: in std_logic;
		
		);
end SevenSegmentDisplay;

architecture rtl of SevenSegmentDisplay is

	
	signal Decode_Data	: std_logic_vector(6 downto 0); -- Her declares et 7 bit array for hvilke linjer i displaytallet som skal tændes
	
	-- Display-RAM (holder de cifre der skal vises):
	signal DRAM 			: std_logic_vector(41 downto 0) := (others => '0');

	-- Værdien af det behandlede ciffer (binær):
	signal Digit			: std_logic_vector(3 downto 0) := "0000";
	signal DigitCounter	: integer := 1;
	
	-- Det tal der vises på hele displayet i integer-form:
	signal TotalValue		: integer;

begin
	-- Opdaterer display:
	display <= not DRAM;
	
	-- Reagerer på numpad-tryk:
	process(NumBtnPush)
	begin
	
		-- Display-controller
		
		-- Så længe displayet ikke er overfyldt:
		if (DigitCounter < 6) then
			
			-- Hvis der kun står 0 på displayet, så ingen bitshift:
			if (DigitCounter = 1) and (Digit = "0000") then
				TotalValue <= conv_inv(DisplayValue);
				
			-- Hvis der står andet end 0, så skal der shiftes:
			else
				TotalValue <= (TotalValue * 10) + conv_inv(DisplayValue);
				
				-- Alle cifre rykkes til venstre (bitshift):
				for i in 41 downto 7 loop				
					DRAM(i) <= DRAM(i-7); -- Flytter ciffer på display en plads til venstre
				end loop;
				
				-- Registrer at der er lagt et nyt ciffer ind på displayet:
				DigitCounter <= DigitCounter + 1;
				
			end if;
		
			-- Gemmer den input-værdi der fås fra Numpad:
			Digit <= DisplayValue;

			-- Sender tallet valgt til DRAM: (Bit rækefølge inverteres for at gøre pin planner lettere)
			DRAM(6)	<=	  Decode_Data(0);
			DRAM(5)	<=	  Decode_Data(1);
			DRAM(4)	<=	  Decode_Data(2);
			DRAM(3)	<=	  Decode_Data(3);
			DRAM(2)	<=	  Decode_Data(4);
			DRAM(1)	<=	  Decode_Data(5);
			DRAM(0)	<=	  Decode_Data(6);
			
		-- Hvis displayet er overfyldt:
		else
			DRAM <= (others => '0');
			DigitCounter <= 1;
			Digit <= "0000";
			TotalValue <= 0;
		end if;
		

		
	end process;
	
	
	process(TinyClock)
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
--			when "1010" => Decode_Data <= "1110111"; -- A
--			when "1011" => Decode_Data <= "0011111"; -- B
--			when "1100" => Decode_Data <= "1001110"; -- C
--			when "1101" => Decode_Data <= "0111101"; -- D
--			when "1110" => Decode_Data <= "1001111"; -- E
			when "1111" => Decode_Data <= "1000111"; -- F
			when others => Decode_Data <= "0110111"; -- Error 'H'
		end case;
		
		

		
	
		
	end process;

end rtl;