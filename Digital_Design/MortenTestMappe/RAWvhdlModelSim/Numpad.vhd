library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Numpad is
    port (
	NumpadReg	:	out STD_LOGIC_VECTOR(7 downto 0) := x"00");
end Numpad;

architecture rtl of Numpad is
	
begin

	NumpadReg <= x"07";
    
end rtl;
