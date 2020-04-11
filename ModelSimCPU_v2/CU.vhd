library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CU is
    port (TinyClock     : in std_logic;
		  HugeClock     : in std_logic;
		  ClockCycle    : in std_logic_vector(2 downto 0); -- Counts rising edges in tinyclock per hugeclock
          DataBusProgram: in std_logic_vector(31 downto 0); -- Data bus from program code -> what to do (instruktion)
		  AddrBusProgram: out std_logic_vector(7 downto 0); -- Addr bus to program code -> Where is the instruktion we want to load
		  AddrBusReg    : out std_logic_vector(7 downto 0); -- Addr bus only to reg. -> Where do we want to take data form reg
		  AddrBusMemInput:out std_logic_vector(7 downto 0); -- Addr bus to ram and reg -> Where do we want to take data form reg or ram
		  AddrBusMemOutput:out std_logic_vector(7 downto 0); -- Addr bus to ram and reg -> Where do we want to save data in reg or ram
		  EnRamInput	:out std_logic; -- ram or reg for "AddrBusMemInput"
		  EnRamOutput   :out std_logic; -- ram or reg for "AddrBusMemOutput"
		  ConBusALU     :out std_logic_vector(3 downto 0)); -- Control bus for ALU
		  
end  CU;

architecture rtl of CU is

    signal IR : std_logic_vector(31 downto 0); -- Local registor to save the current instruktion
	signal PC : std_logic_vector(7 downto 0) := x"00"; -- Counter number of run instruktions. Used as load addreses as of V.2
	signal OPCODE : std_logic_vector(5 downto 0); -- Local registor for opcode
begin

   
	process(TinyClock,HugeClock)
    begin

		if rising_edge(TinyClock) then
			case ClockCycle is
				when "000" => -- ClockCycel 0
				AddrBusProgram <= PC;
				when "010" => -- ClockCycel 2
				IR <= DataBusProgram;
				when "011" => -- ClockCycel 3
					OPCODE <= IR(31 downto 26);
					AddrBusReg <= IR(25 downto 18);
					AddrBusMemInput <= IR(17 downto 10);
					EnRamInput <= IR(9);
					AddrBusMemOutput <= IR(8 downto 1);
					EnRamOutput <= IR(0);
				when "100" => -- ClockCycel 4. (Clock cycel 5 and 6 are used to run ALU and SAVE in mem)
					case OPCODE is
						when "000000" => -- NOP
							ConBusALU <= "0000";
						when "000001" => -- NOT USED AT THE MOMENT
							ConBusALU <= "0001";
						when "000010" => -- flyt NumpadReg til Memory
							ConBusALU <= "0010";
						when "000011" => -- ADD 
							ConBusALU <= "0011";
						when "000100" => --SUB
							ConBusALU <= "0100";
						when "000101" => --Shift left
							ConBusALU <= "0101";
						when "000110" => --Shift right
							ConBusALU <= "0110";
						when "000111" => --Divide
							ConBusALU <= "0111";
						when "001000" => --Divide
							ConBusALU <= "1000";
						when others => --Other then named cases
						report "ERROR!";
					end case;
				when "111" => -- ClockCycel 7
					PC <= PC + 1;
				when others =>
					report "Tom cyklus";
			end case;
        end if;
		
		--if falling_edge(HugeClock) then
			
			
        --end if;
		
    end process;
	

end rtl;
