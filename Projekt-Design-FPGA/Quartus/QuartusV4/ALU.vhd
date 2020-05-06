library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity ALU is
    port (TinyClock		: in std_logic;
		ClockCycle		: in std_logic_vector(2 downto 0);
		ConBusALU		: in std_logic_vector(4 downto 0); --Control bus for ALU. Tells it what to do. Comes from CU
		
		DataBusMemInput	: in std_logic_vector(7 downto 0); --Data form ram or reg.
		DataBusReg		: in std_logic_vector(7 downto 0); --Data for reg
		AddrBusMemInput	: in std_logic_vector(9 downto 0);
		
		DataBusMemOutput: out std_logic_vector(7 downto 0) := x"00"; -- Data to reg or ram
		
		SkipProgram 	: out std_logic;
		NSelOut			: out std_logic
		);
end  ALU;

architecture rtl of ALU is

	signal divideReg : signed(7 downto 0); --Bruges som placeholder til division af to registre
	signal multiReg : std_logic_vector(15 downto 0); --Placeholder til multiplikation af to registre
	signal TooBigResult : std_logic := '0';
	
	procedure tooBig(signal multiReg2 : in std_logic_vector(15 downto 0); -- Kigger på de 9 første bits. Hvis de alle er ens så har vi ikke overskredet
					 signal TBR : out std_logic;
					 signal DataBusMemOutput2 : out std_logic_vector(7 downto 0)) is
		begin
			if multiReg2(15 downto 7) = "000000000" then -- Er de første 9 bits 0
				DataBusMemOutput2 <= multiReg2(7 downto 0);
				TBR <= '0';	
				
			elsif multiReg2(15 downto 7) = "111111111" then -- Er de første 9 bits 1
				DataBusMemOutput2 <= multiReg2(7 downto 0);
				TBR <= '0';
			else
				DataBusMemOutput2 <= (others => '0');
				TBR <= '1';
			end if;
	end procedure;
	
begin

	
	process (TinyClock)
    begin
		if ClockCycle = "101" then
		NSelOut <= '0';
		SkipProgram <= '0';
		multiReg(15 downto 0) <= (others => '0');
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
					DataBusMemOutput(7 downto 1) <= "0000000";
					if DataBusReg = DataBusMemInput then 
						DataBusMemOutput(0) <= '1';
					else 
						DataBusMemOutput(0) <= '0';
					end if;
				
				when "10101" => -- BEQ
					NSelOut <= '1';
					if DataBusReg = AddrBusMemInput(7 downto 0) then 
						SkipProgram <= '1';
					end if;
				
				when "10110" => -- BNEQ
					NSelOut <= '1';
					if DataBusReg /= AddrBusMemInput(7 downto 0) then 
						SkipProgram <= '1';
					end if;
				
				when "00011" => -- ADD
				
					multiReg <= ("00000000" & DataBusReg) + DataBusMemInput;
				
						tooBig(multiReg, TooBigResult, DataBusMemOutput);
				
				when "10001" => -- ADDX
					multiReg <= ("00000000" & DataBusReg) + AddrBusMemInput(7 downto 0);
				
						tooBig(multiReg, TooBigResult, DataBusMemOutput);

				when "00100" => --SUB
					multiReg <= ("00000000" & DataBusReg) - DataBusMemInput;
				
						tooBig(multiReg, TooBigResult, DataBusMemOutput);
				
				when "10010" => -- SUBX
					multiReg <= ("00000000" & DataBusReg) - AddrBusMemInput(7 downto 0);
				
						tooBig(multiReg, TooBigResult, DataBusMemOutput);
				
				when "01000" => -- MULT
					multiReg <= std_logic_vector(signed(DataBusReg) * signed(DataBusMemInput));
				
						tooBig(multiReg, TooBigResult, DataBusMemOutput);
				
				when "00111" => -- DIV
					if (DataBusMemInput = x"00") then
						DataBusMemOutput <= x"00";
						TooBigResult <= '1';
					else
						divideReg <= signed(DataBusReg) / signed(DataBusMemInput);
						DataBusMemOutput <= std_logic_vector(divideReg);			
					end if;
				when "01100" => -- AND
					DataBusMemOutput <= DataBusReg and DataBusMemInput;
				
				when "01101" => -- OR
					DataBusMemOutput <= DataBusReg or DataBusMemInput;
				
				when "01110" => -- NOT
					DataBusMemOutput <= not DataBusMemInput;
				
				when "10000" => -- XOR
					DataBusMemOutput <= DataBusReg xor DataBusMemInput;
				
				when "11111" => --TBR
					DataBusMemOutput <= "0000000" & TooBigResult;
					
				when others => --When ther are no matches in the switch case
				NSelOut <= '1';
			end case;
		end if;
	end process;

end rtl;
