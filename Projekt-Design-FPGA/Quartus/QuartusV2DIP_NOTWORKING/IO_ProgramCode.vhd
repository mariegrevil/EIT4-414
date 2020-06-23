library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity IO_ProgramCode is
    port (TinyClock  : in std_logic;
          IO_DataBusProgram: out std_logic_vector(31 downto 0); -- Data on the chosen addres
		  IO_AddrBusProgram:	in std_logic_vector(7 downto 0); -- The addres that the CU wants to load
		  ClockCycle 	: in std_logic_vector(2 downto 0)); -- Counts rising edges in tinyclock per hugeclock
end  IO_ProgramCode;

architecture rtl of IO_Programcode is

    type ProMem_type is array (255 downto 0) of std_logic_vector (31 downto 0); -- Declare a data type. here an array with 255 locations of 32 bits
    signal IO_ProMem: ProMem_type := (others => x"00000000"); -- A signal of type "ProMem_type". All values are preconfigured to 0
	
begin
-- ActionJackson-værdier:
-- 17 er plus+facit
-- 9 er minus+facit
-- 5 er gange+facit
-- 3 er divider+facit

-- MARK start at ProMem(0)
IO_ProMem(0) <= "11000000001110000000000000000001"; -- VAL1 R28
IO_ProMem(1) <= "11001000001110100000000000000001"; -- VAL2 R29
IO_ProMem(2) <= "11011000001111100000000000000001"; -- AJ R31
IO_ProMem(3) <= "00001000000000011101100000000001"; -- TBR R27
IO_ProMem(4) <= "11010000000000011111000000000001"; -- ANS R30
IO_ProMem(5) <= "10110000000000010000000000000001"; -- GOTO start


		
			
	process (TinyClock)
    begin
	if Clockcycle = "001" then 
        if rising_edge(TinyClock) then
            
			IO_DataBusProgram <= IO_ProMem(conv_integer(IO_AddrBusProgram));  --Put the location pointet to by the "AddrBusProgram" on to "DataBusProgram"
            
        end if;
	end if;
    end process;

end rtl;