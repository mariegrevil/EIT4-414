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

	-- Rækker og kolonner. Knapperne i matrixen skaber en unik forbindelse mellem en række og en kolonne.
	signal Row			: std_logic_vector(3 downto 0) := (others => '0');
	signal Column		: std_logic_vector(3 downto 0) := (others => '0');
	
	-- Siger om vi på nuværende tidspunkt er klar til at tage imod et knaptryk.
	signal ButtonEnable : boolean := true;
	
	-- Holder den samlede indtastede værdi mellem operationer.
	signal InputValue	: integer := 0; 
	
	-- Holder nummeret på den knap der sidst blev trykket på et gyldigt tidspunkt.
	signal Switch		: std_logic_vector(3 downto 0) := (others => 'U');
	
	-- Tæller der styrer tændingen af hver række.
	signal Counter		: integer := 0;
	
	-- KUN TIL TEST - må ikke bruges
	signal TestButton	: std_logic_vector(15 downto 0) := (others => '0');

	
begin

	-- Reagerer på stigende og faldende clock-puls.
	process (TinyClock) is
	begin
		if (rising_edge(TinyClock)) then
			Row <= (others => '0'); -- Luk for signalet til alle rækker...
			Row(Counter) <= '1'; -- ...undtagen den række vores tæller vælger.
		elsif (falling_edge(TinyClock)) then
			if (Counter < 3) then -- Hvis tælleren er mindre end 3...
				Counter <= Counter + 1; -- ...så læg 1 til.
			else
				Counter <= 0; -- Nulstil tælleren, hvis den ikke er mindre end 3.
			end if;
		end if;
		
	end process;
	

	
	
	-- Hvilken knap skal gøre hvad:
	process (ButtonEnable, TinyClock)
	begin
		-- Ved starten af hver clock-puls tjekker vi om en knap er trykket.
		if (rising_edge(TinyClock)) then 
			case Row is 
					when "0001" => -- Når række 0 er aktiv...
						case Column is 
							when "0001" => -- ...samt kolonne 0.
								if (ButtonEnable = true) then -- Vi skal være åbne for knaptryk.
									Switch <= "0000"; -- SW0 må være trykket ned.
									ButtonEnable <= false; -- Nu er vi ikke længere åbne for knaptryk!
								end if; 
							when "0010" => -- ...samt kolonne 1.
								if (ButtonEnable = true) then -- Vi skal være åbne for knaptryk.
									Switch <= "0001"; -- SW1 må være trykket ned.
									ButtonEnable <= false; -- Nu er vi ikke længere åbne for knaptryk!
								end if; 
							when "0100" => -- ...samt kolonne 2.
								if (ButtonEnable = true) then -- Vi skal være åbne for knaptryk.
									Switch <= "0010"; -- SW2 må være trykket ned.
									ButtonEnable <= false; -- Nu er vi ikke længere åbne for knaptryk!
								end if; 
							when "1000" => -- ...samt kolonne 3.
								if (ButtonEnable = true) then -- Vi skal være åbne for knaptryk.
									Switch <= "0011"; -- SW3 må være trykket ned.
									ButtonEnable <= false; -- Nu er vi ikke længere åbne for knaptryk!
								end if; 
							when others => -- Hvis ingen kolonne er tændt, og den sidst aktive switch hørte til denne række...
								if (ButtonEnable = false) and ((Switch = "0000") or (Switch = "0001") or (Switch = "0010") or (Switch = "0011")) then 
									ButtonEnable <= true; -- ...så åbnes igen for knaptryk.
								end if;
						end case;
						
					when "0010" => -- Når række 1 er aktiv...
						case Column is 
							when "0001" => -- ...samt kolonne 0.
								if (ButtonEnable = true) then -- Vi skal være åbne for knaptryk.
									Switch <= "0100"; -- SW4 må være trykket ned.
									ButtonEnable <= false; -- Nu er vi ikke længere åbne for knaptryk!
								end if; 
							when "0010" => -- ...samt kolonne 1.
								if (ButtonEnable = true) then -- Vi skal være åbne for knaptryk.
									Switch <= "0101"; -- SW5 må være trykket ned.
									ButtonEnable <= false; -- Nu er vi ikke længere åbne for knaptryk!
								end if; 
							when "0100" => -- ...samt kolonne 2.
								if (ButtonEnable = true) then -- Vi skal være åbne for knaptryk.
									Switch <= "0110"; -- SW6 må være trykket ned.
									ButtonEnable <= false; -- Nu er vi ikke længere åbne for knaptryk!
								end if; 
							when "1000" => -- ...samt kolonne 3.
								if (ButtonEnable = true) then -- Vi skal være åbne for knaptryk.
									Switch <= "0111"; -- SW7 må være trykket ned.
									ButtonEnable <= false; -- Nu er vi ikke længere åbne for knaptryk!
								end if; 
							when others => -- Hvis ingen kolonne er tændt, og den sidst aktive switch hørte til denne række...
							if (ButtonEnable = false) and ((Switch = "0100") or (Switch = "0101") or (Switch = "0110") or (Switch = "0111")) then 
									ButtonEnable <= true; -- ...så åbnes igen for knaptryk.
								end if;
						end case;
					
					when "0100" => -- Når række 2 er aktiv...
						case Column is 
							when "0001" => -- ...samt kolonne 0.
								if (ButtonEnable = true) then -- Vi skal være åbne for knaptryk.
									Switch <= "1000"; -- SW8 må være trykket ned.
									ButtonEnable <= false; -- Nu er vi ikke længere åbne for knaptryk!
								end if; 
							when "0010" => -- ...samt kolonne 1.
								if (ButtonEnable = true) then -- Vi skal være åbne for knaptryk.
									Switch <= "1001"; -- SW9 må være trykket ned.
									ButtonEnable <= false; -- Nu er vi ikke længere åbne for knaptryk!
								end if; 
							when "0100" => -- ...samt kolonne 2.
								if (ButtonEnable = true) then -- Vi skal være åbne for knaptryk.
									Switch <= "1010"; -- SW10 må være trykket ned.
									ButtonEnable <= false; -- Nu er vi ikke længere åbne for knaptryk!
								end if; 
							when "1000" => -- ...samt kolonne 3.
								if (ButtonEnable = true) then -- Vi skal være åbne for knaptryk.
									Switch <= "1011"; -- SW11 må være trykket ned.
									ButtonEnable <= false; -- Nu er vi ikke længere åbne for knaptryk!
								end if; 
							when others => -- Hvis ingen kolonne er tændt, og den sidst aktive switch hørte til denne række...
							if (ButtonEnable = false) and ((Switch = "1000") or (Switch = "1001") or (Switch = "1010") or (Switch = "1011")) then 
									ButtonEnable <= true; -- ...så åbnes igen for knaptryk.
								end if;
						end case;
					
					when "1000" => -- Når række 3 er aktiv...
						case Column is 
							when "0001" => -- ...samt kolonne 0.
								if (ButtonEnable = true) then -- Vi skal være åbne for knaptryk.
									Switch <= "1100"; -- SW12 må være trykket ned.
									ButtonEnable <= false; -- Nu er vi ikke længere åbne for knaptryk!
								end if; 
							when "0010" => -- ...samt kolonne 1.
								if (ButtonEnable = true) then -- Vi skal være åbne for knaptryk.
									Switch <= "1101"; -- SW13 må være trykket ned.
									ButtonEnable <= false; -- Nu er vi ikke længere åbne for knaptryk!
								end if; 
							when "0100" => -- ...samt kolonne 2.
								if (ButtonEnable = true) then -- Vi skal være åbne for knaptryk.
									Switch <= "1110"; -- SW14 må være trykket ned.
									ButtonEnable <= false; -- Nu er vi ikke længere åbne for knaptryk!
								end if; 
							when "1000" => -- ...samt kolonne 3.
								if (ButtonEnable = true) then -- Vi skal være åbne for knaptryk.
									Switch <= "1111"; -- SW15 må være trykket ned.
									ButtonEnable <= false; -- Nu er vi ikke længere åbne for knaptryk!
								end if; 
							when others => -- Hvis ingen kolonne er tændt, og den sidst aktive switch hørte til denne række...
							if (ButtonEnable = false) and ((Switch = "1100") or (Switch = "1101") or (Switch = "1110") or (Switch = "1111")) then 
									ButtonEnable <= true; -- ...så åbnes igen for knaptryk.
								end if;
						end case;
					
				when others =>

			end case;
		end if; 
		if (ButtonEnable'event) and (ButtonEnable = false) then
			case Switch is 
				when "0000" =>
					-- Hvad skal der sker ved tryk på SW0 - "7"-knap
					if (InputValue = 0) then -- Hvis display er 0
						InputValue <= InputValue + 7;
					elsif (InputValue < 13) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
						InputValue <= InputValue * 10 + 7;

					end if;
					
				when "0001" =>
					-- Hvad skal der sker ved tryk på SW1 - "8"-knap
					if (InputValue = 0) then -- Hvis display er 0
						InputValue <= InputValue + 8;
					 elsif (InputValue < 12) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
						 InputValue <= InputValue * 10 + 8;
						
					else
					end if;
					
				when "0010" =>
					-- Hvad skal der sker ved tryk på SW2 - "9"-knap
					if (InputValue = 0) then -- Hvis display er 0
						InputValue <= InputValue + 9;
					elsif (InputValue < 12) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
						InputValue <= InputValue * 10 + 9;
						
					else
					end if;
					
				when "0011" =>
					-- Hvad skal der sker ved tryk på SW3 - Divider-knap (/)
					-- Her skal dividere funktionen skrives
					if (ActionJackson = "00000") then
						ActionJackson(2) <= '1';
						InputValueOne <= std_logic_vector(to_unsigned(InputValue, InputValueOne'length));
						
					else
						-- InputValue <= 0; -- Nulstil display til 0
						ActionJackson <= "00000"; -- Nulstil ActionJackson til alle slukkede bits
					
					end if;
					
				when "0100" =>
					-- Hvad skal der sker ved tryk på SW4 - "4"-knap
					if (InputValue = 0) then -- Hvis display er 0
						InputValue <= InputValue + 4;
					elsif (InputValue < 13) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
						InputValue <= InputValue * 10 + 4;
						
					else
					end if;
					
				when "0101" =>
					-- Hvad skal der sker ved tryk på SW5 - "5"-knap
					if (InputValue = 0) then -- Hvis display er 0
						InputValue <= InputValue + 5;
					elsif (InputValue < 13) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
						InputValue <= InputValue * 10 + 5;
						
					else
					end if;
					
				when "0110" =>
					-- Hvad skal der sker ved tryk på SW6 - "6"-knap
					if (InputValue = 0) then -- Hvis display er 0
						InputValue <= InputValue + 6;
					elsif (InputValue < 13) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
						InputValue <= InputValue * 10 + 6;
						
					else
					end if;
					
				when "0111" =>
					-- Hvad skal der sker ved tryk på SW7 - Gange-knap (*)
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
					-- Hvad skal der sker ved tryk på SW8 - "1"-knap
					if (InputValue = 0) then -- Hvis display er 0
						InputValue <= InputValue + 1;
					elsif (InputValue < 13) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
						InputValue <= InputValue * 10 + 1;
						
					else
					end if;
					
				when "1001" =>
					-- Hvad skal der sker ved tryk på SW9 - "2"-knap
					if (InputValue = 0) then -- Hvis display er 0
						InputValue <= InputValue + 2;
					elsif (InputValue < 13) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
						InputValue <= InputValue * 10 + 2;
					
					else
					end if;
					
				when "1010" =>
					-- Hvad skal der sker ved tryk på SW10 - "3"-knap
					if (InputValue = 0) then -- Hvis display er 0
						InputValue <= InputValue + 3;
					elsif (InputValue < 13) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
						InputValue <= InputValue * 10 + 3;
						
					else
					end if;
					
				when "1011" =>
					-- Hvad skal der sker ved tryk på SW11 - Minus-knap (-)
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
					-- Hvad skal der sker ved tryk på SW12 - Clear-knap (C)
					InputValue <= 0; -- Nulstil display til 0
					ActionJackson <= "00000"; -- Nulstil ActionJackson til alle slukkede bits
				when "1101" =>
					-- Hvad skal der sker ved tryk på SW13 - 0 knap
					if (InputValue = 0) then -- Hvis display er 0
					elsif (InputValue < 13) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
						InputValue <= InputValue * 10;
					else
					end if;
				when "1110" =>
					-- Hvad skal der sker ved tryk på SW14 - Facit-knap (=)
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
					-- Hvad skal der sker ved tryk på SW15 - Plus-knap (+)
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

	-- Når der forekommer et knaptryk, så sendes den samlede indtastede værdi til Binary.
	process(InputValue)
	begin
		Binary <= std_logic_vector(to_unsigned(InputValue, Binary'length));
	end process;
	
	-- KUN TIL TEST - simulerer knaptryk.
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
	
	-- KUN TIL TEST - simulerer forbindelsen mellem række og kolonne ved knaptryk.
	process (Row) is
	begin
		Column <= (others => '0');
		for i in 0 to 15 loop
			
			if (TestButton(i) = '1') then
				Column(i rem 4) <= Row(i / 4);
			end if;

		end loop;
	
	end process;
	
end architecture;