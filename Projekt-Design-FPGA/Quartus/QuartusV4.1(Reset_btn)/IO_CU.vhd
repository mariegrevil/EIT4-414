library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity IO_CU is
    port (TinyClock  			: in std_logic;
		  HugeClock 			: in std_logic;
		  ClockCycle 			: in std_logic_vector(2 downto 0); -- Counts rising edges in tinyclock per hugeclock
          IO_DataBusProgram		: in std_logic_vector(31 downto 0); -- Data bus from program code -> what to do (instruktion)
		  IO_AddrBusProgram		: out std_logic_vector(7 downto 0); -- Addr bus to program code -> Where is the instruktion we want to load
		  IO_AddrBusReg			: out std_logic_vector(4 downto 0); -- Addr bus only to reg. -> Where do we want to take data form reg
		  IO_AddrBusMemOutput	: out std_logic_vector(9 downto 0); -- Addr bus to ram and reg -> Where do we want to save data in reg or ram
		  IO_ConBusALU 			: out std_logic_vector(4 downto 0) -- Control bus for ALU
		  );
end  IO_CU;

architecture rtl of IO_CU is

    signal IO_IR 		: std_logic_vector(31 downto 0); -- Local registor to save the current instruktion
	signal IO_PC 		: std_logic_vector(7 downto 0) := x"00"; -- Counter number of run instruktions. Used as load addreses as of V.2
	signal IO_OPCODE 	: std_logic_vector(4 downto 0); -- Local registor for IO_OPCode
	
begin

   
	process(TinyClock,HugeClock)
    begin
		if rising_edge(TinyClock) then
			case ClockCycle is
				when "000" => -- ClockCycel 0
					IO_AddrBusProgram <= IO_PC;
				
				when "010" => -- ClockCycel 2
					IO_IR <= IO_DataBusProgram;
				
				when "011" => -- ClockCycel 3
					IO_OPCODE <= IO_IR(31 downto 27);
					IO_AddrBusMemOutput <= IO_IR(26 downto 17);
					IO_AddrBusReg <= IO_IR(15 downto 11);
					
				when "100" => -- ClockCycel 4. (Clock cycel 5 and 6 are used to run ALU and SAVE in mem)
					case IO_OPCODE is
						when "00000" => -- NOP
							IO_ConBusALU <= "00000";
						when "10110" => -- GOTO
							IO_PC <= IO_IR(8 downto 1) - 1;
							IO_ConBusALU <= "00000";
						when "11000" => --VAL1
							IO_ConBusALU <= "11000";
						when "11001" => --VAL2
							IO_ConBusALU <= "11001";
						when "11010" => --ANS
							IO_ConBusALU <= "11010";
						when "11011" => --AJ
							IO_ConBusALU <= "11011";
						when "00001" => -- TBR
							IO_ConBusALU <= "00001";
						when others => --Other then named cases
						
					end case;
				when "111" => -- ClockCycel 7
						IO_PC <= IO_PC + 1;
						
				when others =>
					
			end case;
        end if;
			
    end process;
	
end rtl;