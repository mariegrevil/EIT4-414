library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TestBench is
end  TestBench;

architecture sim of TestBench is

	-- CLOCK --
	signal HugeClock			: std_logic;
	signal TinyClock			: std_logic;
	signal ClockCycle			: std_logic_vector(2 downto 0);
	
	-- I/O --
	-- Input-værdi til displayet i form af vektor med 8 bits.
	signal Binary				: std_logic_vector (7 downto 0) := (others => '0');
	signal Result				: std_logic_vector (7 downto 0);
	
	-- Input-værdi konverteret fra binær til BCD.
	signal DecimalOutput		: std_logic_vector (23 downto 0);
	signal ActionJackson		: std_logic_vector (7 downto 0);
	signal InputValueOne		: std_logic_vector (7 downto 0);
	signal InputValueTwo		: std_logic_vector (7 downto 0);
	
	-- Input-værdi konverteret fra BCD til 7-segment-mønster.
	signal DisplayOutput		: std_logic_vector (41 downto 0);
	
	-- IO Adressebusser
	signal IO_AddrBusProgram 		: std_logic_vector(7 downto 0);
	signal IO_AddrBusReg 			: std_logic_vector(4 downto 0);
	signal IO_AddrBusMemOutput		: std_logic_vector(9 downto 0);
	
	-- Databusser
	signal IO_DataBusProgram 		: std_logic_vector(31 downto 0);
	signal IO_DataBusReg  			: std_logic_vector(7 downto 0);
	signal IO_DataBusMemOutput		: std_logic_vector(7 downto 0);
	
	
	-- IO Kontrolbusser
	signal IO_ConBusALU			: std_logic_vector(4 downto 0);
	signal IO_NSelOut			: std_logic;
	
	-- CPU --
	-- Adressebusser
	signal AddrBusProgram 		: std_logic_vector(7 downto 0);
	signal AddrBusReg 			: std_logic_vector(4 downto 0);
	signal AddrBusMemInput 		: std_logic_vector(9 downto 0);
	signal AddrBusMemOutput		: std_logic_vector(9 downto 0);
	
	-- Databusser
	signal DataBusProgram 		: std_logic_vector(31 downto 0);
	signal DataBusMemInput		: std_logic_vector(7 downto 0);
	signal DataBusReg  			: std_logic_vector(7 downto 0);
	signal DataBusMemOutput		: std_logic_vector(7 downto 0);
	
	-- RAM/REG
	signal EnRamInput 			: std_logic;
	signal EnRamOutput 			: std_logic;
	
	-- Kontrolbusser
	signal ConBusALU			: std_logic_vector(4 downto 0);
	signal NSelOut				: std_logic;
	signal SkipProgram 			: std_logic;
	signal TooBigResult			: std_logic;
	
begin
	
	-- CLOCK --
	i_Clock : entity work.ClockDividerModule(sim)
	port map(
		HugeClock				=> HugeClock,
		TinyClock				=> TinyClock,
		ClockCycle				=> ClockCycle);
	
	-- I/O --
	i_BCD : entity work.BinaryToBCD(sim)
	port map(
		TinyClock				=> TinyClock,
		Binary					=> Binary,
		DecimalOutput			=> DecimalOutput,
		ActionJackson			=> ActionJackson);
		
	i_Display : entity work.Display(sim)
	port map(
		TinyClock				=> TinyClock,
		DecimalOutput			=> DecimalOutput,
		DisplayOutput 			=> DisplayOutput);
		
	i_Numpad : entity work.Numpad(sim)
	port map(
		TinyClock				=> TinyClock,
		Binary 					=> Binary,
		ActionJackson			=> ActionJackson,
		InputValueOne			=> InputValueOne,
		InputValueTwo			=> InputValueTwo,
		TooBigResult			=> TooBigResult,
		Result					=> Result
		);
	
	i_IO_ALU : entity work.IO_ALU(rtl)
	port map(
		TinyClock   			=> TinyClock,
		ClockCycle   			=> ClockCycle,
		IO_ConBusALU  			=> IO_ConBusALU,
		IO_DataBusReg  			=> IO_DataBusReg,
		IO_NSelOut 				=> IO_NSelOut,
		IO_DataBusMemOutput		=> IO_DataBusMemOutput,
		ActionJackson			=> ActionJackson,
		InputValueOne			=> InputValueOne,
		InputValueTwo			=> InputValueTwo,
		Result					=> Result);
		
	i_IO_CU : entity work.IO_CU(rtl) 
	port map(
		IO_DataBusProgram		=> IO_DataBusProgram,
		IO_AddrBusProgram 		=> IO_AddrBusProgram,
		IO_AddrBusReg 			=> IO_AddrBusReg,
		IO_AddrBusMemOutput		=> IO_AddrBusMemOutput,
		IO_ConBusALU 			=> IO_ConBusALU,
		TinyClock				=> TinyClock,
		HugeClock				=> HugeClock,
		ClockCycle				=> ClockCycle);
		
	i_IO_ProgramCode: entity work.IO_ProgramCode(rtl)
	port map(
		IO_DataBusProgram		=> IO_DataBusProgram,
		IO_AddrBusProgram 		=> IO_AddrBusProgram,
		ClockCycle				=> ClockCycle,
		TinyClock  				=> TinyClock);
		
		
	-- CPU --
	i_ALU : entity work.ALU(rtl)
	port map(
		TinyClock   			=> TinyClock,
		ClockCycle   			=> ClockCycle,
		ConBusALU  				=> ConBusALU,
		AddrBusMemInput 		=> AddrBusMemInput,
		DataBusMemInput 		=> DataBusMemInput,
		DataBusReg  			=> DataBusReg,
		NSelOut 				=> NSelOut,
		DataBusMemOutput		=> DataBusMemOutput,
		SkipProgram 			=> SkipProgram,
		TooBigResult			=> TooBigResult);
		
	i_CU : entity work.CU(rtl) 
	port map(
		DataBusProgram		 	=> DataBusProgram,
		AddrBusProgram 			=> AddrBusProgram,
		AddrBusReg 				=> AddrBusReg,
		AddrBusMemInput 		=> AddrBusMemInput,
		AddrBusMemOutput		=> AddrBusMemOutput,
		EnRamInput 				=> EnRamInput,
		EnRamOutput	 			=> EnRamOutput,
		ConBusALU 				=> ConBusALU,
		TinyClock				=> TinyClock,
		HugeClock				=> HugeClock,
		SkipProgram 			=> SkipProgram,
		ClockCycle				=> ClockCycle);
		
	i_ProgramCode: entity work.ProgramCode(rtl)
	port map(
		DataBusProgram			=> DataBusProgram,
		AddrBusProgram 			=> AddrBusProgram,
		ClockCycle				=> ClockCycle,
		TinyClock  				=> TinyClock);
		
	i_Memory : entity work.Memory(rtl)
	port map(
		TinyClock 				=> TinyClock,
		AddrBusMemInput 		=> AddrBusMemInput,
		EnRamInput 				=> EnRamInput,
		AddrBusMemOutput 		=> AddrBusMemOutput,
		EnRamOutput 			=> EnRamOutput,
		AddrBusReg 				=> AddrBusReg,
		DataBusMemInput 		=> DataBusMemInput,
		DataBusReg 				=> DataBusReg,
		DataBusMemOutput 		=> DataBusMemOutput,
		NSelOut 				=> NSelOut,
		IO_AddrBusReg 			=> IO_AddrBusReg,
		IO_AddrBusMemOutput		=> IO_AddrBusMemOutput,
		IO_DataBusReg  			=> IO_DataBusReg,
		IO_DataBusMemOutput		=> IO_DataBusMemOutput,
		IO_NSelOut				=> IO_NSelOut,
		ClockCycle				=> ClockCycle);
	
end architecture;