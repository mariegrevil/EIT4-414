library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Memory is
    port (TinyClock  : in std_logic;
	
		AddrBusMemInput		: in std_logic_vector(7 downto 0); -- Addr bus to ram and reg
		EnRamInput			: in std_logic;
		
		AddrBusMemOutput	: in std_logic_vector(7 downto 0);
		EnRamOutput			: in std_logic;
		
        AddrBusReg			: in std_logic_vector(7 downto 0);
		
		DataBusMemInput		: out std_logic_vector(7 downto 0);
		DataBusReg  		: out std_logic_vector(7 downto 0);
		DataBusMemOutput	: in std_logic_vector(7 downto 0));
		
		
end  Memory;

architecture rtl of Memory is

    type reg_type is array (255 downto 0) of std_logic_vector (7 downto 0);
    signal REG: reg_type := (others => x"00");
	signal RAM: reg_type := (others => x"00");
	
begin

    process (TinyClock)
    begin
        if rising_edge(TinyClock) then
			
			DataBusReg <= REG(conv_integer(AddrBusReg));
		
			if EnRamInput = '1' then
				
				DataBusMemInput <= RAM(conv_integer(AddrBusMemInput));
				
			elsif EnRamInput = '0' then
				
				DataBusMemInput <= REG(conv_integer(AddrBusMemInput));
				
			else
			
				DataBusMemInput <= (others => 'X');
			
			end if;
			
			if EnRamOutput = '1' then
				
				RAM(conv_integer(AddrBusMemOutput)) <= DataBusMemOutput;
				
			elsif EnRamOutput = '0' then
				
				REG(conv_integer(AddrBusMemOutput)) <= DataBusMemOutput;
			
			end if;
		
            --if ENREG = '1' then
            --    if WEREG = '1' then
            --        RAM(conv_integer(ADDR)) <= CBus;
            --    end if;
            --    BBus <= RAM(conv_integer(ADDR)) ;
            --end if;
        end if;
    end process;

end rtl;
