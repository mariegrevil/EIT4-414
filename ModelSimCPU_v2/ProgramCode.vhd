library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ProgramCode is
    port (TinyClock  : in std_logic;
          DataBusProgram: out std_logic_vector(31 downto 0); -- Data on the chosen addres
		  AddrBusProgram: in std_logic_vector(7 downto 0)); -- The addres that the CU wants to load
end  ProgramCode;

architecture rtl of Programcode is

    type ProMem_type is array (255 downto 0) of std_logic_vector (31 downto 0); -- Declare a data type. here an array with 255 locations of 32 bits
    signal ProMem : ProMem_type := (others => x"00000000"); -- A signal of type "ProMem_type". All values are preconfigured to 0
	
begin
--Here it is hard coded what we want the program to do
				--	  OPCODE	 AddrReg	  AddrMemIn    EnRamIn	AddrMemOut	EnRamOut
		ProMem(0) <=  "000000"&	 "00000001"&  "00000011"&  "1"&	    "00000111"&	"0"; -- NOP
		ProMem(1) <=  "000001"&	 "00000000"&  "00000000"&  "1"&	    "00010111"&	"0"; -- LOAD from RAM(0) to REG(23)
		ProMem(2) <=  "000010"&	 "00000000"&  "00000000"&  "0"&	    "00000001"&	"1"; -- STORE from REG(0) to RAM(1)
		
		
		--ProMem(3) <=  "000011"&	 "00000111"&  "00001111"&  "1"&	    "00011111"&	"0"; -- Ligger numpad 7 over i reg 31
		--ProMem(4) <=  "000011"&	 "00000111"&  "00001111"&  "1"&	    "00011110"&	"0"; -- 7 over i reg 30
		--ProMem(5) <=  "000100"&  "00011110"&  "00011111"&  "0"&	    "00011011"&	"0"; -- reg 31 plus reg 30 => reg 27
		--ProMem(6) <=  "000101"&	 "00011110"&  "00011011"&  "0"&	    "00011101"&	"0"; -- reg 27 minus reg 30 => reg 29
		--ProMem(7) <=  "000110"&  "00011110"&  "00000000"&  "0"&	    "00011100"& "0"; -- Shift left reg 30 ligger over i reg 28
		--ProMem(8) <=  "000111"&  "00011111"&  "00000000"&  "0"&     "00011010"& "0"; -- Shift reg 31 right, ligger over i reg 26
		--ProMem(9) <=  "001000"&  "00011111"&  "00011110"&  "0"&     "00011001"& "0"; -- Divider reg 31 med reg 30 => reg 25
		--ProMem(10) <= "001001"&  "00011111"&  "00011010"&  "0"&     "00011000"& "0"; -- Ganger reg 31 med reg 26 => reg 24
		
	process (TinyClock)
    begin
        if rising_edge(TinyClock) then
            
			DataBusProgram <= ProMem(conv_integer(AddrBusProgram));  --Put the location pointet to by the "AddrBusProgram" on to "DataBusProgram"
            
        end if;
    end process;

end rtl;
