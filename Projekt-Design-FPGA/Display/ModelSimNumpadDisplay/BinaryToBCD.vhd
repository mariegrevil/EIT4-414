library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BinaryToBCD is
	port   (TinyClock		: in std_logic;
			Binary			: in std_logic_vector (7 downto 0); -- Konverteringens input.
			DecimalOutput	: out std_logic_vector (23 downto 0) -- Konverteringens resultat.
			);
end  BinaryToBCD;

architecture sim of BinaryToBCD is
	
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
	
	-- Fortæller hvor første ciffer i tallet er fundet.
	signal FirstDigit			: integer := 0; 
	-- Fortæller om tallet er negativt.
	signal Minus 				: Boolean := false;
	
begin

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
			-- Igangsættes kun hvis inputværdien har ændret sig.
			if (to_integer(signed(Binary)) /= CurrentValue) then
				Busy <= true; -- Processen er nu sat i gang.
				Waiting <= false; -- Køen nulstilles.
				ConvProgress <= (others => '0'); -- Procestælleren nulstilles.
				CurrentValue <= to_integer(signed(Binary)); -- Gemmer den nuværende input-værdi til senere sammenligning.
				Scratchpad <= to_integer(signed(Binary)); -- Gemmer også den nuværende input-værdi til beregninger.
				-- Output nulstilles.
				Decimal <= (0 => (others => '0'), -- Højre plads = x0.
							others => (others => '1')); -- Alle andre pladser = x15.
				FirstDigit <= 0; --false; -- Nulstiller registrering af første ciffer.
				Minus <= false; 
			end if;
		end if;
		
		-- Kører for hvert clock-tick, så længe processen er i gang.
		if (Busy) and (rising_edge(TinyClock)) then

			-- Udfører forskellige trin i konverteringen for hvert tick.
			case ConvProgress is
				when "000" => -- Hvis tallet er negativt sættes Scratchpad til positiv og minus bitten bliver flippet.
					if (Scratchpad < 0) then 
						Scratchpad <= Scratchpad * (-1);
						Minus <= true; 
					end if;
					
				when "001" =>
					if (Scratchpad >= 10000) then -- Hvis Scratchpad har 3 cifre...
						-- Gemmer floor(Scratchpad / 100) på 3. cifferplads.
						Decimal(4) <= std_logic_vector(to_unsigned(Scratchpad / 10000, Decimal(4)'length));
						-- Beregner hvad der vil være tilbage efter Scratchpad - floor(Scratchpad / 100) og opdaterer sig selv.
						Scratchpad <= Scratchpad rem 10000;
						FirstDigit <= 4;--true; -- Registrerer at vi er stødt på første ciffer i tallet.
					elsif (FirstDigit > 0) then
						Decimal(4) <= "0000"; -- Hvis der står 0 på pladsen, så virker ovenstående beregning ikke. Sæt pladsen til 0, hvis første ciffer er fundet.
					end if;
				when "010" =>
					if (Scratchpad >= 1000) then -- Hvis Scratchpad har 3 cifre...
						-- Gemmer floor(Scratchpad / 100) på 3. cifferplads.
						Decimal(3) <= std_logic_vector(to_unsigned(Scratchpad / 1000, Decimal(3)'length));
						-- Beregner hvad der vil være tilbage efter Scratchpad - floor(Scratchpad / 100) og opdaterer sig selv.
						Scratchpad <= Scratchpad rem 1000;
						FirstDigit <= 3;--true; -- Registrerer at vi er stødt på første ciffer i tallet.
					elsif (FirstDigit > 0) then
						Decimal(3) <= "0000"; -- Hvis der står 0 på pladsen, så virker ovenstående beregning ikke. Sæt pladsen til 0, hvis første ciffer er fundet.
					end if;
				when "011" =>
					if (Scratchpad >= 100) then -- Hvis Scratchpad har 3 cifre...
						-- Gemmer floor(Scratchpad / 100) på 3. cifferplads.
						Decimal(2) <= std_logic_vector(to_unsigned(Scratchpad / 100, Decimal(2)'length));
						-- Beregner hvad der vil være tilbage efter Scratchpad - floor(Scratchpad / 100) og opdaterer sig selv.
						Scratchpad <= Scratchpad rem 100;
						FirstDigit <= 2;--true; -- Registrerer at vi er stødt på første ciffer i tallet.
					elsif (FirstDigit > 0) then
						Decimal(2) <= "0000"; -- Hvis der står 0 på pladsen, så virker ovenstående beregning ikke. Sæt pladsen til 0, hvis første ciffer er fundet.
					end if;
				when "100" =>
					if (Scratchpad >= 10) then -- Hvis Scratchpad har 2 cifre...
						-- Gemmer floor(Scratchpad / 10) på 2. cifferplads.
						Decimal(1) <= std_logic_vector(to_unsigned(Scratchpad / 10, Decimal(1)'length));
						-- Beregner hvad der vil være tilbage efter Scratchpad - floor(Scratchpad / 100) og opdaterer sig selv.
						Scratchpad <= Scratchpad rem 10;
						FirstDigit <= 1;--true; -- Registrerer at vi er stødt på første ciffer i tallet.
					elsif (FirstDigit > 0) then
						Decimal(1) <= "0000"; -- Hvis der står 0 på pladsen, så virker ovenstående beregning ikke. Sæt pladsen til 0, hvis første ciffer er fundet.
					end if;
				when "101" =>
					if (Scratchpad >= 1) then -- Hvis Scratchpad er større end 0...
						-- Gemmer Scratchpad på 1. cifferplads.
						Decimal(0) <= std_logic_vector(to_unsigned(Scratchpad, Decimal(0)'length));
					elsif (FirstDigit > 0) then
						Decimal(0) <= "0000";
					end if;
					
				when "110" =>
					if (Minus) then  -- Tegner minus tegnet, hvis tallet er negativt. 
						Decimal(FirstDigit + 1) <= "1110"; -- 14 indikerer minus.
					end if;
					
				when others =>
					-- Når der ikke er flere trin tilbage, så afsluttes processen...
					Busy <= false;
					-- ...og de beregnede cifre sendes til output.
					DecimalOutput <= Decimal(5) & Decimal(4) & Decimal(3) & Decimal(2) & Decimal(1) & Decimal(0);
			end case;
			
			-- Der lægges 1 til procestælleren for hvert trin der udføres.
			ConvProgress <= std_logic_vector(to_unsigned(to_integer(unsigned(ConvProgress)) + 1, ConvProgress'length));
			
		end if;

	end process;
	

	
end architecture;