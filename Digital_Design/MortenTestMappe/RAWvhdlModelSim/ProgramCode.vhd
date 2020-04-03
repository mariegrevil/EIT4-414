library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ProgramCode is
    port (CLK  : in std_logic;
          DataBusA: out std_logic_vector(31 downto 0);
		  AddrBusA:	in std_logic_vector(7 downto 0));
end  ProgramCode;

architecture rtl of Programcode is

    type ProMem_type is array (255 downto 0) of std_logic_vector (31 downto 0);
    signal ProMem: ProMem_type;
	
begin

				--	  OPCODE AddrC	  	AddrD    ENRam	AddrD2 	 EnRam2
		ProMem(0) <= "00000000000001000000111000001110";
		ProMem(1) <= "00000100000011000001111000011110";
		--ProMem(2) <= "0000 0 0010  0011  1000";
		--ProMem(3) <= "0000 0 0011  0100  1000";
	
	process (CLK)
    begin
        if rising_edge(CLK) then
            
			
			DataBusA <= ProMem(conv_integer(AddrBusA));  
            
        end if;
    end process;

end rtl;
