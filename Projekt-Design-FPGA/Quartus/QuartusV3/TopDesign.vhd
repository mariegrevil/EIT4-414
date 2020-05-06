library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity TopDesign is
	port(
	Clock			: in std_logic := '0';
	DisplayOutput 	: out std_logic_vector (41 downto 0);
	Row				: out std_logic_vector (3 downto 0) := (others => '0');
	LED				: out std_logic_vector (9 downto 0);
	Column			: in std_logic_vector (3 downto 0) := (others => '0')
	--HugeClock		: out STD_LOGIC := '0'; -- Clock der er X gange langsommere end tiny clock (her 4).
	--TinyClock		: out STD_LOGIC := '0'; -- Følger normal clockhastighed (her 10 Hz).
	--ClockCycle	: out STD_LOGIC_VECTOR(2 downto 0) := "000"); -- Tæller X clockcyklusser for at kunne præcisere hvornår processer skal gå i gang (her 8).
	);
	
end  TopDesign;

architecture sim of TopDesign is

---------------------------------------------- COMPONENTS
	Component ProgramCode
		 port (TinyClock  		: in std_logic;
				DataBusProgram	: out std_logic_vector(31 downto 0); -- Data on the chosen addres
				AddrBusProgram	: in std_logic_vector(7 downto 0); -- The addres that the CU wants to load
				ClockCycle 		: in std_logic_vector(2 downto 0)); -- Counts rising edges in tinyclock per hugeclock
	End Component;
	
	Component Numpad
	port	(-- Inputs:
			TinyClock		: in std_logic;
			Result			: in std_logic_vector(7 downto 0);
			
			-- Outputs:
			Binary			: out std_logic_vector(7 downto 0); -- Tallet som outputtes til displayet
			IO_TBR			: in std_logic;
			ActionJackson	: buffer std_logic_vector(7 downto 0) := "00000000";
			-- ActionJackson = [SW15, SW11, SW7, SW3, SW14][+, -, *, /, =]
			InputValueOne	: out std_logic_vector(7 downto 0) := (others => '0'); -- Første tal til ALU
			InputValueTwo	: out std_logic_vector(7 downto 0) := (others => '0'); -- Andet tal til ALU
			Row				: out std_logic_vector(3 downto 0);
			LED				: out std_logic_vector (9 downto 0);
			Column			: in std_logic_vector(3 downto 0)
			
			);
	End Component;
	
	
	Component CU
			port (TinyClock : in std_logic;
		  HugeClock 		: in std_logic;
		  ClockCycle 		: in std_logic_vector(2 downto 0); -- Counts rising edges in tinyclock per hugeclock
          DataBusProgram	: in std_logic_vector(31 downto 0); -- Data bus from program code -> what to do (instruktion)
		  AddrBusProgram	: out std_logic_vector(7 downto 0); -- Addr bus to program code -> Where is the instruktion we want to load
		  AddrBusReg		: out std_logic_vector(4 downto 0); -- Addr bus only to reg. -> Where do we want to take data form reg
		  AddrBusMemInput	: out std_logic_vector(9 downto 0); -- Addr bus to ram and reg -> Where do we want to take data form reg or ram
		  AddrBusMemOutput	: out std_logic_vector(9 downto 0); -- Addr bus to ram and reg -> Where do we want to save data in reg or ram
		  EnRamInput	  	: out std_logic; -- ram or reg for "AddrBusMemInput"
		  EnRamOutput  		: out std_logic; -- ram or reg for "AddrBusMemOutput"
		  SkipProgram 		: in std_logic;
		  ConBusALU 		: out std_logic_vector(4 downto 0)); -- Control bus for ALU
	End Component;
	
	
	Component ALU
			port (TinyClock		: in std_logic;
		ClockCycle		: in std_logic_vector(2 downto 0);
		ConBusALU		: in std_logic_vector(4 downto 0); --Control bus for ALU. Tells it what to do. Comes from CU
		
		DataBusMemInput	: in std_logic_vector(7 downto 0); --Data form ram or reg.
		DataBusReg		: in std_logic_vector(7 downto 0); --Data for reg
		AddrBusMemInput	: in std_logic_vector(9 downto 0);
		
		DataBusMemOutput: out std_logic_vector(7 downto 0) := x"00"; -- Data to reg or ram
		
		SkipProgram 	: out std_logic;
		NSelOut			: out std_logic;
		TooBigResult	: out std_logic := '0'
		
		);
	
	End Component;
	
	Component Memory
		port (TinyClock  	: in std_logic;
	
		AddrBusMemInput		: in std_logic_vector(9 downto 0); --Addr bus to ram and reg -> Where do we want to take data form reg or ram
		EnRamInput			: in std_logic; -- Ram or reg
		
		AddrBusMemOutput	: in std_logic_vector(9 downto 0); -- Addr bus to ram and reg -> Where do we want to save data in reg or ram
		EnRamOutput			: in std_logic; -- Ram or reg
		
        AddrBusReg			: in std_logic_vector(4 downto 0); -- Addr bus only to reg. -> Where do we want to take data form reg
		NSelOut				: in std_logic;
		TooBigResult		: in std_logic;
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
		
	End Component;
	
	
	Component Display
		port	(TinyClock		: in std_logic;
				-- Input i form af BCD.
				DecimalOutput	: in std_logic_vector (23 downto 0);
				-- Output i form a 7-segment-mønstre.
				DisplayOutput 	: out std_logic_vector(41 downto 0)
				);
	
	End Component;

	Component BinaryToBCD
		port   (TinyClock		: in std_logic;
				Binary			: in std_logic_vector (7 downto 0); -- Konverteringens input.

				DecimalOutput	: out std_logic_vector (23 downto 0) := (others => '0'); -- Konverteringens resultat.
			
				ActionJackson	: in std_logic_vector (7 downto 0)
			);
	
	End Component;

	--Component ClockDividerModule
		--port( -- Alle port outs initialiseres med 0.
		--Clock			:	in	 std_logic;
		--HugeClock	:	out STD_LOGIC := '0'; -- Clock der er X gange langsommere end tiny clock (her 4).
		--TinyClock	:	out STD_LOGIC := '0'; -- Følger normal clockhastighed (her 10 Hz).
		--ClockCycle	:	out STD_LOGIC_VECTOR(2 downto 0) := "000"); -- Tæller X clockcyklusser for at kunne præcisere hvornår processer skal gå i gang (her 8).
	
	--End Component;
	
	component IO_CU
	 port (TinyClock  			: in std_logic;
		  HugeClock 			: in std_logic;
		  ClockCycle 			: in std_logic_vector(2 downto 0); -- Counts rising edges in tinyclock per hugeclock
          IO_DataBusProgram		: in std_logic_vector(31 downto 0); -- Data bus from program code -> what to do (instruktion)
		  IO_AddrBusProgram		: out std_logic_vector(7 downto 0); -- Addr bus to program code -> Where is the instruktion we want to load
		  IO_AddrBusReg			: out std_logic_vector(4 downto 0); -- Addr bus only to reg. -> Where do we want to take data form reg
		  IO_AddrBusMemOutput	: out std_logic_vector(9 downto 0); -- Addr bus to ram and reg -> Where do we want to save data in reg or ram
		  IO_ConBusALU 			: out std_logic_vector(4 downto 0)); -- Control bus for ALU
end component;

component IO_ALU 
	 port (TinyClock			: in std_logic;
		  ClockCycle			: in std_logic_vector(2 downto 0);
		  IO_ConBusALU			: in std_logic_vector(4 downto 0); --Control bus for ALU. Tells it what to do. Comes from CU
		  IO_DataBusReg			: in std_logic_vector(7 downto 0); --Data for reg
		  IO_DataBusMemOutput	: out std_logic_vector(7 downto 0) := x"00"; -- Data to reg
		  IO_NSelOut			: out std_logic;
		
		  -- I/O --
		  ActionJackson			: in std_logic_vector(7 downto 0);
		  InputValueOne			: in std_logic_vector(7 downto 0);
		  InputValueTwo			: in std_logic_vector(7 downto 0);
		  Result				: out std_logic_vector(7 downto 0) := (others => '0');
		  IO_TBR				: out std_logic);
end component;

component IO_ProgramCode
	 port (TinyClock  			: in std_logic;
          IO_DataBusProgram		: out std_logic_vector(31 downto 0); -- Data on the chosen addres
		  IO_AddrBusProgram		: in std_logic_vector(7 downto 0); -- The addres that the CU wants to load
		  ClockCycle 			: in std_logic_vector(2 downto 0)); -- Counts rising edges in tinyclock per hugeclock
end component;

---------------------------------------------- SIGNALS
	-- CLOCK --
	signal HugeClock			: std_logic;
	signal TinyClock			: std_logic;
	signal ClockCycle			: std_logic_vector(2 downto 0);
	--signal Clock				: std_logic;
	signal Cycle				: std_logic_vector(2 downto 0) := "000"; -- Cyklustælleren starter i 0.
	signal ClockCnt				: std_logic_vector(22 downto 0) := "00000000000000000000000"; -- to scale down clcok speed
	
	
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
	--signal DisplayOutput		: std_logic_vector (41 downto 0);
	
	-- IO Adressebusser
	signal IO_AddrBusProgram 	: std_logic_vector(7 downto 0);
	signal IO_AddrBusReg 		: std_logic_vector(4 downto 0);
	signal IO_AddrBusMemOutput	: std_logic_vector(9 downto 0);
	
	-- Databusser
	signal IO_DataBusProgram 	: std_logic_vector(31 downto 0);
	signal IO_DataBusReg  		: std_logic_vector(7 downto 0);
	signal IO_DataBusMemOutput	: std_logic_vector(7 downto 0);
	
	
	-- IO Kontrolbusser
	signal IO_ConBusALU			: std_logic_vector(4 downto 0);
	signal IO_NSelOut			: std_logic;
	signal IO_TBR				: std_logic := '0';
	
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

---------------------------------------------- INSTANCE
begin	
	-- Debug: ActionJackson --> LEDS
	LED <= "00" & ActionJackson;

	-- CLOCK --
	--i_Clock : ClockDividerModule
	--port map(
		--HugeClock				=> HugeClock,
		--TinyClock				=> TinyClock,
		--Clock 				=> Clock,
		--ClockCycle			=> ClockCycle);
	
	-- I/O --
	i_BCD : BinaryToBCD
	port map(
		TinyClock				=> TinyClock,
		Binary					=> Binary,
		DecimalOutput			=> DecimalOutput,
		ActionJackson			=> ActionJackson);
		
	i_Display : Display
	port map(
		TinyClock				=> TinyClock,
		DecimalOutput			=> DecimalOutput,
		DisplayOutput 			=> DisplayOutput);
		
	i_Numpad : Numpad
	port map(
		TinyClock				=> TinyClock,
		Binary 					=> Binary,
		ActionJackson			=> ActionJackson,
		InputValueOne			=> InputValueOne,
		InputValueTwo			=> InputValueTwo,
		IO_TBR					=> IO_TBR,
		Result					=> Result,
		Row						=> Row,
		Column					=> Column
		);
	
	i_IO_ALU : IO_ALU
	port map(
		TinyClock   			=> TinyClock,
		ClockCycle   			=> ClockCycle,
		IO_ConBusALU  			=> IO_ConBusALU,
		IO_DataBusReg  			=> IO_DataBusReg,
		IO_NSelOut 				=> IO_NSelOut,
		IO_DataBusMemOutput		=> IO_DataBusMemOutput,
		IO_TBR					=> IO_TBR,
		ActionJackson			=> ActionJackson,
		InputValueOne			=> InputValueOne,
		InputValueTwo			=> InputValueTwo,
		Result					=> Result);
		
	i_IO_CU : IO_CU
	port map(
		IO_DataBusProgram		=> IO_DataBusProgram,
		IO_AddrBusProgram 		=> IO_AddrBusProgram,
		IO_AddrBusReg 			=> IO_AddrBusReg,
		IO_AddrBusMemOutput		=> IO_AddrBusMemOutput,
		IO_ConBusALU 			=> IO_ConBusALU,
		TinyClock				=> TinyClock,
		HugeClock				=> HugeClock,
		ClockCycle				=> ClockCycle);
		
	i_IO_ProgramCode: IO_ProgramCode
	port map(
		IO_DataBusProgram		=> IO_DataBusProgram,
		IO_AddrBusProgram 		=> IO_AddrBusProgram,
		ClockCycle				=> ClockCycle,
		TinyClock  				=> TinyClock);
		
		
	-- CPU --
	i_ALU : ALU
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
		
	i_CU : CU
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
		
	i_ProgramCode: ProgramCode
	port map(
		DataBusProgram			=> DataBusProgram,
		AddrBusProgram 			=> AddrBusProgram,
		ClockCycle				=> ClockCycle,
		TinyClock  				=> TinyClock);
		
	i_Memory : Memory
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
		TooBigResult			=> TooBigResult,
		IO_AddrBusReg 			=> IO_AddrBusReg,
		IO_AddrBusMemOutput		=> IO_AddrBusMemOutput,
		IO_DataBusReg  			=> IO_DataBusReg,
		IO_DataBusMemOutput		=> IO_DataBusMemOutput,
		IO_NSelOut				=> IO_NSelOut,
		ClockCycle				=> ClockCycle);
		
	process(Clock)
	begin
	
		if  rising_edge(Clock) then
			ClockCnt <= ClockCnt + 1;
		end if;
		
		TinyClock <= ClockCnt(10); -- 97kHz
		
		if rising_edge(ClockCnt(10)) then
			ClockCycle <= Cycle; -- Cyklusoutputtet opdateres når den simulerede clock ændres.
			HugeClock <= not Cycle(2); -- Den langsomme clock følger første bit i cyklustælleren.
		end if;
		
		if falling_edge(ClockCnt(10)) then
			Cycle <= Cycle + 1; --Opdatér den interne cyklustæller ved falling edge for at minimere fejl i output.
		end if;
	
	end process;
	
end architecture;