library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity KeypadTest is
	port(
	Clk			:	in	 std_logic := '0';
	Row			: buffer std_logic_vector (3 downto 0) := (others => '0');
	Column		: buffer std_logic_vector (3 downto 0);
	LED0			: out std_logic := '0';
	LED1			: out std_logic := '0';
	LED2			: out std_logic := '0';
	LED3			: out	std_logic := '0';
	LED4			: out std_logic := '0';
	LED5			: out std_logic := '0';
	LED6			: out std_logic := '0';
	LED7			: out std_logic := '0';
	LED8			: out std_logic := '0';
	LED9			: out std_logic := '0'
	--HugeClock	:	out STD_LOGIC := '0'; -- Clock der er X gange langsommere end tiny clock (her 4).
	--TinyClock	:	out STD_LOGIC := '0'; -- Følger normal clockhastighed (her 10 Hz).
	--ClockCycle	:	out STD_LOGIC_VECTOR(2 downto 0) := "000"); -- Tæller X clockcyklusser for at kunne præcisere hvornår processer skal gå i gang (her 8).
	);
	
end  KeypadTest;

architecture sim of KeypadTest is

---------------------------------------------- COMPONENTS

	Component Numpad
		port	(-- Inputs:
			TinyClock		: in std_logic;
			Row			: buffer std_logic_vector(3 downto 0);
			Column		: buffer std_logic_vector(3 downto 0);
			LED0			: out std_logic;
			LED1			: out std_logic;
			LED2			: out std_logic;
			LED3			: out std_logic;
			LED4			: out std_logic
			);
	End Component;
	
	

---------------------------------------------- SIGNALS
	-- CLOCK --
	signal HugeClock			: std_logic;
	signal TinyClock			: std_logic;
	signal ClockCycle			: std_logic_vector(2 downto 0);
	--signal Clock				: std_logic;
	signal Cycle				:	STD_LOGIC_VECTOR(2 downto 0) := "000"; -- Cyklustælleren starter i 0.
	signal ClockCnt			: std_logic_vector(23 downto 0) := "000000000000000000000000"; -- to scale down clcok speed
	
	
	-- I/O --
	-- Input-værdi til displayet i form af vektor med 8 bits.
	-- Input-værdi konverteret fra BCD til 7-segment-mønster.
	--signal DisplayOutput		: std_logic_vector (41 downto 0);
	
	
---------------------------------------------- INSTANCE
begin	

	i_Numpad : Numpad
	port map(
		TinyClock				=> TinyClock,
		Row						=> Row,
		Column					=> Column,
		LED0						=> LED0,
		LED1						=> LED1,
		LED2						=> LED2,
		LED3						=> LED3,
		LED4						=> LED4
		);

		
		


	process(Clk)
	begin
	
		if  rising_edge(Clk) then
			ClockCnt <= ClockCnt + 1;
		end if;
		
		TinyClock <= ClockCnt(22); -- 128 del af den orginale hastighed
		LED5 <= TinyClock;
		LED6 <= HugeClock;
		
		if rising_edge(TinyClock) then
			ClockCycle <= Cycle; -- Cyklusoutputtet opdateres når den simulerede clock ændres.
			HugeClock <= not Cycle(2); -- Den langsomme clock følger første bit i cyklustælleren.
		end if;
		
		if falling_edge(TinyClock) then
			Cycle <= Cycle + 1; --Opdatér den interne cyklustæller ved falling edge for at minimere fejl i output.
		end if;
	
	end process;
	
end architecture;