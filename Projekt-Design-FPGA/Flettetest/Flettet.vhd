library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Flettet is
end  Flettet;

architecture sim of Flettet is

	signal State				: std_logic := '0';

	--CLOCK--
	signal HugeClock			: std_logic;
	signal TinyClock			: std_logic;
	signal ClockCycle			: std_logic_vector(2 downto 0);
	
	signal ActionJackson		: std_logic_vector(4 downto 0);
	signal ShowResult			: std_logic := '0';
	
	--DISPLAY--
	-- Input-værdi til displayet i form af vektor med 8 bits.
	--signal Input				: std_logic_vector (7 downto 0) := (others => '0');
	-- Input-værdi konverteret fra binær til BCD.
	signal DecimalOutput		: std_logic_vector (23 downto 0);
	-- Input-værdi konverteret fra BCD til 7-segment-mønster.
	signal DisplayOutput		: std_logic_vector (41 downto 0);
	
	--DATABUS--
	signal DataBusProgram 	: std_logic_vector(31 downto 0);
	signal DataBusMemInput	: std_logic_vector(7 downto 0);
	signal DataBusReg  		: std_logic_vector(7 downto 0);
	signal DataBusMemOutput	: std_logic_vector(7 downto 0);
	
	--ADRESSEBUS--
	signal AddrBusProgram 	: std_logic_vector(7 downto 0);
	signal AddrBusReg 		: std_logic_vector(4 downto 0);
	signal AddrBusMemInput 	: std_logic_vector(9 downto 0);
	signal AddrBusMemOutput	: std_logic_vector(9 downto 0);

	--RAM/REG--
	signal EnRamInput 		: std_logic;
	signal EnRamOutput 		: std_logic;
	
	--KONTROLBUS--
	signal ConBusALU		: std_logic_vector(4 downto 0);
	signal NSelOut			: std_logic;
	signal SkipProgram 		: std_logic;
	
	--signal Input			: std_logic_vector(7 downto 0);
	signal Input			: std_logic_vector(7 downto 0);
	signal Kage			: std_logic_vector(7 downto 0);
	signal Result			: std_logic_vector(7 downto 0);
	
begin
	
	
	-- Henter clock ind for at kunne reagere på TinyClock.
	i_Clock : entity work.ClockDividerModule(sim)
	port map(
		HugeClock		=> HugeClock,
		TinyClock		=> TinyClock,
		ClockCycle		=> ClockCycle);
	
	--DISPLAY--
	--Binary to Binary-Coded Decimal (BCD)
	i_BCD : entity work.BinaryToBCD(sim)
	port map(
		TinyClock		=> TinyClock,
		--Binary			=> Binary,
		DecimalOutput	=> DecimalOutput,
		ShowResult		=> ShowResult,
		Input 			=> Input,
		Result 			=> Result);
	--Display-driver
	i_Display : entity work.Display(sim)
	port map(
		TinyClock		=> TinyClock,
		DecimalOutput	=> DecimalOutput,
		DisplayOutput 	=> DisplayOutput);
		
	--INPUT--
	--16-knap-matrix driver
	i_Numpad : entity work.Numpad(sim)
	port map(
		TinyClock		=> TinyClock,
		Kage 			=> Kage,
		State			=> State,
		ShowResult		=> ShowResult
		);

	--CPU--
	--ALU
	i_ALU : entity work.ALU(rtl)
	port map(
		TinyClock   	=> TinyClock,
		ClockCycle   	=> ClockCycle,
		ConBusALU  		=> ConBusALU,
		AddrBusMemInput => AddrBusMemInput,
		DataBusMemInput => DataBusMemInput,
		DataBusReg  	=> DataBusReg,
		NSelOut 		=> NSelOut,
		DataBusMemOutput=> DataBusMemOutput,
		SkipProgram 	=>SkipProgram
		);
	--Control unit
	i_CU : entity work.CU(rtl) 
	port map(
		DataBusProgram 	=> DataBusProgram,
		AddrBusProgram 	=> AddrBusProgram,
		AddrBusReg 		=> AddrBusReg,
		AddrBusMemInput => AddrBusMemInput,
		AddrBusMemOutput=> AddrBusMemOutput,
		EnRamInput 		=> EnRamInput,
		EnRamOutput	 	=> EnRamOutput,
		ConBusALU 		=> ConBusALU,
		TinyClock		=> TinyClock,
		HugeClock		=> HugeClock,
		SkipProgram 	=>SkipProgram,
		ClockCycle		=> ClockCycle);
	--Programkode
	i_ProgramCode: entity work.ProgramCode(rtl)
	port map(
		DataBusProgram 	=> DataBusProgram,
		AddrBusProgram 	=> AddrBusProgram,
		ClockCycle		=> ClockCycle,
		TinyClock  		=> TinyClock);
	--Hukommelse
	i_Memory : entity work.Memory(rtl)
	port map(
		TinyClock 		=> TinyClock,
		AddrBusMemInput => AddrBusMemInput,
		EnRamInput 		=> EnRamInput,
		AddrBusMemOutput=> AddrBusMemOutput,
		EnRamOutput 	=> EnRamOutput,
		AddrBusReg 		=> AddrBusReg,
		DataBusMemInput => DataBusMemInput,
		DataBusReg 		=> DataBusReg,
		DataBusMemOutput=> DataBusMemOutput,
		NSelOut 		=> NSelOut,
		ClockCycle		=> ClockCycle,
		Input			=> Input,
		Result			=> Result,
		State			=> State
		);
		
	process (TinyClock) is
	begin
		if (ClockCycle = "111") and (falling_edge(TinyClock)) then
			State <= not State;
		end if;
	end process;
	
	process (Kage) is
	begin
		Input <= Kage;
	end process;
	
end architecture;