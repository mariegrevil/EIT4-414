library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BinaryToBCD is
	port   (TinyClock		: in std_logic;
			Binary			: in std_logic_vector (7 downto 0);
			
			DecimalOutput	: out std_logic_vector (23 downto 0)
			);
end  BinaryToBCD;

architecture sim of BinaryToBCD is

	-- signal TinyClock			: std_logic;
	-- signal HugeClock			: std_logic;
	-- signal ClockCycle			: std_logic_vector(2 downto 0);
	
	-- Input-værdi i form af vektor med 8 bits.
	--signal Binary				: std_logic_vector (7 downto 0) := (others => '0');
	
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
	
	signal FirstDigit			: boolean := false;
	
begin

	-- i_Clock : entity work.ClockDividerModule(sim)
	-- port map(
		-- HugeClock		=> HugeClock,
		-- TinyClock		=> TinyClock,
		-- ClockCycle		=> ClockCycle);
	
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
				FirstDigit <= false;
			end if;
		end if;
		
		-- Kører for hvert clock-tick, så længe processen er i gang.
		if (Busy) and (rising_edge(TinyClock)) then

			-- Udfører forskellige trin i konverteringen for hvert tick.
			case ConvProgress is
				when "000" =>
					if (Scratchpad >= 100000) then -- Hvis Scratchpad har 3 cifre...
						-- Gemmer floor(Scratchpad / 100) på 3. cifferplads.
						Decimal(5) <= std_logic_vector(to_unsigned(Scratchpad / 100000, Decimal(5)'length));
						-- Beregner hvad der vil være tilbage efter Scratchpad - floor(Scratchpad / 100) og opdaterer sig selv.
						Scratchpad <= Scratchpad rem 100000;
						FirstDigit <= true;
					elsif (FirstDigit) then
						Decimal(5) <= "0000";
					end if;
				when "001" =>
					if (Scratchpad >= 10000) then -- Hvis Scratchpad har 3 cifre...
						-- Gemmer floor(Scratchpad / 100) på 3. cifferplads.
						Decimal(4) <= std_logic_vector(to_unsigned(Scratchpad / 10000, Decimal(4)'length));
						-- Beregner hvad der vil være tilbage efter Scratchpad - floor(Scratchpad / 100) og opdaterer sig selv.
						Scratchpad <= Scratchpad rem 10000;
						FirstDigit <= true;
					elsif (FirstDigit) then
						Decimal(4) <= "0000";
					end if;
				when "010" =>
					if (Scratchpad >= 1000) then -- Hvis Scratchpad har 3 cifre...
						-- Gemmer floor(Scratchpad / 100) på 3. cifferplads.
						Decimal(3) <= std_logic_vector(to_unsigned(Scratchpad / 1000, Decimal(3)'length));
						-- Beregner hvad der vil være tilbage efter Scratchpad - floor(Scratchpad / 100) og opdaterer sig selv.
						Scratchpad <= Scratchpad rem 1000;
						FirstDigit <= true;
					elsif (FirstDigit) then
						Decimal(3) <= "0000";
					end if;
				when "011" =>
					if (Scratchpad >= 100) then -- Hvis Scratchpad har 3 cifre...
						-- Gemmer floor(Scratchpad / 100) på 3. cifferplads.
						Decimal(2) <= std_logic_vector(to_unsigned(Scratchpad / 100, Decimal(2)'length));
						-- Beregner hvad der vil være tilbage efter Scratchpad - floor(Scratchpad / 100) og opdaterer sig selv.
						Scratchpad <= Scratchpad rem 100;
						FirstDigit <= true;
					elsif (FirstDigit) then
						Decimal(2) <= "0000";
					end if;
				when "100" =>
					if (Scratchpad >= 10) then -- Hvis Scratchpad har 2 cifre...
						-- Gemmer floor(Scratchpad / 10) på 2. cifferplads.
						Decimal(1) <= std_logic_vector(to_unsigned(Scratchpad / 10, Decimal(1)'length));
						-- Beregner hvad der vil være tilbage efter Scratchpad - floor(Scratchpad / 100) og opdaterer sig selv.
						Scratchpad <= Scratchpad rem 10;
						FirstDigit <= true;
					elsif (FirstDigit) then
						Decimal(1) <= "0000";
					end if;
				when "101" =>
					if (Scratchpad >= 1) then -- Hvis Scratchpad er større end 0...
						-- Gemmer Scratchpad på 1. cifferplads.
						Decimal(0) <= std_logic_vector(to_unsigned(Scratchpad, Decimal(0)'length));
					elsif (FirstDigit) then
						Decimal(0) <= "0000";
					end if;
				when others =>
					-- Når der ikke er flere trin tilbage, så afsluttes processen.
					Busy <= false;
					DecimalOutput <= Decimal(5) & Decimal(4) & Decimal(3) & Decimal(2) & Decimal(1) & Decimal(0);
			end case;
			
			-- Der lægges 1 til procestælleren for hvert trin der udføres.
			ConvProgress <= std_logic_vector(to_unsigned(to_integer(unsigned(ConvProgress)) + 1, ConvProgress'length));
			
		end if;

	end process;
	

	
end architecture;