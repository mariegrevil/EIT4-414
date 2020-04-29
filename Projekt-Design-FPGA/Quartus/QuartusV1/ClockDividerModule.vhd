library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ClockDividerModule is

	--port( -- Alle port outs initialiseres med 0.
	--Clock			:	in	 std_logic := '0';
	--HugeClock	:	out STD_LOGIC := '0'; -- Clock der er X gange langsommere end tiny clock (her 4).
	--TinyClock	:	out STD_LOGIC := '0'; -- Følger normal clockhastighed (her 10 Hz).
	--ClockCycle	:	out STD_LOGIC_VECTOR(2 downto 0) := "000"); -- Tæller X clockcyklusser for at kunne præcisere hvornår processer skal gå i gang (her 8).
	
end ClockDividerModule;

architecture sim of ClockDividerModule is

	--signal Cycle			:	STD_LOGIC_VECTOR(2 downto 0) := "000"; -- Cyklustælleren starter i 0.
	
	-- KUN TIL TEST --
	-- Skal omdannes til input fra FPGA'ens clock.
	--signal Clock			:	STD_LOGIC := '0'; -- Startværdien for den simulerede clock. 0 gør det nemmere at bruge den første rising edge.
	-- KUN TIL TEST --

	-- KUN TIL TEST --
	-- Skal slettes.
	--constant ClockFrequency	:	integer := 100; -- Frekvens for den simulerede clock (her 10 Hz).
    --constant ClockPeriod	:	time := 1000 ms / ClockFrequency; -- Periodetid for den simulerede clockfrekvens.
	-- KUN TIL TEST --

begin

	-- KUN TIL TEST --
	-- Skal slettes.
	--Clock <= not Clock after ClockPeriod / 2; -- Skifter clocken mellem høj/lav for hver halve periodetid. Dette er den simulerede clock.
	-- KUN TIL TEST --
	
	--process(Clock)
	--begin
		
		--TinyClock <= Clock; -- Den hurtige clock skal bare følge den simulerede clock.
		
		--if rising_edge(Clock) then
			--ClockCycle <= Cycle; -- Cyklusoutputtet opdateres når den simulerede clock ændres.
			--HugeClock <= not Cycle(2); -- Den langsomme clock følger første bit i cyklustælleren.
		--end if;
		--
		--if falling_edge(Clock) then
			--Cycle <= Cycle + 1; --Opdatér den interne cyklustæller ved falling edge for at minimere fejl i output.
		--end if;
	
	--end process;
end sim;