library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_CyclonV is 
Port (switch0, button : in STD_LOGIC;
		led0, led1, led2, led3, led4, led5, led6, led7 : out STD_LOGIC);
end Test_CyclonV;

architecture Behavioral of Test_CyclonV is
signal tempSig : std_logic_vector(8-1 Downto 0);

begin


process (button)
begin
	if button'event and button='1' then  
      tempSig <= tempSig(8-2 downto 0) & switch0; --& betyder konkatinering
   end if;
	end process;

led0 <= tempSig(8-8);
led1 <= tempSig(8-7);
led2 <= tempSig(8-6);
led3 <= tempSig(8-5);
led4 <= tempSig(8-4);
led5 <= tempSig(8-3);
led6 <= tempSig(8-2);
led7 <= tempSig(8-1);

	
end Behavioral;

