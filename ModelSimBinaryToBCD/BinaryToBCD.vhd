library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use IEEE.std_logic_unsigned.all;

entity BinaryToBCD is
end  BinaryToBCD;

architecture sim of BinaryToBCD is

	-- Importerer clock fra clock-modulet.
	signal HugeClock			: std_logic;
	signal TinyClock			: std_logic;
	signal ClockCycle			: std_logic_vector(2 downto 0);
	
	-- Input-værdi i form af vektor med 8 bits.
	signal Binary				: std_logic_vector (7 downto 0) := (others => '0');
	
	-- Output-værdi i form af 3D-vektor. Der er 6 pladser med hver 4 bits.
	type BCD is array (5 downto 0) of std_logic_vector (3 downto 0);
	signal Decimal				: BCD := (0 => (others => '0'), -- Højre plads = x0.
										  others => (others => '1')); -- Alle andre pladser = x15.
	
	-- Holder den sidst konverterede værdi for at tjekke om input har ændret sig.
	signal CurrentValue			: integer := 0;
	-- Integer til udregning undervejs i konvertering.
	signal Scratchpad			: integer := 0;
	
	-- Hvis konverteringsprocessen allerede er i gang, så må nyt input ikke afbryde den.
	signal Busy					: boolean := false;
	signal Waiting				: boolean := false;
	-- Tæller nuværende trin i konverteringsprocessen.
	signal ConvProgress			: std_logic_vector(2 downto 0) := (others => '0');
	
begin
	
	-- Henter clock ind for at kunne reagere på TinyClock.
	i_Clock : entity work.ClockDividerModule(sim)
	port map(
		HugeClock		=> HugeClock,
		TinyClock		=> TinyClock,
		ClockCycle		=> ClockCycle);
	
	-- Modulets hovedproces. Den tjekker både om input har ændret sig, og den konverterer til BCD.
	process (Busy, TinyClock, Binary) is
	begin
		
		-- Inputtet må ikke gå tabt bare fordi modulet allerede er i gang.
		if (Binary'event) and (Busy) then
			-- Det registreres at et input venter på konvertering.
			Waiting <= true;
		end if;
		
		-- Hvis inputtet ændrer sig (ELLER et input ligger i kø) og modulet ikke er i gang, så starter det.
		if ((Binary'event) or (Waiting)) and (not Busy) then
			if (to_integer(unsigned(Binary)) /= CurrentValue) then
				Busy <= true; -- Processen er nu sat i gang.
				Waiting <= false; -- Køen nulstilles.
				ConvProgress <= (others => '0'); -- Procestælleren nulstilles.
				CurrentValue <= to_integer(unsigned(Binary)); -- Gemmer den nuværende input-værdi til senere sammenligning.
				Scratchpad <= to_integer(unsigned(Binary)); -- Gemmer også den nuværende input-værdi til beregninger.
				-- Output nulstilles.
				Decimal <= (0 => (others => '0'), -- Højre plads = x0.
							others => (others => '1')); -- Alle andre pladser = x15.
			end if;
		end if;
		
		-- Kører for hvert clock-tick, så længe processen er i gang.
		if (Busy) and (rising_edge(TinyClock)) then

			-- Udfører forskellige trin i konverteringen for hvert tick.
			case ConvProgress is
				when "000" =>
					if (Scratchpad >= 100) then -- Hvis Scratchpad har 3 cifre...
						-- Gemmer floor(Scratchpad / 100) på 3. cifferplads.
						Decimal(2) <= std_logic_vector(to_unsigned(Scratchpad / 100, Decimal(2)'length));
						-- Beregner hvad der vil være tilbage efter Scratchpad - floor(Scratchpad / 100) og opdaterer sig selv.
						Scratchpad <= Scratchpad rem 100;
					end if;
				when "001" =>
					if (Scratchpad >= 10) then -- Hvis Scratchpad har 2 cifre...
						-- Gemmer floor(Scratchpad / 10) på 2. cifferplads.
						Decimal(1) <= std_logic_vector(to_unsigned(Scratchpad / 10, Decimal(1)'length));
						-- Beregner hvad der vil være tilbage efter Scratchpad - floor(Scratchpad / 100) og opdaterer sig selv.
						Scratchpad <= Scratchpad rem 10;
					end if;
				when "010" =>
					if (Scratchpad >= 1) then -- Hvis Scratchpad er større end 0...
						-- Gemmer Scratchpad på 1. cifferplads.
						Decimal(0) <= std_logic_vector(to_unsigned(Scratchpad, Decimal(0)'length));
					end if;
				when others =>
					-- Når der ikke er flere trin tilbage, så afsluttes processen.
					Busy <= false;
			end case;
			
			-- Der lægges 1 til procestælleren for hvert trin der udføres.
			ConvProgress <= std_logic_vector(to_unsigned(to_integer(unsigned(ConvProgress)) + 1, ConvProgress'length));
			
		end if;

	end process;
	
	-- Testproces. Får input til at ændre sig med et fast interval for at se om systemet kan følge med.
	process is
	begin

		Binary <= std_logic_vector(to_unsigned(to_integer(unsigned(Binary)) + 1, Binary'length));
		
		wait for 1700 ms;
		
		Binary <= std_logic_vector(to_unsigned(to_integer(unsigned(Binary)) + 1, Binary'length));
		
		wait for 250 ms;
		
		if Binary = "11111111" then
			wait;
		end if;
	
	end process;
	
end architecture;