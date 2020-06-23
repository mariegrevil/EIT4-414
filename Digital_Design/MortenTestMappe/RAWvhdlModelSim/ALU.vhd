library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ALU is
    port (TinyClock		: in std_logic;
		ConBusALU		: in std_logic_vector(3 downto 0);
		
		DataBusMemInput	: in std_logic_vector(7 downto 0);
		DataBusReg		: in std_logic_vector(7 downto 0);
		
		DataBusMemOutput: out std_logic_vector(7 downto 0) := x"00";
		
		NumpadReg		: in std_logic_vector(7 downto 0));
end  ALU;

architecture rtl of ALU is

    
begin

	process (ConBusALU)
    begin
	
		case ConBusALU is
			when "0010" =>
				DataBusMemOutput <= NumpadReg;
			when others =>
				report "ConBus ikke defineret";
		end case;
        --if rising_edge(TinyClock) then
        --    case F is
		--		when "00" =>
		--		if ENB = '1' then CBus <= BBus;
		--	
		--		when others => --Other then named cases
		--		CBus <= (others => 'X');
		--	end case;
        --end if;
    end process;

end rtl;
