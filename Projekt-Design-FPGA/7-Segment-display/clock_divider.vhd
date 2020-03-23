-- Clock divider [By Johnni :D]

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity clock_divider is
	--setup:
	port	(	clk		:	in std_logic;
				enable	:	in std_logic;
				reset		:	in std_logic;
				data_clk	:	out std_logic_vector(15 downto 0));
	
end clock_divider;


architecture rtl of clock_divider is
	-- loop:
begin
	process(clk,reset)
		variable count	:	std_logic_vector (15 downto 0) := (others	=>	'0'); 
		begin
			if	reset	= '1' then
				count	:=	(others => '0');
			
			elsif	enable = '1' and clk'event and clk	= '1' then
				count := count + 1;
				
			end if;
		
		data_clk <= count;
	
	end process;
	
	
end rtl;

