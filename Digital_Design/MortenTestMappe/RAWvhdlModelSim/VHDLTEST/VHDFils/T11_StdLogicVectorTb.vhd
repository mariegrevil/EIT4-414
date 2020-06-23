library ieee;
use ieee.std_logic_1164.all;

entity T11_StdLogicVectorTb is
end entity;

architecture sim of T11_StdLogicVectorTb is
	
	signal Slv1 : std_logic_vector(7 downto 0) := x"01";
	signal Slv2 : std_logic_vector(7 downto 0) := "00000001";

begin
	
	-- Shift register 
	process is
	begin 
	
		wait for 10 ns;
		
		for i in Slv1'left downto Slv1'right + 1 loop
			Slv1(i) <= Slv1(i-1);
		end loop;
		
		Slv1(Slv1'right) <= Slv1(Slv1'left);
	
	end process;
	
end architecture;