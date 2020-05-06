library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity IO_ALU is
    port (TinyClock			: in std_logic;
		ClockCycle			: in std_logic_vector(2 downto 0);
		IO_ConBusALU		: in std_logic_vector(4 downto 0); --Control bus for ALU. Tells it what to do. Comes from CU
		IO_DataBusReg		: in std_logic_vector(7 downto 0); --Data for reg
		IO_DataBusMemOutput	: out std_logic_vector(7 downto 0) := x"00"; -- Data to reg
		IO_NSelOut			: out std_logic;
		
		-- I/O --
		ActionJackson	: in std_logic_vector(7 downto 0);
		InputValueOne	: in std_logic_vector(7 downto 0);
		InputValueTwo	: in std_logic_vector(7 downto 0);
		Result			: out std_logic_vector(7 downto 0) := (others => '0');
		IO_TBR			: out std_logic
		);
end  IO_ALU;

architecture rtl of IO_ALU is

	
begin

	
	process (TinyClock)
    begin
		if ClockCycle = "101" then
		IO_NSelOut <= '0';
			case IO_ConBusALU is
			
				when "00000" => --NOP
				IO_NSelOut <= '1';
				
				-- I/O-operationer --
				when "11000" => -- Transfer InputValueOne to REG
				IO_DataBusMemOutput <= InputValueOne;
				
				when "11001" => -- Transfer InputValueTwo to REG
				IO_DataBusMemOutput <= InputValueTwo;
				
				when "11010" => -- Transfer result to BCD module
				Result <= IO_DataBusReg;
				
				when "11011" => -- Transfer Action Jackson to REG
				IO_DataBusMemOutput <= "00" & ActionJackson(5 downto 0);
				
				when "00001" => -- Transfor too big result
				IO_TBR <= IO_DataBusReg(0);
				
				when others => --When ther are no matches in the switch case
				IO_NSelOut <= '1';
			end case;
		end if;
    end process;

end rtl;