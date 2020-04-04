library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CU is
    port (TinyClock  : in std_logic;
		  HugeClock : in std_logic;
		  ClockCycle : in std_logic_vector(2 downto 0);
          DataBusProgram: in std_logic_vector(31 downto 0); -- Data bus to program code -> what to do
		  --DataBusB: in std_logic_vector(7 downto 0);  -- Data bus to instuktionset -> how to do
		  AddrBusProgram:	out std_logic_vector(7 downto 0); -- Addr bus to program code
		  --AddrBusB:	out std_logic_vector(5 downto 0); -- Addr bus to instruktion set
		  AddrBusReg:	out std_logic_vector(7 downto 0); -- Addr bus only to reg
		  AddrBusMemInput:	out std_logic_vector(7 downto 0); -- Addr bus to ram and reg
		  AddrBusMemOutput:out std_logic_vector(7 downto 0); -- for writing
		  EnRamInput	  : out std_logic; -- ram or reg for addr bus D 
		  EnRamOutput  : out std_logic; -- for writing
		  ConBusALU : out std_logic_vector(3 downto 0)); -- Control bus for ALU
		  
end  CU;

architecture rtl of CU is

    signal IR : std_logic_vector(31 downto 0);
	signal PC : std_logic_vector(7 downto 0) := x"00";
	signal OPCODE : std_logic_vector(5 downto 0);
begin

   
	process(TinyClock,HugeClock)
    begin

		if rising_edge(TinyClock) then
			case ClockCycle is
				when "000" =>
				AddrBusProgram <= PC;
				when "010" =>
				IR <= DataBusProgram;
				when "011" =>
					OPCODE <= IR(31 downto 26);
					AddrBusReg <= IR(25 downto 18);
					AddrBusMemInput <= IR(17 downto 10);
					EnRamInput <= IR(9);
					AddrBusMemOutput <= IR(8 downto 1);
					EnRamOutput <= IR(0);
				when "100" =>
					case OPCODE is
						when "000000" => -- NOP
							ConBusALU <= "0000";
						when "000001" => -- move Databus D to DataBusMemOutput
							ConBusALU <= "0001";
						when "000010" => -- flyt NumpadReg til Register
							ConBusALU <= "0010";
						when others => --Other then named cases
						report "ERROR!";
					end case;
				when "111" =>
					PC <= PC + 1;
				when others =>
					report "Tom cyklus";
			end case;
        end if;
		
		--if falling_edge(HugeClock) then
			
			
        --end if;
		
    end process;
	

end rtl;
