library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ProgramCode is
    port (TinyClock  : in std_logic;
          DataBusProgram: out std_logic_vector(31 downto 0); -- Data on the chosen addres
		  AddrBusProgram:	in std_logic_vector(7 downto 0); -- The addres that the CU wants to load
		  ClockCycle 	: in std_logic_vector(2 downto 0)); -- Counts rising edges in tinyclock per hugeclock
end  ProgramCode;

architecture rtl of Programcode is

    type ProMem_type is array (255 downto 0) of std_logic_vector (31 downto 0); -- Declare a data type. here an array with 255 locations of 32 bits
    signal ProMem: ProMem_type := (others => x"00000000"); -- A signal of type "ProMem_type". All values are preconfigured to 0
	
begin
-- ActionJackson-værdier:
-- 17 er plus+facit
-- 9 er minus+facit
-- 5 er gange+facit
-- 3 er divider+facit

-- MARK start at ProMem(0)
ProMem(0) <= "11011000001111100000000000000001"; -- AJ R31
ProMem(1) <= "01001000000000011111100000100011"; -- BNEQ R31 17
ProMem(2) <= "10110000000000010000000000010101"; -- GOTO plus
ProMem(3) <= "01001000000000011111100000010011"; -- BNEQ R31 9
ProMem(4) <= "10110000000000010000000000011111"; -- GOTO minus
ProMem(5) <= "01001000000000011111100000001011"; -- BNEQ R31 5
ProMem(6) <= "10110000000000010000000000101001"; -- GOTO gange
ProMem(7) <= "01001000000000011111100000000111"; -- BNEQ R31 3
ProMem(8) <= "10110000000000010000000000110011"; -- GOTO divider
ProMem(9) <= "10110000000000010000000000000001"; -- GOTO start
-- MARK plus at ProMem(10)
ProMem(10) <= "11000000001110000000000000000001"; -- VAL1 R28
ProMem(11) <= "11001000001110100000000000000001"; -- VAL2 R29
ProMem(12) <= "01010000001111001110000000111010"; -- ADD R30 R28 R29
ProMem(13) <= "11010000000000011111000000000001"; -- ANS R30
ProMem(14) <= "10110000000000010000000000111101"; -- GOTO clear
-- MARK minus at ProMem(15)
ProMem(15) <= "11000000001110000000000000000001"; -- VAL1 R28
ProMem(16) <= "11001000001110100000000000000001"; -- VAL2 R29
ProMem(17) <= "01100000001111001110000000111010"; -- SUB R30 R28 R29
ProMem(18) <= "11010000000000011111000000000001"; -- ANS R30
ProMem(19) <= "10110000000000010000000000111101"; -- GOTO clear
-- MARK gange at ProMem(20)
ProMem(20) <= "11000000001110000000000000000001"; -- VAL1 R28
ProMem(21) <= "11001000001110100000000000000001"; -- VAL2 R29
ProMem(22) <= "01110000001111001110000000111010"; -- MULT R30 R28 R29
ProMem(23) <= "11010000000000011111000000000001"; -- ANS R30
ProMem(24) <= "10110000000000010000000000111101"; -- GOTO clear
-- MARK divider at ProMem(25)
ProMem(25) <= "11000000001110000000000000000001"; -- VAL1 R28
ProMem(26) <= "11001000001110100000000000000001"; -- VAL2 R29
ProMem(27) <= "01111000001111001110000000111010"; -- DIV R30 R28 R29
ProMem(28) <= "11010000000000011111000000000001"; -- ANS R30
ProMem(29) <= "10110000000000010000000000111101"; -- GOTO clear
-- MARK clear at ProMem(30)
ProMem(30) <= "11011000001111100000000000000001"; -- AJ R31
ProMem(31) <= "01000000000000011111100001000001"; -- BEQ R31 32
ProMem(32) <= "10111000000000010000000000000101"; -- JMPX 2
ProMem(33) <= "00101000001111000000000000000001"; -- SET R30 0
ProMem(34) <= "11010000000000011111000000000001"; -- ANS R30
ProMem(35) <= "10110000000000010000000000000001"; -- GOTO start


--Here it is hard coded what we want the program to do
				--	  OPCODE(5) AddrMemOut(10)	EnRamOut	AddrReg(5)		AddrMemIn(10)	EnRamIn	
		
		-- ProMem(0) <= "UUUUU"& 	"UUUUUUUUUU"&	"U"&		"UUUUU"&		"UUUUUUUUUU"&	"U"; -- NOP
		-- ProMem(1) <= "00101"& 	"0000000001"&	"0"&		"UUUUU"&		"UU00001010"&	"U"; -- SET R1, 10
		-- ProMem(2) <= "00101"& 	"0000011111"&	"0"&		"UUUUU"&		"UU00001111"&	"U"; -- SET R31, 15
		-- ProMem(3) <= "00101"& 	"0000000010"&	"0"&		"UUUUU"&		"UU11110110"&	"U"; -- SET R2, -10
		-- ProMem(4) <= "00101"& 	"0000000011"&	"0"&		"UUUUU"&		"UU00000101"&	"U"; -- SET R3, 5
		-- ProMem(5) <= "00101"& 	"0000000100"&	"0"&		"UUUUU"&		"UU11111011"&	"U"; -- SET R4, -5
		-- ProMem(6) <= "01011"& 	"0000000101"&	"0"&		"00011"&		"UU11100010"&	"U"; -- ADDX R5, R3, -30
		-- ProMem(7) <= "01010"& 	"0000000101"&	"0"&		"00001"&		"0000000010"&	"0"; -- ADD R5, R1, R2
		-- ProMem(8) <= "01101"& 	"0000000110"&	"0"&		"00001"&		"UU00011110"&	"U"; -- SUBX R6, R1, 30
		-- ProMem(9) <= "01111"& 	"0000000111"& 	"0"&		"00001"&		"0000000100"& 	"0"; -- DIV R7, R1, R4
		-- ProMem(10) <= "01110"& 	"0000001000"& 	"0"&		"00010"&		"0000000011"& 	"0"; -- MULT R8, R2, R3
		-- ProMem(11) <= "00101"& 	"0000011110"&	"0"&		"UUUUU"&		"UU11110001"&	"U"; -- SET R30, -15
		-- ProMem(12) <= "00101"& 	"0000011101"&	"0"&		"UUUUU"&		"UU00000111"&	"U"; -- SET R29, 7
		-- ProMem(13) <= "00101"& 	"0000011100"&	"0"&		"UUUUU"&		"UU11111001"&	"U"; -- SET R28, -7
		-- ProMem(14) <= "01110"& 	"0000001001"& 	"0"&		"00100"&		"0000000010"& 	"0"; -- MULT R9, R4, R2 -> 50
		-- ProMem(15) <= "01110"& 	"0000001001"& 	"0"&		"11111"&		"0000000001"& 	"0"; -- MULT R9, R31, R1 -> 150
		-- ProMem(16) <= "01110"& 	"0000001001"& 	"0"&		"11111"&		"0000000010"& 	"0"; -- MULT R9, R31, R2 -> -150
		-- ProMem(17) <= "01111"& 	"0000001010"& 	"0"&		"11110"&		"0000000100"& 	"0"; -- DIV R10, R30, R4 -> -15/-5
		-- ProMem(18) <= "01111"& 	"0000001010"& 	"0"&		"11110"&		"0000011101"& 	"0"; -- DIV R10, R30, R29 -> -15/7
		-- ProMem(19) <= "01111"& 	"0000001010"& 	"0"&		"00001"&		"0000010010"& 	"0"; -- DIV R10, R1, R18 -> 10/0
		-- ProMem(20) <= "01110"& 	"0000001001"& 	"0"&		"01000"&		"0000001000"& 	"0"; -- MULT R9, R8, R8 -> -50*-50
		-- ProMem(21) <= "00110"& 	"0000001011"&	"0"&		"00100"&		"0000000001"&	"0"; -- LT R11, R4, R1 -> -5<10
		-- ProMem(22) <= "00111"& 	"0000001100"&	"0"&		"01010"&		"0000010010"&	"0"; -- EQ R12, R10, R18 -> 0=0
		-- ProMem(23) <= "01001"& 	"UUUUUUUUUU"&	"U"&		"11110"&		"UU11111001"&	"U"; -- BNEQ R30, -7
		-- ProMem(24) <= "00110"& 	"0000001011"&	"0"&		"00011"&		"0000011100"&	"0"; -- LT R11, R3, R28 -> 5<-7
		-- ProMem(25) <= "00101"& 	"0000010100"&	"0"&		"UUUUU"&		"UU11111111"&	"U"; -- SET R20, b1111.1111
		-- ProMem(26) <= "00101"& 	"0000010011"&	"0"&		"UUUUU"&		"UU00000000"&	"U"; -- SET R19, b0000.0000
		-- ProMem(27) <= "10000"& 	"0000010010"&	"0"&		"10100"&		"0000010011"&	"0"; -- AND R18, R20, R19
		-- ProMem(28) <= "10001"& 	"0000010001"&	"0"&		"10100"&		"0000010100"&	"0"; -- OR R17, R20, R20
		-- ProMem(29) <= "10010"& 	"0000010000"&	"0"&		"UUUUU"&		"0000010011"&	"0"; -- NOT R16, R19
		-- ProMem(30) <= "10011"& 	"0000001111"&	"0"&		"10100"&		"0000010100"&	"0"; -- XOR R15, R20, R20
		-- ProMem(31) <= "00011"& 	"1111111111"&	"1"&		"01000"&		"UUUUUUUUUU"&	"U"; -- STORE M1023, R8
		-- ProMem(32) <= "00001"& 	"0000001110"&	"0"&		"UUUUU"&		"1111111111"&	"1"; -- LOAD R14, M1023
		-- ProMem(33) <= "10111"& 	"UUUUUUUUUU"&	"U"&		"UUUUU"&		"0000001101"&	"U"; -- JMPX 13
		
		
			
	process (TinyClock)
    begin
	if Clockcycle = "001" then 
        if rising_edge(TinyClock) then
            
			DataBusProgram <= ProMem(conv_integer(AddrBusProgram));  --Put the location pointet to by the "AddrBusProgram" on to "DataBusProgram"
            
        end if;
	end if;
    end process;

end rtl;
