library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CU is
    port (CLK  : in std_logic;
		  CLK1 : in std_logic;
          DataBusA: in std_logic_vector(31 downto 0); -- Data bus to program code -> what to do
		  --DataBusB: in std_logic_vector(7 downto 0);  -- Data bus to instuktionset -> how to do
		  AddrBusA:	out std_logic_vector(7 downto 0); -- Addr bus to program code
		  --AddrBusB:	out std_logic_vector(5 downto 0); -- Addr bus to instruktion set
		  AddrBusC:	out std_logic_vector(7 downto 0); -- Addr bus only to reg
		  AddrBusD:	out std_logic_vector(7 downto 0); -- Addr bus to ram and reg
		  AddrBusD2:out std_logic_vector(7 downto 0); -- for writing
		  EnRam	  : out std_logic; -- ram or reg for addr bus D 
		  EnRam2  : out std_logic; -- for writing
		  ConBusA : out std_logic_vector(3 downto 0)); -- Control bus for ALU
		  
end  CU;

architecture rtl of CU is

    signal IR : std_logic_vector(31 downto 0);
	signal PC : std_logic_vector(7 downto 0) := x"00";
	signal OPCODE : std_logic_vector(5 downto 0);
begin

   
	process(CLK,CLK1)
    begin
        if rising_edge(CLK) then
			AddrBusA <= PC;
            IR <= DataBusA;
			OPCODE <= IR(31 downto 26);
			AddrBusC <= IR(25 downto 18);
			AddrBusD <= IR(17 downto 10);
			EnRam <= IR(9);
			AddrBusD2 <= IR(8 downto 1);
			EnRam2 <= IR(0);
        end if;
		
		if falling_edge(CLK1) then
			PC <= PC + 1;
			case OPCODE is
				when "000000" => -- NOP
					ConBusA <= "0000";
				when "000001" => -- move Databus D to DatabusD2
					ConBusA <= "0001";
					when others => --Other then named cases
					report "ERROR!";
			end case;
        end if;
    end process;
	

end rtl;
