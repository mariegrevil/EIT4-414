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

--	Setup DRAM array [7-bit per digit]: 
--				Digit0 = DRAM(0)
--				Digit1 = DRAM(7)
--				Digit2 = DRAM(14)
--				Digit3 = DRAM(21)
--				Digit4 = DRAM(28)
--				Digit5 = DRAM(35)
			
signal DRAM : std_logic_vector (41 downto 0) := (others => '0');
signal Dbuffer : std_logic_vector (6 downto 0) := (others => '0');

begin
-- De 4 dib switches state ligges i Digit arrayet
Digit(0) <= switch0;
Digit(1) <= switch1;
Digit(2) <= switch2;
Digit(3) <= switch3;

	process(DRAM, Dbuffer)
	-- Update Display:

	begin
		-- Fill cifer 0:
		DRAM(0) <= Dbuffer(0);
		DRAM(1) <= Dbuffer(1);
		DRAM(2) <= Dbuffer(2);
		DRAM(3) <= Dbuffer(3);
		DRAM(4) <= Dbuffer(4);
		DRAM(5) <= Dbuffer(5);
		DRAM(6) <= Dbuffer(6);
	
		-- Sender tallet valgt til fra disp4 til disp5
		segment5_A <= not DRAM(41);
		segment5_B <= not DRAM(40);
		segment5_C <= not DRAM(39);
		segment5_D <= not DRAM(38);
		segment5_E <= not DRAM(37);
		segment5_F <= not DRAM(36);
		segment5_G <= not DRAM(35);

		-- Sender tallet valgt til fra disp3 til disp4
		segment4_A <= not DRAM(34);
		segment4_B <= not DRAM(33);
		segment4_C <= not DRAM(32);
		segment4_D <= not DRAM(31);
		segment4_E <= not DRAM(30);
		segment4_F <= not DRAM(29);
		segment4_G <= not DRAM(28);

		-- Sender tallet valgt til fra disp2 til disp3
		segment3_A <= not DRAM(27);
		segment3_B <= not DRAM(26);
		segment3_C <= not DRAM(25);
		segment3_D <= not DRAM(24);
		segment3_E <= not DRAM(23);
		segment3_F <= not DRAM(22);
		segment3_G <= not DRAM(21);

		-- Sender tallet valgt til fra disp1 til disp2
		segment2_A <= not DRAM(20);
		segment2_B <= not DRAM(19);
		segment2_C <= not DRAM(18);
		segment2_D <= not DRAM(17);
		segment2_E <= not DRAM(16);
		segment2_F <= not DRAM(15);
		segment2_G <= not DRAM(14);


		-- Sender tallet valgt til fra disp0 til disp1
		segment1_A <= not DRAM(13);
		segment1_B <= not DRAM(12);
		segment1_C <= not DRAM(11);
		segment1_D <= not DRAM(10);
		segment1_E <= not DRAM(9);
		segment1_F <= not DRAM(8);
		segment1_G <= not DRAM(7);
		
		-- Update cifer 0 fra DRAM
		segment0_A <= not DRAM(6);
		segment0_B <= not DRAM(5);
		segment0_C <= not DRAM(4);
		segment0_D <= not DRAM(3);
		segment0_E <= not DRAM(2);
		segment0_F <= not DRAM(1);
		segment0_G <= not DRAM(0);
		
	
	end process;

	
	process(Digit, Dbuffer)
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
				when "1010" => Decode_Data := "1110111"; -- A
				when "1011" => Decode_Data := "0011111"; -- B
				when "1100" => Decode_Data := "1001110"; -- C
				when "1101" => Decode_Data := "0111101"; -- D
				when "1110" => Decode_Data := "1001111"; -- E
				when "1111" => Decode_Data := "1000111"; -- F
				when others => Decode_Data := "0110111"; -- Error 'H'
			end case;
			
			-- Sender tallet valgt til DRAM:
			Dbuffer(6)	<=	  Decode_Data(6);
			Dbuffer(5)	<=	  Decode_Data(5);
			Dbuffer(4)	<=	  Decode_Data(4);
			Dbuffer(3)	<=	  Decode_Data(3);
			Dbuffer(2)	<=	  Decode_Data(2);
			Dbuffer(1)	<=	  Decode_Data(1);
			Dbuffer(0)	<=	  Decode_Data(0);
				
	end process;

	process(shift_btn) -- processen kører hvis shift_bnt state ændre sig
		begin
	
		if (shift_btn = '1') then --if hvis knappen trykkes
		--flyt tallet til næste plads
		
			for i in 7 downto 1 loop
				for i in 41 downto 1 loop
					DRAM(i) <= DRAM(i-1);
					
				end loop;
			end loop;
						
		end if;
	end process;
		
		
		
end rtl;

