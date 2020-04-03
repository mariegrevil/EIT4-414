library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Ram1 is
    port (CLK  : in std_logic;
		AddrBusD  :	in std_logic_vector(7 downto 0); -- Addr bus to ram and reg
		EnRam	  : in std_logic;
		AddrBusD2 : in std_logic_vector(7 downto 0);
		EnRam2    : in std_logic;
		DataBusD  : out std_logic_vector(7 downto 0);
		DataBusD2  : in std_logic_vector(7 downto 0));
end  Ram1;

architecture rtl of Ram1 is

    type reg_type is array (15 downto 0) of std_logic_vector (7 downto 0);
    signal REG: reg_type;
	
begin

    process (CLK)
    begin
        if rising_edge(CLK) then
            if ENREG = '1' then
                if WEREG = '1' then
                   (conv_integer(ADDR)) <= CBus;
                end if;
                BBus <= RAM(conv_integer(ADDR)) ;
            end if;
        end if;
    end process;

end rtl;
