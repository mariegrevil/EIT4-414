library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Memory is
    port (TinyClock  : in std_logic;
	
		AddrBusMemInput		: in std_logic_vector(9 downto 0); --Addr bus to ram and reg -> Where do we want to take data form reg or ram
		EnRamInput			: in std_logic; -- Ram or reg
		
		AddrBusMemOutput	: in std_logic_vector(9 downto 0); -- Addr bus to ram and reg -> Where do we want to save data in reg or ram
		EnRamOutput			: in std_logic; -- Ram or reg
		
        AddrBusReg			: in std_logic_vector(4 downto 0); -- Addr bus only to reg. -> Where do we want to take data form reg
		NSelOut				: in std_logic;
		DataBusMemInput		: out std_logic_vector(7 downto 0); --Data from reg or ram 
		DataBusReg  		: out std_logic_vector(7 downto 0); -- Data from reg
		DataBusMemOutput	: in std_logic_vector(7 downto 0); -- Data to reg or ram
		ClockCycle 			: in std_logic_vector(2 downto 0); -- Counts rising edges in tinyclock per hugeclock
		-- IO
		IO_AddrBusMemOutput	: in std_logic_vector(9 downto 0);
		IO_AddrBusReg		: in std_logic_vector(4 downto 0);
		IO_DataBusMemOutput	: in std_logic_vector(7 downto 0);
		IO_DataBusReg  		: out std_logic_vector(7 downto 0);
		IO_NSelOut			: in std_logic);
		
		
end  Memory;

architecture rtl of Memory is

    type reg_type is array (31 downto 0) of std_logic_vector (7 downto 0);
	type ram_type is array (1023 downto 0) of std_logic_vector (7 downto 0);
    signal REG: reg_type := (others => x"00");
	signal RAM: ram_type := (others => x"00");
	
begin
    process (TinyClock)
    begin
        if rising_edge(TinyClock) then
			if (Clockcycle = "100") then
			
				DataBusReg <= REG(conv_integer(AddrBusReg)); -- Put the location pointet to by the "AddrBusReg" on to "DataBusReg"
				IO_DataBusReg <= REG(conv_integer(IO_AddrBusReg));
				
				if EnRamInput = '1' then --DataBusMemInput loads data from RAM
					
					DataBusMemInput <= RAM(conv_integer(AddrBusMemInput));
					
				elsif (EnRamInput = '0') then --DataBusMemInput loads data from REG
					DataBusMemInput <= REG(conv_integer(AddrBusMemInput));
					
				-- else -- Just in case of an Error. Runs if EnRamInput is nither 1 or 0.
				
					-- DataBusMemInput <= (others => 'X');
				
				end if;
			end if;	
			if Clockcycle = "111" then	
				if IO_NSelOut = '0' then
					REG(conv_integer(IO_AddrBusMemOutput)) <= IO_DataBusMemOutput;
				end if;
				if NSelOut = '0' then -- Negativ select output. anvendes til NOP
				
					if EnRamOutput = '1' then --DataBusMemOutput stors data in RAM
						
						RAM(conv_integer(AddrBusMemOutput)) <= DataBusMemOutput;
						
					elsif EnRamOutput = '0' then --DataBusMemOutput stors data in REG
						
						REG(conv_integer(AddrBusMemOutput)) <= DataBusMemOutput;
					
					end if;
				end if;	
			end if;
		
        end if;
    end process;

end rtl;
