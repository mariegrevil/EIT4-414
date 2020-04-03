library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Register1 is
    port (CLK  : in std_logic;
		AddrBusD  :	in std_logic_vector(7 downto 0); -- Addr bus to ram and reg
		EnRam	  : in std_logic;
		AddrBusD2 : in std_logic_vector(7 downto 0);
		EnRam2    : in std_logic;
        AddrBusC  :	in std_logic_vector(7 downto 0);
		DataBusD  : out std_logic_vector(7 downto 0);
		DataBusC  : out std_logic_vector(7 downto 0);
		DataBusD2  : in std_logic_vector(7 downto 0));
end  Register1;

architecture rtl of Register1 is

    type reg_type is array (15 downto 0) of std_logic_vector (7 downto 0);
    signal REG: reg_type;
	
begin

    process (CLK)
    begin
        if rising_edge(CLK) then
            if ENREG = '1' then
                if WEREG = '1' then
                    RAM(conv_integer(ADDR)) <= CBus;
                end if;
                BBus <= RAM(conv_integer(ADDR)) ;
            end if;
        end if;
    end process;

end rtl;
