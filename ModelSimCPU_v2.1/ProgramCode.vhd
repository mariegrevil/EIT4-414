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
--Here it is hard coded what we want the program to do
				--	  OPCODE(5) AddrMemOut(10)	EnRamOut	AddrReg(5)		AddrMemIn(10)	EnRamIn	
		ProMem(0) <= "00000"& 	"0000000000"&	"0"&		"00000"&		"0000000000"&	"0"; -- NOP
		ProMem(1) <= "00000"& 	"0000000000"&	"0"&		"00000"&		"0000000000"&	"0"; -- NOP
		ProMem(2) <= "11001"& 	"0000011111"&	"0"&		"00111"&		"0000001111"&	"1"; -- NUMPAD7 R31
		ProMem(3) <= "11001"& 	"0000011110"&	"0"&		"00111"&		"0000001111"&	"1"; -- NUMPAD7 R30
		ProMem(4) <= "00101"& 	"0000010101"&	"0"&		"00000"&		"0001100100"&	"1"; -- SET R21, 100
		ProMem(5) <= "01010"& 	"0000011011"&	"0"&		"11110"&		"0000011111"&	"0"; -- ADD R27,R31,R30
		ProMem(6) <= "01100"& 	"0000011101"&	"0"&		"11011"&		"0000011110"&	"0"; -- SUB R29, R27, R30
		ProMem(7) <= "01111"& 	"0000011001"& 	"0"&		"11111"&		"0000011110"& 	"0"; -- DIV R25, R31, R30
		ProMem(8) <= "01110"& 	"0000011000"& 	"0"&		"11111"&		"0000011110"& 	"0"; -- MULT R24, R31, R30
		ProMem(9) <= "00000"& 	"0000000000"&	"0"&		"00000"&		"0000000000"&	"0"; -- NOP
		ProMem(10) <= "01010"& 	"0000010110"&	"0"&		"11011"&		"0000011001"&	"0"; -- ADD R22,R27,R25
		ProMem(11) <= "00011"& 	"0000110001"&	"1"&		"00000"&		"0000011000"&	"0"; -- STORE M49, R24
		ProMem(12) <= "00001"& 	"0000010111"&	"0"&		"00000"&		"0000110001"&	"1"; -- LOAD R23, M49
		ProMem(13) <= "00101"& 	"0000010100"&	"0"&		"00000"&		"1111111111"&	"1"; -- SET R20, b1111.1111
		ProMem(14) <= "00101"& 	"0000010011"&	"0"&		"00000"&		"0000000000"&	"1"; -- SET R19, b0000.0000
		ProMem(15) <= "10000"& 	"0000010010"&	"0"&		"10100"&		"0000010011"&	"0"; -- AND R18, R20, R19
		ProMem(16) <= "10001"& 	"0000010001"&	"0"&		"10100"&		"0000010100"&	"0"; -- OR R17, R20, R20
		ProMem(17) <= "10010"& 	"0000010000"&	"0"&		"00000"&		"0000010011"&	"0"; -- NOT R16, R19
		ProMem(18) <= "10011"& 	"0000001111"&	"0"&		"10100"&		"0000010100"&	"0"; -- XOR R15, R20, R20
		ProMem(19) <= "01011"& 	"0000011011"&	"0"&		"11110"&		"0000000100"&	"0"; -- ADDX R27,R30, 4
		ProMem(20) <= "01101"& 	"0000011101"&	"0"&		"11110"&		"0000000100"&	"0"; -- SUBX R29, R30, 4
		ProMem(21) <= "00110"& 	"0000001110"&	"0"&		"11101"&		"0000011011"&	"0"; -- LT R14, R29, R27
		ProMem(22) <= "00110"& 	"0000001110"&	"0"&		"11011"&		"0000011101"&	"0"; -- LT R14, R27, R29
		ProMem(23) <= "00111"& 	"0000001110"&	"0"&		"11000"&		"0000010111"&	"0"; -- EQ R14, R24, R23
		ProMem(24) <= "00111"& 	"0000001110"&	"0"&		"11011"&		"0000010111"&	"0"; -- EQ R14, R27, R23
		
		
		--ProMem(14) <= "10111"& 	"0000000000"&	"0"&		"00000"&		"0000001010"&	"0"; -- JMP 10
		
--ProMem(6) <= "10101"& 	"0000011100"& 	"0"&		"11110"& 		"0000000000"& 	"0"; -- Shift left reg 30 ligger over i reg 28
--ProMem(7) <= "10100"& 	"0000011010"& 	"0"&		"11111"&		"0000000000"& 	"0"; -- Shift reg 31 right, ligger over i reg 26		
	process (TinyClock)
    begin
	if Clockcycle = "001" then 
        if rising_edge(TinyClock) then
            
			DataBusProgram <= ProMem(conv_integer(AddrBusProgram));  --Put the location pointet to by the "AddrBusProgram" on to "DataBusProgram"
            
        end if;
	end if;
    end process;

end rtl;
