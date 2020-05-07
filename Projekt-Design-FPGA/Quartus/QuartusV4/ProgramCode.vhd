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

ProMem(0) <= "00101000001111000000000000000001"; -- SET 30 REG 0
ProMem(1) <= "00101000001101100000000000000001"; -- SET 27 REG 0
-- MARK start at ProMem(2)
ProMem(2) <= "01001000000000011111100000100011"; -- BNEQ 31 17
ProMem(3) <= "10110000000000010000000000010111"; -- GOTO plus
ProMem(4) <= "01001000000000011111100000010011"; -- BNEQ 31 9
ProMem(5) <= "10110000000000010000000000011101"; -- GOTO minus
ProMem(6) <= "01001000000000011111100000001011"; -- BNEQ 31 5
ProMem(7) <= "10110000000000010000000000100011"; -- GOTO gange
ProMem(8) <= "01001000000000011111100000000111"; -- BNEQ 31 3
ProMem(9) <= "10110000000000010000000000101001"; -- GOTO divider
ProMem(10) <= "10110000000000010000000000000101"; -- GOTO start
-- MARK plus at ProMem(11)
ProMem(11) <= "01010000001111001110000000111010"; -- ADD 30 REG 28 29 REG
ProMem(12) <= "11111000001101100000000000000001"; -- TBR 27 REG 
ProMem(13) <= "10110000000000010000000000101111"; -- GOTO clear
-- MARK minus at ProMem(14)
ProMem(14) <= "01100000001111001110000000111010"; -- SUB 30 REG 28 29 REG
ProMem(15) <= "11111000001101100000000000000001"; -- TBR 27 REG 
ProMem(16) <= "10110000000000010000000000101111"; -- GOTO clear
-- MARK gange at ProMem(17)
ProMem(17) <= "01110000001111001110000000111010"; -- MULT 30 REG 28 29 REG
ProMem(18) <= "11111000001101100000000000000001"; -- TBR 27 REG 
ProMem(19) <= "10110000000000010000000000101111"; -- GOTO clear
-- MARK divider at ProMem(20)
ProMem(20) <= "01111000001111001110000000111010"; -- DIV 30 REG 28 29 REG
ProMem(21) <= "11111000001101100000000000000001"; -- TBR 27 REG 
ProMem(22) <= "10110000000000010000000000101111"; -- GOTO clear
-- MARK clear at ProMem(23)
ProMem(23) <= "01000000000000011111100001000001"; -- BEQ 31 32
ProMem(24) <= "10111000000000010000000000000011"; -- JMPX 1
ProMem(25) <= "00101000001111000000000000000001"; -- SET 30 REG 0
ProMem(26) <= "00101000001101100000000000000001"; -- SET 27 REG 0
ProMem(27) <= "10110000000000010000000000000101"; -- GOTO start

			
	process (TinyClock)
    begin
	if Clockcycle = "001" then 
        if rising_edge(TinyClock) then
            
			DataBusProgram <= ProMem(conv_integer(AddrBusProgram));  --Put the location pointet to by the "AddrBusProgram" on to "DataBusProgram"
            
        end if;
	end if;
    end process;

end rtl;
