library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Numpad is
	port	(-- Inputs:
			TinyClock		: in std_logic;
			
			-- Outputs:
			Binary			: out std_logic_vector(7 downto 0); -- Tallet som outputtes til displayet
			ActionJackson	: buffer std_logic_vector(4 downto 0) := "00000"; -- ActionJackson = [SW14, SW3, SW7, SW11, SW15] = [=, /, *, -, +] -- (=) = ActionJackson(0), ..., (+) = ActionJackson(4)
			InputValueOne	: out std_logic_vector(7 downto 0); -- Første tal til ALU
			InputValueTwo	: out std_logic_vector(7 downto 0) -- Andet tal til ALU
			);

end  Numpad;

architecture sim of Numpad is

	signal Row			: std_logic_vector(3 downto 0) := (others => '0');
	signal Column		: std_logic_vector(3 downto 0) := (others => '0');
	signal ButtonEnable : boolean := true;
	signal InputValue	: integer := 0; -- Bruges til at holde en integer værdi af det der står på displayet nu
	signal Switch		: std_logic_vector(3 downto 0) := (others => 'U');
	
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

		-- Binary <= std_logic_vector(to_unsigned(InputValue, Binary'length));
		
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
	process (Column, Row, ButtonEnable, TinyClock)
	begin
		if (rising_edge(TinyClock)) then --(Row(0))) or (rising_edge(Row(1))) or (rising_edge(Row(2))) or (rising_edge(Row(3))) then  
			case Row is 
					when "0001" => 
						case Column is 
							when "0001" =>
								if (ButtonEnable = true) then
									Switch <= "0000";
									ButtonEnable <= false; 
								end if; 
							when "0010" =>
								if (ButtonEnable = true) then
									Switch <= "0001";
									ButtonEnable <= false; 
								end if; 
							when "0100" =>
								if (ButtonEnable = true) then
									Switch <= "0010";
									ButtonEnable <= false; 
								end if; 
							when "1000" =>
								if (ButtonEnable = true) then
									Switch <= "0011";
									ButtonEnable <= false; 
								end if; 
							when others => 
								if (ButtonEnable = false) and ((Switch = "0000") or (Switch = "0001") or (Switch = "0010") or (Switch = "0011")) then 
									ButtonEnable <= true;
								end if;
						end case;
						
					when "0010" => 
						case Column is 
							when "0001" =>
								if (ButtonEnable = true) then
									Switch <= "0100";
									ButtonEnable <= false; 
								end if; 
							when "0010" =>
								if (ButtonEnable = true) then
									Switch <= "0101";
									ButtonEnable <= false; 
								end if; 
							when "0100" =>
								if (ButtonEnable = true) then
									Switch <= "0110";
									ButtonEnable <= false; 
								end if; 
							when "1000" =>
								if (ButtonEnable = true) then
									Switch <= "0111";
									ButtonEnable <= false; 
								end if; 
							when others =>
							if (ButtonEnable = false) and ((Switch = "0100") or (Switch = "0101") or (Switch = "0110") or (Switch = "0111")) then 
									ButtonEnable <= true;
								end if;
						end case;
					
					when "0100" => 
						case Column is 
							when "0001" =>
								if (ButtonEnable = true) then
									Switch <= "1000";
									ButtonEnable <= false; 
								end if; 
							when "0010" =>
								if (ButtonEnable = true) then
									Switch <= "1001";
									ButtonEnable <= false; 
								end if; 
							when "0100" =>
								if (ButtonEnable = true) then
									Switch <= "1010";
									ButtonEnable <= false; 
								end if; 
							when "1000" =>
								if (ButtonEnable = true) then
									Switch <= "1011";
									ButtonEnable <= false; 
								end if; 
							when others =>
							if (ButtonEnable = false) and ((Switch = "1000") or (Switch = "1001") or (Switch = "1010") or (Switch = "1011")) then 
									ButtonEnable <= true;
								end if;
						end case;
					
					when "1000" => 
						case Column is 
							when "0001" =>
								if (ButtonEnable = true) then
									Switch <= "1100";
									ButtonEnable <= false; 
								end if; 
							when "0010" =>
								if (ButtonEnable = true) then
									Switch <= "1101";
									ButtonEnable <= false; 
								end if; 
							when "0100" =>
								if (ButtonEnable = true) then
									Switch <= "1110";
									ButtonEnable <= false; 
								end if; 
							when "1000" =>
								if (ButtonEnable = true) then
									Switch <= "1111";
									ButtonEnable <= false; 
								end if; 
							when others =>
							if (ButtonEnable = false) and ((Switch = "1100") or (Switch = "1101") or (Switch = "1110") or (Switch = "1111")) then 
									ButtonEnable <= true;
								end if;
						end case;
					
				when others =>

			end case;
		end if; 
		if (ButtonEnable'event) and (ButtonEnable = false) then
			case Switch is 
				when "0000" =>
					-- Hvad skal der sker ved tryk på SW0 - 7 knap
					if (InputValue = 0) then -- Hvis display er 0
						InputValue <= InputValue + 7;
					elsif (InputValue < 25) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
						InputValue <= InputValue * 10 + 7;

					end if;
					
				when "0001" =>
					-- Hvad skal der sker ved tryk på SW1 - 8 knap
					if (InputValue = 0) then -- Hvis display er 0
						InputValue <= InputValue + 8;
					 elsif (InputValue < 25) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
						 InputValue <= InputValue * 10 + 8;
						
					else
					end if;
					
				when "0010" =>
					-- Hvad skal der sker ved tryk på SW2 - 9 knap
					if (InputValue = 0) then -- Hvis display er 0
						InputValue <= InputValue + 9;
					elsif (InputValue < 25) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
						InputValue <= InputValue * 10 + 9;
						
					else
					end if;
					
				when "0011" =>
					-- Hvad skal der sker ved tryk på SW3 - Divider(/) knap
					-- Her skal dividere funktionen skrives
					if (ActionJackson = "00000") then
						ActionJackson(2) <= '1';
						InputValueOne <= std_logic_vector(to_unsigned(InputValue, InputValueOne'length));
						
					else
						-- InputValue <= 0; -- Nulstil display til 0
						ActionJackson <= "00000"; -- Nulstil ActionJackson til alle slukkede bits
					
					end if;
					
				when "0100" =>
					-- Hvad skal der sker ved tryk på SW4 - 4 knap
					if (InputValue = 0) then -- Hvis display er 0
						InputValue <= InputValue + 4;
					elsif (InputValue < 26) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
						InputValue <= InputValue * 10 + 4;
						
					else
					end if;
					
				when "0101" =>
					-- Hvad skal der sker ved tryk på SW5 - 5 knap
					if (InputValue = 0) then -- Hvis display er 0
						InputValue <= InputValue + 5;
					elsif (InputValue < 26) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
						InputValue <= InputValue * 10 + 5;
						
					else
					end if;
					
				when "0110" =>
					-- Hvad skal der sker ved tryk på SW6 - 6 knap
					if (InputValue = 0) then -- Hvis display er 0
						InputValue <= InputValue + 6;
					elsif (InputValue < 25) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
						InputValue <= InputValue * 10 + 6;
						
					else
					end if;
					
				when "0111" =>
					-- Hvad skal der sker ved tryk på SW7 - Gange(*) knap
					-- Her skal gange funktionen skrives
					if (ActionJackson = "00000") then
						ActionJackson(2) <= '1';
						InputValueOne <= std_logic_vector(to_unsigned(InputValue, InputValueOne'length));
						InputValue <= 0;
					
					else
						InputValue <= 0; -- Nulstil display til 0
						ActionJackson <= "00000"; -- Nulstil ActionJackson til alle slukkede bits
					
					end if;
					
				when "1000" =>
					-- Hvad skal der sker ved tryk på SW8 - 1 knap
					if (InputValue = 0) then -- Hvis display er 0
						InputValue <= InputValue + 1;
					elsif (InputValue < 26) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
						InputValue <= InputValue * 10 + 1;
						
					else
					end if;
					
				when "1001" =>
					-- Hvad skal der sker ved tryk på SW9 - 2 knap
					if (InputValue = 0) then -- Hvis display er 0
						InputValue <= InputValue + 2;
					elsif (InputValue < 26) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
						InputValue <= InputValue * 10 + 2;
					
					else
					end if;
					
				when "1010" =>
					-- Hvad skal der sker ved tryk på SW10 - 3 knap
					if (InputValue = 0) then -- Hvis display er 0
						InputValue <= InputValue + 3;
					elsif (InputValue < 26) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
						InputValue <= InputValue * 10 + 3;
						
					else
					end if;
					
				when "1011" =>
					-- Hvad skal der sker ved tryk på SW11 - Minus(-) knap
					-- Her skal minus funktionen skrives
					if (ActionJackson = "00000") then
						ActionJackson(3) <= '1';
						InputValueOne <= std_logic_vector(to_unsigned(InputValue, InputValueOne'length));
						InputValue <= 0;
					
					else
						InputValue <= 0; -- Nulstil display til 0
						ActionJackson <= "00000"; -- Nulstil ActionJackson til alle slukkede bits
					
					end if;
					
				when "1100" =>
					-- Hvad skal der sker ved tryk på SW12 - Clear knap
					InputValue <= 0; -- Nulstil display til 0
					ActionJackson <= "00000"; -- Nulstil ActionJackson til alle slukkede bits
				when "1101" =>
					-- Hvad skal der sker ved tryk på SW13 - 0 knap
					if (InputValue = 0) then -- Hvis display er 0
					elsif (InputValue < 26) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
						InputValue <= InputValue * 10;
					else
					end if;
				when "1110" =>
					-- Hvad skal der sker ved tryk på SW14 - Facit(=) knap
					-- Her skal facit funktionen skrives
					if (ActionJackson = "00000") then
						-- Skal intet gøre når der ikke er valgt nogen Action
					elsif (InputValue > 0) then
						ActionJackson(0) <= '1';
						InputValueTwo <= std_logic_vector(to_unsigned(InputValue, InputValueTwo'length));
					
					else
						-- Skal intet gøre når der ikke er tastet noget tal 2 endnu
					end if;
				when "1111" =>
					-- Hvad skal der sker ved tryk på SW15 - Plus(+) knap
					-- Her skal plus funktionen skrives
					if (ActionJackson = "00000") then
						ActionJackson(4) <= '1';
						InputValueOne <= std_logic_vector(to_unsigned(InputValue, InputValueOne'length));
						InputValue <= 0;
					
					else
						InputValue <= 0; -- Nulstil display til 0
						ActionJackson <= "00000"; -- Nulstil ActionJackson til alle slukkede bits
					
					end if;
				when others => 
								
								
			end case;
		end if; 
	end process;

	process(InputValue)
	begin
		Binary <= std_logic_vector(to_unsigned(InputValue, Binary'length));
	end process;
	
	-- KUN TIL TEST
	process is
	begin
		
		wait for 1000 ms; 
		TestButton(9) <= '1';
		wait for 500 ms;
		TestButton <= (others => '0'); 
		
		wait for 1000 ms; 
		TestButton(4) <= '1';
		wait for 500 ms;
		TestButton <= (others => '0'); 
		
		wait for 1000 ms; 
		TestButton(15) <= '1';
		wait for 500 ms;
		TestButton <= (others => '0'); 
		
		wait for 1000 ms; 
		TestButton(0) <= '1';
		wait for 500 ms;
		TestButton <= (others => '0'); 
		
		wait for 1000 ms; 
		TestButton(14) <= '1';
		wait for 500 ms;
		TestButton <= (others => '0'); 
		-- for i in 1 to 15 loop
			-- wait for 1000 ms;
			-- TestButton(i) <= '1';
			-- wait for 500 ms;
			-- TestButton <= (others => '0');
		-- end loop;
		
		wait;
	
	end process;
	

	
end architecture;