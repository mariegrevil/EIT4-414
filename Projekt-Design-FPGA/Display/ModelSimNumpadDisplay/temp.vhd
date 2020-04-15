if (rising_edge(Column(0))) or (rising_edge(Column(1))) or (rising_edge(Column(2))) or (rising_edge(Column(3))) then  
			case Row is
					when "0001" =>  -- When Row 0 er high
						case Column is
							when "0001" =>  -- When Column 0 er high
								ButtonEnable <= true; 
								-- Hvad skal der sker ved tryk på SW0 - 7 knap
								if (DisplayValue = 0) then -- Hvis display er 0
									DisplayValue <= DisplayValue + 7;
								elsif (DisplayValue < 25) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
									DisplayValue <= DisplayValue * 10 + 7;
									
								else
								end if;

								
							when "0010" =>  -- When Column 1 er high
								ButtonEnable <= true; 
								-- Hvad skal der sker ved tryk på SW1 - 8 knap
								if (DisplayValue = 0) then -- Hvis display er 0
									DisplayValue <= DisplayValue + 8;
								 elsif (DisplayValue < 25) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
									 DisplayValue <= DisplayValue * 10 + 8;
									
								else
								end if;
								
							when "0100" =>  -- When Column 2 er high
									ButtonEnable <= true; 
								-- Hvad skal der sker ved tryk på SW2 - 9 knap
								if (DisplayValue = 0) then -- Hvis display er 0
									DisplayValue <= DisplayValue + 9;
								elsif (DisplayValue < 25) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
									DisplayValue <= DisplayValue * 10 + 9;
									
								else
								end if;
								
							when "1000" =>  -- When Column 3 er high
									ButtonEnable <= true; 
								-- Hvad skal der sker ved tryk på SW3 - Divider(/) knap
								-- Her skal dividere funktionen skrives
								if (ActionJackson = "00000") then
									ActionJackson(2) <= '1';
									DisplayValueOne <= std_logic_vector(to_unsigned(DisplayValue, DisplayValueOne'length));
									if (DisplayValueOne = "000000000")
									
									else
									DisplayValue <= 0;
									end if;
								else
									-- DisplayValue <= 0; -- Nulstil display til 0
									ActionJackson <= "00000"; -- Nulstil ActionJackson til alle slukkede bits
								
								end if;
								
							when others => 
						end case;
						
					when "0010" =>  -- When Row 1 er high
						case Column is
							when "0001" =>  -- When Column 0 er high
									ButtonEnable <= true; 
								-- Hvad skal der sker ved tryk på SW4 - 4 knap
								if (DisplayValue = 0) then -- Hvis display er 0
									DisplayValue <= DisplayValue + 4;
								elsif (DisplayValue < 26) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
									DisplayValue <= DisplayValue * 10 + 4;
									
								else
								end if;
								
							when "0010" =>  -- When Column 1 er high
									ButtonEnable <= true; 
								-- Hvad skal der sker ved tryk på SW5 - 5 knap
								if (DisplayValue = 0) then -- Hvis display er 0
									DisplayValue <= DisplayValue + 5;
								elsif (DisplayValue < 26) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
									DisplayValue <= DisplayValue * 10 + 5;
									
								else
								end if;
								
							when "0100" =>  -- When Column 2 er high
									ButtonEnable <= true; 
								-- Hvad skal der sker ved tryk på SW6 - 6 knap
								if (DisplayValue = 0) then -- Hvis display er 0
									DisplayValue <= DisplayValue + 6;
								elsif (DisplayValue < 25) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
									DisplayValue <= DisplayValue * 10 + 6;
									
								else
								end if;
								
							when "1000" =>  -- When Column 3 er high
									ButtonEnable <= true; 
								-- Hvad skal der sker ved tryk på SW7 - Gange(*) knap
								-- Her skal gange funktionen skrives
								if (ActionJackson = "00000") then
									ActionJackson(2) <= '1';
									DisplayValueOne <= std_logic_vector(to_unsigned(DisplayValue, DisplayValueOne'length));
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
									ButtonEnable <= true; 
								-- Hvad skal der sker ved tryk på SW8 - 1 knap
								if (DisplayValue = 0) then -- Hvis display er 0
									DisplayValue <= DisplayValue + 1;
								elsif (DisplayValue < 26) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
									DisplayValue <= DisplayValue * 10 + 1;
									
								else
								end if;
								
							when "0010" =>  -- When Column 1 er high
									ButtonEnable <= true; 
								-- Hvad skal der sker ved tryk på SW9 - 2 knap
								if (DisplayValue = 0) then -- Hvis display er 0
									DisplayValue <= DisplayValue + 2;
								elsif (DisplayValue < 26) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
									DisplayValue <= DisplayValue * 10 + 2;
								
								else
								end if;
								
							when "0100" =>  -- When Column 2 er high
									ButtonEnable <= true; 
								-- Hvad skal der sker ved tryk på SW10 - 3 knap
								if (DisplayValue = 0) then -- Hvis display er 0
									DisplayValue <= DisplayValue + 3;
								elsif (DisplayValue < 26) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
									DisplayValue <= DisplayValue * 10 + 3;
									
								else
								end if;
								
							when "1000" =>  -- When Column 3 er high
									ButtonEnable <= true; 
								-- Hvad skal der sker ved tryk på SW11 - Minus(-) knap
								-- Her skal minus funktionen skrives
								if (ActionJackson = "00000") then
									ActionJackson(3) <= '1';
									DisplayValueOne <= std_logic_vector(to_unsigned(DisplayValue, DisplayValueOne'length));
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
									ButtonEnable <= true; 
								-- Hvad skal der sker ved tryk på SW12 - Clear knap
								DisplayValue <= 0; -- Nulstil display til 0
								ActionJackson <= "00000"; -- Nulstil ActionJackson til alle slukkede bits
								
							when "0010" =>  -- When Column 1 er high
									ButtonEnable <= true; 
								-- Hvad skal der sker ved tryk på SW13 - 0 knap
								if (DisplayValue = 0) then -- Hvis display er 0
								elsif (DisplayValue < 26) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
									DisplayValue <= DisplayValue * 10;
								else
								end if;
								
							when "0100" =>  -- When Column 2 er high
									ButtonEnable <= true; 
								-- Hvad skal der sker ved tryk på SW14 - Facit(=) knap
								-- Her skal facit funktionen skrives
								if (ActionJackson = "00000") then
									-- Skal intet gøre når der ikke er valgt nogen Action
								elsif (DisplayValue > 0) then
									ActionJackson(0) <= '1';
									DisplayValueTwo <= std_logic_vector(to_unsigned(DisplayValue, DisplayValueTwo'length));
								
								else
									-- Skal intet gøre når der ikke er tastet noget tal 2 endnu
								end if;
								
								
							when "1000" =>  -- When Column 3 er high
									ButtonEnable <= true; 
								-- Hvad skal der sker ved tryk på SW15 - Plus(+) knap
								-- Her skal plus funktionen skrives
								if (ActionJackson = "00000") then
									ActionJackson(4) <= '1';
									DisplayValueOne <= std_logic_vector(to_unsigned(DisplayValue, DisplayValueOne'length));
									DisplayValue <= 0;
								
								else
									DisplayValue <= 0; -- Nulstil display til 0
									ActionJackson <= "00000"; -- Nulstil ActionJackson til alle slukkede bits
								
								end if;
								
							when others => 
						end case;
						
					when others => 
				end case;
				
			end if;	
			