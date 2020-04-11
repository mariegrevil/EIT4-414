library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ALU is
    port (TinyClock		: in std_logic;
		ClockCycle		: in std_logic_vector(2 downto 0);
		ConBusALU		: in std_logic_vector(3 downto 0); --Control bus for ALU. Tels it what to do. Comes from CU
		
		DataBusMemInput	: in std_logic_vector(7 downto 0); --Data form ram or reg.
		DataBusReg		: in std_logic_vector(7 downto 0); --Data for reg
		
		DataBusMemOutput: out std_logic_vector(7 downto 0) := x"00"; -- Data to reg or ram
		
		--AddrBusMemInput : out std_logic_vector(7 downto 0);
		--AddrBusMemOutput: out std_logic_vector(7 downto 0);
		
		NumpadReg		: in std_logic_vector(7 downto 0)); --Data from numpad
end  ALU;

architecture rtl of ALU is

	signal shift_holder : unsigned(7 downto 0); --Bruges til shift funktion, da den skal have en unsigned vektor 
	signal divideReg : unsigned(7 downto 0); --Bruges som placeholder til division af to registre
	signal multiReg : std_logic_vector(15 downto 0); --Placeholder til multiplikation af to registre
    
begin

	process (TinyClock)
    begin
		if ClockCycle = "101" then
			case ConBusALU is
				when "0001" => -- Load from RAM to REG
				DataBusMemOutput <= DataBusMemInput;
			
				when "0010" => -- Transfor Numpad value to reg or ram
				DataBusMemOutput <= NumpadReg;
				
				when "0011" => 
				DataBusMemOutput <= DataBusMemInput + DataBusReg;
				
				when "0100" => 
				DataBusMemOutput <= DataBusMemInput - DataBusReg;
				
				when "0101" => -- Ganger med 2
				shift_holder <= shift_left(unsigned(DataBusReg), 1);
				DataBusMemOutput <= std_logic_vector(shift_holder);
				
				when "0110" => -- divider med 2
				shift_holder <= shift_right(unsigned(DataBusReg), 1);
				DataBusMemOutput <= std_logic_vector(shift_holder);
				
				when "0111" => -- divider to registre
				divideReg <= unsigned(DataBusMemInput) / unsigned(DataBusReg);
				DataBusMemOutput <= std_logic_vector(divideReg);
				
				when "1000" => -- gange to registre
				multiReg <= std_logic_vector(unsigned(DataBusMemInput) * unsigned(DataBusReg));
				DataBusMemOutput <= multiReg(7 downto 0);
				
				when others => --When ther are no matches in the switch case
				report "ConBus ikke defineret";
			end case;
		end if;
    end process;

end rtl;
