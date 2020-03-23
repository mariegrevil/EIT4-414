-- En dipswitch styret 7 segment display counter [By Johnni :D]

library ieee;
use ieee.std_logic_1164.all;

entity Seven_segment_display_tb is
	--setup:
	
	port	(	Digit			:	in		std_logic_vector	(3	downto 0);
				segment_A	:	out	std_logic;
				segment_B	:	out	std_logic;
				segment_C	:	out	std_logic;
				segment_D	:	out	std_logic;
				segment_E	:	out	std_logic;
				segment_F	:	out	std_logic;
				segment_G	:	out	std_logic);
					
end Seven_segment_display_tb;


architecture rtl of Seven_segment_display_tb is
	-- loop:
begin
	process(Digit)
		variable Decode_Data : std_logic_vector(6 downto 0); -- Her declares et 7 bit array for hvilke linjer i displaytallet som skal tændes
	
		begin
		
		-- Her "tegnes" tallene 0-9 på displayet, se board manualen sektion 3.3
		case Digit is
			when "0000" => Decode_Data := "1111110"; -- 0
			when "0001" => Decode_Data := "0110000"; -- 1
			when "0010" => Decode_Data := "1101101"; -- 2
			when "0011" => Decode_Data := "1111001"; -- 3
			when "0100" => Decode_Data := "1011011"; -- 4
			when "0101" => Decode_Data := "1011011"; -- 5
			when "0110" => Decode_Data := "1011111"; -- 6
			when "0111" => Decode_Data := "1110000"; -- 7
			when "1000" => Decode_Data := "1111111"; -- 8
			when "1001" => Decode_Data := "1111011"; -- 9
			when "1111" => Decode_Data := "1000010"; -- TOM felt (til test)
			when others => Decode_Data := "0111110"; -- Error 'H'
		end case;
		
		-- Sender tallet valgt til displayet
		-- Husk at på dette display betyder 0 = tændt og 1 = slukket Derfor 'NOT'
		segment_A	<=	not Decode_Data(6);
		segment_B	<=	not Decode_Data(5);
		segment_C	<=	not Decode_Data(4);
		segment_D	<=	not Decode_Data(3);
		segment_E	<=	not Decode_Data(2);
		segment_F	<=	not Decode_Data(1);
		segment_G	<=	not Decode_Data(0);
	
	end process;
	
	
	
	
	
	
	
	
	
end rtl;

