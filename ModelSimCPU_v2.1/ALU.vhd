library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ALU is
    port (TinyClock		: in std_logic;
		ClockCycle		: in std_logic_vector(2 downto 0);
		ConBusALU		: in std_logic_vector(4 downto 0); --Control bus for ALU. Tels it what to do. Comes from CU
		
		DataBusMemInput	: in std_logic_vector(7 downto 0); --Data form ram or reg.
		DataBusReg		: in std_logic_vector(7 downto 0); --Data for reg
		AddrBusMemInput	: in std_logic_vector(9 downto 0);
		
		DataBusMemOutput: out std_logic_vector(7 downto 0) := x"00"; -- Data to reg or ram
		
		NumpadReg		: in std_logic_vector(7 downto 0); --Data from numpad
		SkipProgram 	: out std_logic;
		NSelOut			: out std_logic);
end  ALU;

architecture rtl of ALU is

	--signal shift_holder : unsigned(7 downto 0); --Bruges til shift funktion, da den skal have en unsigned vektor 
	signal divideReg : unsigned(7 downto 0); --Bruges som placeholder til division af to registre
	signal multiReg : std_logic_vector(15 downto 0); --Placeholder til multiplikation af to registre
    --signal Shift_x : unsigned(7 downto 0); -- antal gange der skal shiftes 
begin

	process (TinyClock)
    begin
		if ClockCycle = "101" then
		NSelOut <= '0';
		SkipProgram <= '0';
			case ConBusALU is
			
				when "00000" => --NOP
				NSelOut <= '1';
				
				when "00001" => -- LOAD
				DataBusMemOutput <= DataBusMemInput;
				
				when "10111" => -- STORE
				DataBusMemOutput <= DataBusReg;
				
				when "01010" => --SET
				DataBusMemOutput <= AddrBusMemInput(7 downto 0);
				
				when "10011" => --LT
				DataBusMemOutput(7 downto 1) <= "0000000";
				if DataBusReg < DataBusMemInput then 
					DataBusMemOutput(0) <= '1';
				else 
					DataBusMemOutput(0) <= '0';
				end if;
				
				when "10100" => -- EQ
				if DataBusReg = DataBusMemInput then 
					DataBusMemOutput(0) <= '1';
				else 
					DataBusMemOutput(0) <= '0';
				end if;
				
				when "10101" => -- BEQ
				if DataBusReg = AddrBusMemInput(7 downto 0) then 
					SkipProgram <= '1';
				end if;
				
				when "10110" => -- BNEQ
				if DataBusReg /= AddrBusMemInput(7 downto 0) then 
					SkipProgram <= '1';
				end if;
				
				when "00011" => -- ADD
				DataBusMemOutput <= DataBusReg + DataBusMemInput;
				
				when "10001" => -- ADDX
				DataBusMemOutput <= DataBusReg + AddrBusMemInput(7 downto 0);
				
				when "00100" => --SUB
				DataBusMemOutput <= DataBusReg - DataBusMemInput;
				
				when "10010" => -- SUBX
				DataBusMemOutput <= DataBusReg - AddrBusMemInput(7 downto 0);				
				
				when "01000" => -- MULT
				multiReg <= std_logic_vector(unsigned(DataBusReg) * unsigned(DataBusMemInput));
				DataBusMemOutput <= multiReg(7 downto 0);				
				
				when "00111" => -- DIV
				divideReg <= unsigned(DataBusReg) / unsigned(DataBusMemInput);
				DataBusMemOutput <= std_logic_vector(divideReg);			
				
				when "01100" => -- AND
				DataBusMemOutput <= DataBusReg and DataBusMemInput;
				
				when "01101" => -- OR
				DataBusMemOutput <= DataBusReg or DataBusMemInput;
				
				when "01110" => -- NOT
				DataBusMemOutput <= not DataBusMemInput;
				
				when "10000" => -- XOR
				DataBusMemOutput <= DataBusReg xor DataBusMemInput;
				
				when "01111" => -- Transfor Numpad value to reg or ram
				DataBusMemOutput <= NumpadReg;
				
				--when "00101" => -- SHL
				--shift_holder <= SHIFT_LEFT(unsigned(DataBusReg), 1);
				--DataBusMemOutput <= std_logic_vector(shift_holder);
				
				--when "00110" => -- SHR
				--Shift_x <= unsigned(DataBusMemInput);
				--shift_holder <= shift_right(unsigned(DataBusReg), Shift_x);
				--DataBusMemOutput <= std_logic_vector(shift_holder);
				
				when others => --When ther are no matches in the switch case
				NSelOut <= '1';
				report "ConBus ikke defineret";
			end case;
		end if;
    end process;

end rtl;
