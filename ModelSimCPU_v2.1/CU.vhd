library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CU is
    port (TinyClock  : in std_logic;
		  HugeClock : in std_logic;
		  ClockCycle : in std_logic_vector(2 downto 0); -- Counts rising edges in tinyclock per hugeclock
          DataBusProgram: in std_logic_vector(31 downto 0); -- Data bus from program code -> what to do (instruktion)
		  AddrBusProgram:	out std_logic_vector(7 downto 0); -- Addr bus to program code -> Where is the instruktion we want to load
		  AddrBusReg:	out std_logic_vector(4 downto 0); -- Addr bus only to reg. -> Where do we want to take data form reg
		  AddrBusMemInput:	out std_logic_vector(9 downto 0); -- Addr bus to ram and reg -> Where do we want to take data form reg or ram
		  AddrBusMemOutput:out std_logic_vector(9 downto 0); -- Addr bus to ram and reg -> Where do we want to save data in reg or ram
		  EnRamInput	  : out std_logic; -- ram or reg for "AddrBusMemInput"
		  EnRamOutput  : out std_logic; -- ram or reg for "AddrBusMemOutput"
		  SkipProgram 	: in std_logic;
		  ConBusALU : out std_logic_vector(4 downto 0)); -- Control bus for ALU
end  CU;

architecture rtl of CU is

    signal IR : std_logic_vector(31 downto 0); -- Local registor to save the current instruktion
	signal PC : std_logic_vector(7 downto 0) := x"00"; -- Counter number of run instruktions. Used as load addreses as of V.2
	signal OPCODE : std_logic_vector(4 downto 0); -- Local registor for opcode
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
					OPCODE <= IR(31 downto 27);
					AddrBusMemOutput <= IR(26 downto 17);
					EnRamOutput <= IR(16);
					AddrBusReg <= IR(15 downto 11);
					AddrBusMemInput <= IR(10 downto 1);
					EnRamInput <= IR(0);
				when "100" => -- ClockCycel 4. (Clock cycel 5 and 6 are used to run ALU and SAVE in mem)
					case OPCODE is
						when "00000" => -- NOP
							ConBusALU <= "00000";
						when "00001" => -- LOAD
							ConBusALU <= "00001";
						when "00010" => -- LOAD1 <-xxx
							ConBusALU <= "00010";
							--InDirAddr	<= '1';
						when "00011" => -- STORE
							ConBusALU <= "00001";
						when "00100" => -- STORE1 <-xxx
							--InDirAddr	<= 1;
							ConBusALU <= "01001";
						when "00101" => -- SET
							ConBusALU <= "01010";
						when "00110" => -- LT
							ConBusALU <= "10011";
						when "00111" => -- EQ
							ConBusALU <= "10100";
						when "01000" => -- BEQ <-xxx
							ConBusALU <= "10101";
						when "01001" => -- BNEQ <-xxx
							ConBusALU <= "10110";
						when "01010" => -- ADD
							ConBusALU <= "00011";
						when "01011" => -- ADDX
							ConBusALU <= "10001";
						when "01100" => -- SUB
							ConBusALU <= "00100";
						when "01101" => -- SUBX
							ConBusALU <= "10010";
						when "01110" => -- MULT
							ConBusALU <= "01000";
						when "01111" => -- DIV
							ConBusALU <= "00111";
						when "10000" => -- AND
							ConBusALU <= "01100";
						when "10001" => -- OR
							ConBusALU <= "01101";
						when "10010" => -- NOT
							ConBusALU <= "01110";
						when "10011" => -- XOR
							ConBusALU <= "10000";
						when "10100" => -- SHR <-xxx
							ConBusALU <= "00110";
						when "10101" => -- SHL <-xxx
							ConBusALU <= "00101";
						when "10110" => -- GOTO
							PC <= IR(8 downto 1) - 1;
						when "10111" => -- JMPX
							PC <= PC - IR(8 downto 1) -1;
						when "11001" => --MIDLERTIDDIGT! flyt NumpadReg til Memory
							ConBusALU <= "01111";
						when others => --Other then named cases
						report "ERROR!";
					end case;
				when "111" => -- ClockCycel 7
					if SkipProgram = '1' then 
						PC <= PC + 2;
					else
						PC <= PC + 1;
					end if;
				when others =>
					
			end case;
        end if;
		
		--if falling_edge(HugeClock) then
			
			
        --end if;
		
    end process;
	

end rtl;
