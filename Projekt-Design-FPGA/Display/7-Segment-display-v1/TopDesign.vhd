-- TopDesign [By Johnni :D]

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
--use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity TopDesign is
	--setup:
	port	(	
				switch0	:	in std_logic;
				switch1	:	in std_logic;
				switch2	:	in std_logic;
				switch3	:	in std_logic;
				
				shift_btn : in std_logic;
				
			
				-- cifer 0:
				segment0_A	:	buffer	std_logic;
				segment0_B	:	buffer	std_logic;
				segment0_C	:	buffer	std_logic;
				segment0_D	:	buffer	std_logic;
				segment0_E	:	buffer	std_logic;
				segment0_F	:	buffer	std_logic;
				segment0_G	:	buffer	std_logic;
				
				-- cifer 1:
				segment1_A	:	buffer	std_logic;
				segment1_B	:	buffer	std_logic;
				segment1_C	:	buffer	std_logic;
				segment1_D	:	buffer	std_logic;
				segment1_E	:	buffer	std_logic;
				segment1_F	:	buffer	std_logic;
				segment1_G	:	buffer	std_logic;
				
				-- cifer 2:
				segment2_A	:	buffer	std_logic;
				segment2_B	:	buffer	std_logic;
				segment2_C	:	buffer	std_logic;
				segment2_D	:	buffer	std_logic;
				segment2_E	:	buffer	std_logic;
				segment2_F	:	buffer	std_logic;
				segment2_G	:	buffer	std_logic;
				
				-- cifer 3:
				segment3_A	:	buffer	std_logic;
				segment3_B	:	buffer	std_logic;
				segment3_C	:	buffer	std_logic;
				segment3_D	:	buffer	std_logic;
				segment3_E	:	buffer	std_logic;
				segment3_F	:	buffer	std_logic;
				segment3_G	:	buffer	std_logic;
			
				
				-- cifer 4:
				segment4_A	:	buffer	std_logic;
				segment4_B	:	buffer	std_logic;
				segment4_C	:	buffer	std_logic;
				segment4_D	:	buffer	std_logic;
				segment4_E	:	buffer	std_logic;
				segment4_F	:	buffer	std_logic;
				segment4_G	:	buffer	std_logic;
			
				
				-- cifer 5:
				segment5_A	:	buffer	std_logic;
				segment5_B	:	buffer	std_logic;
				segment5_C	:	buffer	std_logic;
				segment5_D	:	buffer	std_logic;
				segment5_E	:	buffer	std_logic;
				segment5_F	:	buffer	std_logic;
				segment5_G	:	buffer	std_logic				

				);
				
				
end TopDesign;


architecture rtl of TopDesign is

signal Digit :	std_logic_vector	(3	downto 0) := (others => '0');

begin

	-- De 4 dib switches state ligges i Digit arrayet
	Digit(0) <= switch0;
	Digit(1) <= switch1;
	Digit(2) <= switch2;
	Digit(3) <= switch3;
	
	process(Digit)
		variable Decode_Data : std_logic_vector(6 downto 0); -- Her declares et 7 bit array for hvilke linjer i displaytallet som skal tændes
	
		begin
		
		-- Her "tegnes" tallene 0-9 på displayet, se board manualen sektion 3.3
		case Digit is
			when "0000" => Decode_Data := "1111110"; -- 0
			when "0001" => Decode_Data := "0110000"; -- 1
			when "0010" => Decode_Data := "1101101"; -- 2
			when "0011" => Decode_Data := "1111001"; -- 3
			when "0100" => Decode_Data := "0110011"; -- 4
			when "0101" => Decode_Data := "1011011"; -- 5
			when "0110" => Decode_Data := "1011111"; -- 6
			when "0111" => Decode_Data := "1110000"; -- 7
			when "1000" => Decode_Data := "1111111"; -- 8
			when "1001" => Decode_Data := "1111011"; -- 9
			when "1111" => Decode_Data := "0000000"; -- TOM felt (til test)
			when others => Decode_Data := "0111110"; -- Error 'U'
		end case;
		
		-- Sender tallet valgt til display 0
		segment0_A	<=	 not Decode_Data(6);
		segment0_B	<=	 not Decode_Data(5);
		segment0_C	<=	 not Decode_Data(4);
		segment0_D	<=	 not Decode_Data(3);
		segment0_E	<=	 not Decode_Data(2);
		segment0_F	<=	 not Decode_Data(1);
		segment0_G	<=	 not Decode_Data(0);
	
	end process;

	process(shift_btn) -- processen kører hvis shift_bnt state ændre sig
	begin
	
	if (shift_btn = '1') then --if hvis knappen trykkes
	--flyt tallet til næste plads
		
		-- Sender tallet valgt til fra disp4 til disp5
		segment5_A <= segment4_A;
		segment5_B <= segment4_B;
		segment5_C <= segment4_C;
		segment5_D <= segment4_D;
		segment5_E <= segment4_E;
		segment5_F <= segment4_F;
		segment5_G <= segment4_G;
	
		-- Sender tallet valgt til fra disp3 til disp4
		segment4_A <= segment3_A;
		segment4_B <= segment3_B;
		segment4_C <= segment3_C;
		segment4_D <= segment3_D;
		segment4_E <= segment3_E;
		segment4_F <= segment3_F;
		segment4_G <= segment3_G;
	
		-- Sender tallet valgt til fra disp2 til disp3
		segment3_A <= segment2_A;
		segment3_B <= segment2_B;
		segment3_C <= segment2_C;
		segment3_D <= segment2_D;
		segment3_E <= segment2_E;
		segment3_F <= segment2_F;
		segment3_G <= segment2_G;
	
		-- Sender tallet valgt til fra disp1 til disp2
		segment2_A <= segment1_A;
		segment2_B <= segment1_B;
		segment2_C <= segment1_C;
		segment2_D <= segment1_D;
		segment2_E <= segment1_E;
		segment2_F <= segment1_F;
		segment2_G <= segment1_G;
	
	
		-- Sender tallet valgt til fra disp0 til disp1
		segment1_A <= segment0_A;
		segment1_B <= segment0_B;
		segment1_C <= segment0_C;
		segment1_D <= segment0_D;
		segment1_E <= segment0_E;
		segment1_F <= segment0_F;
		segment1_G <= segment0_G;
		
		
		end if;
	end process;
		
		
		
end rtl;

