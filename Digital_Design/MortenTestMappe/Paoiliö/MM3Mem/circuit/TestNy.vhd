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
	Port(switch0, switch1, switch2, switch3, switch4, switch5, switch6, switch7, button, button1 : in STD_LOGIC;
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
tempSig(8-8) <= switch0;
tempSig(8-7) <= switch1;
tempSig(8-6) <= switch2;
tempSig(8-5) <= switch3;
tempSig(8-4) <= switch4;
tempSig(8-3) <= switch5;
tempSig(8-2) <= switch6;
tempSig(8-1) <= switch7;
end if;
end process;

process (button1)
begin
if button1'event and button1='1' then  
led0 <= tempSig(8-8);
led1 <= tempSig(8-7);
led2 <= tempSig(8-6);
led3 <= tempSig(8-5);
led4 <= tempSig(8-4);
led5 <= tempSig(8-3);
led6 <= tempSig(8-2);
led7 <= tempSig(8-1);
end if;
end process;


end Behavioral;

