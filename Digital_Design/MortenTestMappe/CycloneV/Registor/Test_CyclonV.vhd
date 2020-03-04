
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Test_CyclonV is
    port (
	       led0 : out std_logic;
	       led1 : out std_logic;
	       led2 : out std_logic;
	       led3 : out std_logic;
	       led4 : out std_logic;
	       led5 : out std_logic;
	       led6 : out std_logic;
	       led7 : out std_logic;
	       SW0  : in std_logic;
	       SW1  : in std_logic;
	       SW2  : in std_logic;
	       SW3  : in std_logic;
	       SW4  : in std_logic;
	       SW5  : in std_logic;
	       SW6  : in std_logic;
	       SW7  : in std_logic;
	       SW8  : in std_logic;
			 SW9  : in std_logic;
			 KEY0 : in std_logic;
			 --CLK  : in std_logic;
          WE   : inout std_logic;
          EN   : inout std_logic;
          ADDR : inout std_logic_vector(1 downto 0);
          DI   : inout std_logic_vector(3 downto 0);
          DO   : inout std_logic_vector(3 downto 0));
end Test_CyclonV;


architecture syn of Test_CyclonV is
    type ram_type is array (3 downto 0) of std_logic_vector (3 downto 0);
    signal RAM: ram_type;
begin

    process (KEY0)
    begin
		ADDR(0) <= SW9;
		ADDR(1) <= SW8;
		
		DI(3) <= SW0;
		DI(2) <= SW1;
		DI(1) <= SW2;
		DI(0) <= SW3;
		
		EN <= SW7;
		WE <= SW6;
		
			
		led0 <= DO(3);
		led1 <= DO(2);
		led2 <= DO(1);
		led3 <= DO(0);
		
        if KEY0'event and KEY0 = '1' then
            if EN = '1' then
                if WE = '1' then
                    RAM(conv_integer(ADDR)) <= DI;
                end if;
                DO <= RAM(conv_integer(ADDR)) ;
            end if;
        end if;
    end process;

end syn;



		

