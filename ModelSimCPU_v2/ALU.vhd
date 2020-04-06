library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ALU is
    port (TinyClock		: in std_logic;
		ClockCycle		: in std_logic_vector(2 downto 0);
		ConBusALU		: in std_logic_vector(3 downto 0); --Control bus for ALU. Tels it what to do. Comes from CU
		
		DataBusMemInput	: in std_logic_vector(7 downto 0); --Data form ram or reg.
		DataBusReg		: in std_logic_vector(7 downto 0); --Data for reg
		
		DataBusMemOutput: out std_logic_vector(7 downto 0) := x"00"; -- Data to reg or ram
		
		NumpadReg		: in std_logic_vector(7 downto 0)); --Data from numpad
end  ALU;

architecture rtl of ALU is

    
begin

	process (TinyClock)
    begin
	
		case ConBusALU is
			when "0010" => -- Transfor Numpad value to reg or ram
				if ClockCycle = "101" then
					DataBusMemOutput <= NumpadReg;
				end if;
			when others => --When ther are no matches in the switch case
				report "ConBus ikke defineret";
		end case;
    end process;

end rtl;
