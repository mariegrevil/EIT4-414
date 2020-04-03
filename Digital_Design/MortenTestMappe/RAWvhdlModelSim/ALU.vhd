library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ALU is
    port (CLK   : in std_logic;
		ConBusA   : in std_logic_vector(3 downto 0)
		DataBusD  : in std_logic_vector(7 downto 0);
		DataBusC  : in std_logic_vector(7 downto 0);
		DataBusD2 : out std_logic_vector(7 downto 0));
end  ALU;

architecture rtl of ALU is

    
begin

	process (CLK)
    begin
        if rising_edge(CLK) then
            case F is
				when "00" =>
				if ENB = '1' then CBus <= BBus;
			
				when others => --Other then named cases
				CBus <= (others => 'X');
			end case;
        end if;
    end process;

end rtl;
