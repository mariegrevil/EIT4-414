library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ProgramCode is
    port (TinyClock  : in std_logic;
          DataBusProgram: out std_logic_vector(31 downto 0);
		  AddrBusProgram:	in std_logic_vector(7 downto 0));
end  ProgramCode;

architecture rtl of Programcode is

    type ProMem_type is array (255 downto 0) of std_logic_vector (31 downto 0);
    signal ProMem: ProMem_type := (others => x"00000000");
	
begin

				--	  OPCODE	AddrReg		AddrMemIn	EnRamIn	AddrMemOut	EnRamOut
		ProMem(0) <= "000000"&	"00000001"&	"00000011"&	"1"&	"00000111"&	"0";
		ProMem(1) <= "000001"&	"00000011"&	"00000111"&	"1"&	"00001111"&	"0";
		ProMem(2) <= "000010"&	"00000111"&	"00001111"&	"1"&	"00011111"&	"0";
		--ProMem(3) <= "0000 0 0011  0100  1000";
	
	process (TinyClock)
    begin
        if rising_edge(TinyClock) then
            
			
			DataBusProgram <= ProMem(conv_integer(AddrBusProgram));  
            
        end if;
    end process;

end rtl;
