library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Numpad is
	port	(-- Inputs:
			TinyClock		: in std_logic;
			
			-- Outputs:
			Binary			: out std_logic_vector(7 downto 0); -- Tallet som outputtes til displayet
			ActionJackson	: out std_logic_vector(4 downto 0); -- ActionJackson = [SW14, SW3, SW7, SW11, SW15] = [=, /, *, -, +] -- (=) = ActionJackson(0), ..., (+) = ActionJackson(4)
			DisplayValueOne	: out std_logic_vector(7 downto 0); -- Første tal til ALU
			DisplayValueTwo	: out std_logic_vector(7 downto 0) -- Andet tal til ALU
			);

end  Numpad;

architecture sim of Numpad is

	signal Row			: std_logic_vector(3 downto 0) := (others => '0');
	signal Column		: std_logic_vector(3 downto 0) := (others => '0');
	signal DisplayValue	: integer := 0; -- Bruges til at holde en integer værdi af det der står på displayet nu
	
	-- KUN TIL TEST
	signal TestButton	: std_logic_vector(15 downto 0) := (others => '0');
	signal Counter		: integer := 0;
	
begin

	process (TinyClock) is
	begin
	
		if (rising_edge(TinyClock)) then
			Row <= (others => '0');
			Row(Counter) <= '1';
		elsif (falling_edge(TinyClock)) then
			if (Counter < 3) then
				Counter <= Counter + 1;
			else
				Counter <= 0;
			end if;
		end if;

		Binary <= std_logic_vector(to_unsigned(DisplayValue, Binary'length));
		
	end process;
	
	process (Row) is
	begin
		Column <= (others => '0');
		for i in 0 to 15 loop
			
			if (TestButton(i) = '1') then
				Column(i rem 4) <= Row(i / 4);
			end if;

		end loop;
	
	end process;
	
	
	-- Hvilken knap skal gøre hvad:
	process (Column, Row)
	begin
		case Row is
				when "0001" =>  -- When Row 0 er high
					case Column is
						when "0001" =>  -- When Column 0 er high
							-- Hvad skal der sker ved tryk på SW0 - 7 knap
							if (DisplayValue = 0) then -- Hvis display er 0
								DisplayValue <= DisplayValue + 7;
							elsif (DisplayValue < 25) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
								DisplayValue <= DisplayValue * 10;
								DisplayValue <= DisplayValue + 7;
							else
							end if;
							
						when "0010" =>  -- When Column 1 er high
							-- Hvad skal der sker ved tryk på SW1 - 8 knap
							if (DisplayValue = 0) then -- Hvis display er 0
								DisplayValue <= DisplayValue + 8;
							elsif (DisplayValue < 25) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
								DisplayValue <= DisplayValue * 10;
								DisplayValue <= DisplayValue + 8;
							else
							end if;
							
						when "0100" =>  -- When Column 2 er high
							-- Hvad skal der sker ved tryk på SW2 - 9 knap
							if (DisplayValue = 0) then -- Hvis display er 0
								DisplayValue <= DisplayValue + 9;
							elsif (DisplayValue < 25) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
								DisplayValue <= DisplayValue * 10;
								DisplayValue <= DisplayValue + 9;
							else
							end if;
							
						when "1000" =>  -- When Column 3 er high
							-- Hvad skal der sker ved tryk på SW3 - Divider(/) knap
							-- Her skal dividere funktionen skrives
							if (ActionJackson = "00000") then
								ActionJackson(2) <= '1';
								DisplayValueOne <= std_logic_vector(to_unsigned(DisplayValue, DisplayValueOne'length));;
								DisplayValue <= 0;
							
							else
								DisplayValue <= 0; -- Nulstil display til 0
								ActionJackson <= "00000"; -- Nulstil ActionJackson til alle slukkede bits
							
							end if;
							
						when others => 
					end case;
					
				when "0010" =>  -- When Row 1 er high
					case Column is
						when "0001" =>  -- When Column 0 er high
							-- Hvad skal der sker ved tryk på SW4 - 4 knap
							if (DisplayValue = 0) then -- Hvis display er 0
								DisplayValue <= DisplayValue + 4;
							elsif (DisplayValue < 26) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
								DisplayValue <= DisplayValue * 10;
								DisplayValue <= DisplayValue + 4;
							else
							end if;
							
						when "0010" =>  -- When Column 1 er high
							-- Hvad skal der sker ved tryk på SW5 - 5 knap
							if (DisplayValue = 0) then -- Hvis display er 0
								DisplayValue <= DisplayValue + 5;
							elsif (DisplayValue < 26) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
								DisplayValue <= DisplayValue * 10;
								DisplayValue <= DisplayValue + 5;
							else
							end if;
							
						when "0100" =>  -- When Column 2 er high
							-- Hvad skal der sker ved tryk på SW6 - 6 knap
							if (DisplayValue = 0) then -- Hvis display er 0
								DisplayValue <= DisplayValue + 6;
							elsif (DisplayValue < 25) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
								DisplayValue <= DisplayValue * 10;
								DisplayValue <= DisplayValue + 6;
							else
							end if;
							
						when "1000" =>  -- When Column 3 er high
							-- Hvad skal der sker ved tryk på SW7 - Gange(*) knap
							-- Her skal gange funktionen skrives
							if (ActionJackson = "00000") then
								ActionJackson(2) <= '1';
								DisplayValueOne <= std_logic_vector(to_unsigned(DisplayValue, DisplayValueOne'length));;
								DisplayValue <= 0;
							
							else
								DisplayValue <= 0; -- Nulstil display til 0
								ActionJackson <= "00000"; -- Nulstil ActionJackson til alle slukkede bits
							
							end if;
							
						when others => 
					end case;
					
				when "0100" =>  -- When Row 2 er high
					case Column is
						when "0001" =>  -- When Column 0 er high
							-- Hvad skal der sker ved tryk på SW8 - 1 knap
							if (DisplayValue = 0) then -- Hvis display er 0
								DisplayValue <= DisplayValue + 1;
							elsif (DisplayValue < 26) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
								DisplayValue <= DisplayValue * 10;
								DisplayValue <= DisplayValue + 1;
							else
							end if;
							
						when "0010" =>  -- When Column 1 er high
							-- Hvad skal der sker ved tryk på SW9 - 2 knap
							if (DisplayValue = 0) then -- Hvis display er 0
								DisplayValue <= DisplayValue + 2;
							elsif (DisplayValue < 26) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
								DisplayValue <= DisplayValue * 10;
								DisplayValue <= DisplayValue + 2;
							else
							end if;
							
						when "0100" =>  -- When Column 2 er high
							-- Hvad skal der sker ved tryk på SW10 - 3 knap
							if (DisplayValue = 0) then -- Hvis display er 0
								DisplayValue <= DisplayValue + 3;
							elsif (DisplayValue < 26) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
								DisplayValue <= DisplayValue * 10;
								DisplayValue <= DisplayValue + 3;
							else
							end if;
							
						when "1000" =>  -- When Column 3 er high
							-- Hvad skal der sker ved tryk på SW11 - Minus(-) knap
							-- Her skal minus funktionen skrives
							if (ActionJackson = "00000") then
								ActionJackson(3) <= '1';
								DisplayValueOne <= std_logic_vector(to_unsigned(DisplayValue, DisplayValueOne'length));;
								DisplayValue <= 0;
							
							else
								DisplayValue <= 0; -- Nulstil display til 0
								ActionJackson <= "00000"; -- Nulstil ActionJackson til alle slukkede bits
							
							end if;
							
						when others => 
					end case;
					
				when "1000" =>  -- When Row 3 er high
					case Column is
						when "0001" =>  -- When Column 0 er high
							-- Hvad skal der sker ved tryk på SW12 - Clear knap
							DisplayValue <= 0; -- Nulstil display til 0
							ActionJackson <= "00000"; -- Nulstil ActionJackson til alle slukkede bits
							
						when "0010" =>  -- When Column 1 er high
							-- Hvad skal der sker ved tryk på SW13 - 0 knap
							if (DisplayValue = 0) then -- Hvis display er 0
								DisplayValue <= DisplayValue + 0;
							elsif (DisplayValue < 26) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
								DisplayValue <= DisplayValue * 10;
							else;
							end if;
							
						when "0100" =>  -- When Column 2 er high
							-- Hvad skal der sker ved tryk på SW14 - Facit(=) knap
							-- Her skal facit funktionen skrives
							if (ActionJackson = "00000") then
								-- Skal intet gøre når der ikke er valgt nogen Action
							elsif (DisplayValue > 0) then
								ActionJackson(0) <= '1';
								DisplayValueTwo <= std_logic_vector(to_unsigned(DisplayValue, DisplayValueOne'length));
							
							else
								-- Skal intet gøre når der ikke er tastet noget tal 2 endnu
							end if;
							
							
						when "1000" =>  -- When Column 3 er high
							-- Hvad skal der sker ved tryk på SW15 - Plus(+) knap
							-- Her skal plus funktionen skrives
							if (ActionJackson = "00000") then
								ActionJackson(4) <= '1';
								DisplayValueOne <= std_logic_vector(to_unsigned(DisplayValue, DisplayValueOne'length));;
								DisplayValue <= 0;
							
							else
								DisplayValue <= 0; -- Nulstil display til 0
								ActionJackson <= "00000"; -- Nulstil ActionJackson til alle slukkede bits
							
							end if;
							
						when others => 
					end case;
					
				when others => 
			end case;
	end process;

	
	
	-- KUN TIL TEST
	process is
	begin
		
		for i in 0 to 15 loop
			wait for 1000 ms;
			TestButton(i) <= '1';
			wait for 500 ms;
			TestButton <= (others => '0');
		end loop;
		
		wait;
	
	end process;
	

	
end architecture;