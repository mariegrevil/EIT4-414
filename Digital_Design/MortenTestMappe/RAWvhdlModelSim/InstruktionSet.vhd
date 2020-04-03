library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity InstruktionSet is
    port (CLK  : in std_logic;
          DataBusB: out std_logic_vector(7 downto 0);
		  AddrBusB:	in std_logic_vector(5 downto 0));
end  InstruktionSet;

architecture rtl of InstruktionSet is

    type ProMem_type is array (3 downto 0) of std_logic_vector (16 downto 0);
    signal ProMem: ProMem_type;
	
begin

    process
	begin
				--	  ADDR J B-Bus C-Bus ALU
		ProMem(0) <= "0000 0 0000  0001  1000";
		ProMem(1) <= "0000 0 0001  0010  1000";
		ProMem(2) <= "0000 0 0010  0011  1000";
		ProMem(3) <= "0000 0 0011  0100  1000";
		
	end process
	
	process (CLK)
    begin
        if rising_edge(CLK) then
            if EN = '1' then
               
              CUBus <= ProMem(conv_integer(ADDR));
			  
            end if;
        end if;
    end process;

end rtl;
