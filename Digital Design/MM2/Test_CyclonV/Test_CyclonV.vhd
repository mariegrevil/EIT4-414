library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_CyclonV is 
Port (switch0, switch1, switch2, switch3 : in STD_LOGIC;
		led0, led1, led2, led3 : out STD_LOGIC);
end Test_CyclonV;

architecture Behavioral of Test_CyclonV is
begin
	--led0,sum -- led1,carry Out -- switch0, a -- switch1, b -- switch2 carry in.
	
	led0 <= (switch0 xor switch1 ) xor (switch2);
	led1 <= (switch0 and switch1) or ((switch0 xor switch1) and (switch2));
end Behavioral;