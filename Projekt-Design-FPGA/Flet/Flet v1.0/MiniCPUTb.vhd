library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MiniCPUTb is
end  MiniCPUTb;

-- HERE ALL THE BUSSES IS CREATED: AND BOUND TO THE CORRECT INPUT / OUTPUTS IN OURE ENTITYS!

architecture sim of MiniCPUTb is

	--Clock
	--constant ClockFrequencyHz : integer := 10; -- 10 Hz
    --constant ClockPeriod 	  : time := 1000 ms / ClockFrequencyHz;

	--signal TinyClock : std_logic := '0';
	--signal TinyClock1 : std_logic := '0';
	
	signal DataBusProgram 	: std_logic_vector(31 downto 0);
	signal AddrBusProgram 	: std_logic_vector(7 downto 0);
	signal AddrBusReg 		: std_logic_vector(4 downto 0);
	signal AddrBusMemInput 	: std_logic_vector(9 downto 0);
	signal AddrBusMemOutput	: std_logic_vector(9 downto 0);
	signal EnRamInput 		: std_logic;
	signal EnRamOutput 		: std_logic;
	signal ConBusALU		: std_logic_vector(4 downto 0);
	signal HugeClock		: std_logic;
	signal TinyClock		: std_logic;
	signal ClockCycle		: std_logic_vector(2 downto 0);
	signal DataBusMemInput	: std_logic_vector(7 downto 0);
	signal DataBusReg  		: std_logic_vector(7 downto 0);
	signal DataBusMemOutput	: std_logic_vector(7 downto 0);
	-- signal NumpadReg		: std_logic_vector(7 downto 0);
	signal NSelOut			: std_logic;
	signal SkipProgram 		: std_logic;

	
begin
	
	i_ALU : entity work.ALU(rtl)
	port map(
		TinyClock   	=> TinyClock,
		ClockCycle   	=> ClockCycle,
		ConBusALU  		=> ConBusALU,
		AddrBusMemInput 	=> AddrBusMemInput,
		DataBusMemInput =>   DataBusMemInput,
		DataBusReg  	=> DataBusReg,
		NSelOut => NSelOut,
		DataBusMemOutput=> DataBusMemOutput,
		SkipProgram =>SkipProgram);
	
	i_Clock : entity work.ClockDividerModule(sim)
	port map(
		HugeClock		=> HugeClock,
		TinyClock		=> TinyClock,
		ClockCycle		=> ClockCycle);
	
	i_CU : entity work.CU(rtl) 
	port map(
		DataBusProgram 	=> DataBusProgram,
		AddrBusProgram 	=> AddrBusProgram,
		AddrBusReg 	=> AddrBusReg,
		AddrBusMemInput 	=> AddrBusMemInput,
		AddrBusMemOutput	=> AddrBusMemOutput,
		EnRamInput 		=> EnRamInput,
		EnRamOutput	 	=> EnRamOutput,
		ConBusALU 	=> ConBusALU,
		TinyClock	=> TinyClock,
		HugeClock	=> HugeClock,
		SkipProgram =>SkipProgram,
		ClockCycle	=> ClockCycle);
	
	i_ProgramCode: entity work.ProgramCode(rtl)
	
	port map(
		DataBusProgram => DataBusProgram,
		AddrBusProgram => AddrBusProgram,
		ClockCycle	=> ClockCycle,
		TinyClock  => TinyClock);
	
	i_Memory : entity work.Memory(rtl)
	port map(
		TinyClock => TinyClock,
		AddrBusMemInput => AddrBusMemInput,
		EnRamInput => EnRamInput,
		AddrBusMemOutput => AddrBusMemOutput,
		EnRamOutput => EnRamOutput,
		AddrBusReg => AddrBusReg,
		DataBusMemInput => DataBusMemInput,
		DataBusReg => DataBusReg,
		DataBusMemOutput => DataBusMemOutput,
		NSelOut => NSelOut,
		ClockCycle	=> ClockCycle);
	
	-- Proces for genarating TinyClock
	--TinyClock <= not TinyClock after ClockPeriod / 2;
	--TinyClock1 <= not TinyClock1 after ClockPeriod*4 / 2;
	
end architecture;