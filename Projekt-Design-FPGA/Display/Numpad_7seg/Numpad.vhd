library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
--use ieee.std_logic_unsigned.all;

entity Numpad is
	port(
	
		-- Input-matrix:
		numpad_c		: in std_logic_vector(3 downto 0);
		numpad_r		: in std_logic_vector(3 downto 0)
		
		);
end Numpad;

architecture rtl of Numpad is

begin

end rtl;