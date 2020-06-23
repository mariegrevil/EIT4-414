----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:04:15 02/25/2020 
-- Design Name: 
-- Module Name:    TestNy - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TestNy is
	Port(switch0, button : in STD_LOGIC;
		  led0, led1, led2, led3, led4, led5, led6, led7 : out STD_LOGIC);
end TestNy;

architecture Behavioral of TestNy is
	signal tempSig : std_logic_vector(8-1 Downto 0);

begin

-- Define a temporary signal that is of type std_logic_vector(<width>-1 downto 0).
-- Where width is the number of bits to shift
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

