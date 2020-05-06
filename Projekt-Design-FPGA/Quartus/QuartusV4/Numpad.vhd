library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity Numpad is
	port	(-- Inputs:
			TinyClock		: in std_logic;
			Result			: in std_logic_vector(7 downto 0);
			
			-- Outputs:
			Binary			: out std_logic_vector(7 downto 0); -- Tallet som outputtes til displayet
			IO_TBR			: in std_logic;
			ActionJackson	: out std_logic_vector(7 downto 0) := "00000000";
			-- ActionJackson = [SW15, SW11, SW7, SW3, SW14][NotInUse, TooBig, Clear, +, -, *, /, =]
			InputValueOne	: out std_logic_vector(7 downto 0) := (others => '0'); -- Første tal til ALU
			InputValueTwo	: out std_logic_vector(7 downto 0) := (others => '0'); -- Andet tal til ALU
			Row				: out std_logic_vector(3 downto 0);
			Column			: in std_logic_vector(3 downto 0)
			
			);
end  Numpad;

architecture sim of Numpad is

	signal AJ : std_logic_vector(7 downto 0) := "00000000";
	
	-- Siger om vi på nuværende tidspunkt er klar til at tage imod et knaptryk.
	signal ButtonEnable 	: std_logic := '1';
	signal ButtonLastRow 	: std_logic_vector (3 downto 0) := (others=>'0');
	signal RowCopy			: std_logic_vector(3 downto 0); -- Debounce variable
	
	-- Holder den samlede indtastede værdi mellem operationer.
	signal InputValue	: integer := 0; 
	
	-- Tæller der styrer tændingen af hver række.
	signal Counter		: std_logic_vector (29 downto 0);
	
	
begin
	
	process (Result, InputValue, AJ(0)) is
	begin
		if (AJ(0) = '1') then -- Hvis facit er trykket...
			Binary <= Result; -- ...send resultat til display.
		else -- ... ellers send den indtastede værdi til display.
			Binary <= std_logic_vector(to_unsigned(InputValue, Binary'length));
		end if;
	end process;


	-- Hvilken knap skal gøre hvad:
	process (ButtonEnable, TinyClock, IO_TBR)
	begin
		-- Ved starten af hver clock-puls tjekker vi om en knap er trykket.
		if (rising_edge(TinyClock)) then 
			Counter <= Counter + 1;
			
			case Counter(11 downto 9) is 
					when "000" =>
						Row <= "1110";
						RowCopy <= "1110";
					when "001" => -- Når række 0 er aktiv...
						case Column is 
							when "1110" => -- ...samt kolonne 0.
								if (ButtonEnable = '1') then -- Vi skal være åbne for knaptryk.
									-- Hvad skal der sker ved tryk på SW0 - "7"-knap
									if (InputValue = 0) then -- Hvis display er 0
										InputValue <= InputValue + 7;
									elsif (InputValue < 13) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
										InputValue <= InputValue * 10 + 7;

									end if;
									ButtonEnable <= '0'; -- Nu er vi ikke længere åbne for knaptryk!
									ButtonLastRow <= RowCopy;
								end if; 
							when "1101" => -- ...samt kolonne 1.
								if (ButtonEnable = '1') then -- Vi skal være åbne for knaptryk.
									-- Hvad skal der sker ved tryk på SW1 - "8"-knap
									if (InputValue = 0) then -- Hvis display er 0
										InputValue <= InputValue + 8;
									 elsif (InputValue < 12) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
										 InputValue <= InputValue * 10 + 8;
										
									else
									end if;
									ButtonEnable <= '0'; -- Nu er vi ikke længere åbne for knaptryk!
									ButtonLastRow <= RowCopy;
								end if; 
							when "1011" => -- ...samt kolonne 2.
								if (ButtonEnable = '1') then -- Vi skal være åbne for knaptryk.
									-- Hvad skal der sker ved tryk på SW2 - "9"-knap
									if (InputValue = 0) then -- Hvis display er 0
										InputValue <= InputValue + 9;
									elsif (InputValue < 12) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
										InputValue <= InputValue * 10 + 9;
										
									else
									end if;
									ButtonEnable <= '0'; -- Nu er vi ikke længere åbne for knaptryk!
									ButtonLastRow <= RowCopy;
								end if; 
							when "0111" => -- ...samt kolonne 3.
								if (ButtonEnable = '1') then -- Vi skal være åbne for knaptryk.
									-- Hvad skal der sker ved tryk på SW3 - Divider-knap (/)
									-- Her skal dividere funktionen skrives
									if (AJ(4 downto 0) = "00000") then
										AJ(1) <= '1';
										InputValueOne <= std_logic_vector(to_unsigned(InputValue, InputValueOne'length));
										InputValue <= 0;
									elsif (AJ(0) = '1') then
									else
										InputValue <= 0; -- Nulstil display til 0
										AJ(7) <= '1'; -- Error bit til dobbelt action tryk
									
									end if;
									ButtonEnable <= '0'; -- Nu er vi ikke længere åbne for knaptryk!
									ButtonLastRow <= RowCopy;
								end if; 
							when others => -- Hvis ingen kolonne er tændt, og den sidst aktive switch hørte til denne række...
						if (ButtonEnable = '0') and (ButtonLastRow = RowCopy) then 
									ButtonEnable <= '1'; -- ...så åbnes igen for knaptryk.
								end if;
						end case;
						
					when "010" =>
						Row <= "1101";
						RowCopy <= "1101";
					when "011" => -- Når række 1 er aktiv...
						case Column is 
							when "1110" => -- ...samt kolonne 0.
								if (ButtonEnable = '1') then -- Vi skal være åbne for knaptryk.
									-- Hvad skal der sker ved tryk på SW4 - "4"-knap
									if (InputValue = 0) then -- Hvis display er 0
										InputValue <= InputValue + 4;
									elsif (InputValue < 13) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
										InputValue <= InputValue * 10 + 4;
										
									else
									end if;
									ButtonEnable <= '0'; -- Nu er vi ikke længere åbne for knaptryk!
									ButtonLastRow <= RowCopy;
								end if; 
							when "1101" => -- ...samt kolonne 1.
								if (ButtonEnable = '1') then -- Vi skal være åbne for knaptryk.
									-- Hvad skal der sker ved tryk på SW5 - "5"-knap
									if (InputValue = 0) then -- Hvis display er 0
										InputValue <= InputValue + 5;
									elsif (InputValue < 13) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
										InputValue <= InputValue * 10 + 5;
										
									else
									end if;
									ButtonEnable <= '0'; -- Nu er vi ikke længere åbne for knaptryk!
									ButtonLastRow <= RowCopy;
								end if; 
							when "1011" => -- ...samt kolonne 2.
								if (ButtonEnable = '1') then -- Vi skal være åbne for knaptryk.
									-- Hvad skal der sker ved tryk på SW6 - "6"-knap
									if (InputValue = 0) then -- Hvis display er 0
										InputValue <= InputValue + 6;
									elsif (InputValue < 13) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
										InputValue <= InputValue * 10 + 6;
										
									else
									end if;
									ButtonEnable <= '0'; -- Nu er vi ikke længere åbne for knaptryk!
									ButtonLastRow <= RowCopy;
								end if; 
							when "0111" => -- ...samt kolonne 3.
								if (ButtonEnable = '1') then -- Vi skal være åbne for knaptryk.
									-- Hvad skal der sker ved tryk på SW7 - Gange-knap (*)
									-- Her skal gange funktionen skrives
									if (AJ(4 downto 0) = "00000") then
										AJ(2) <= '1';
										InputValueOne <= std_logic_vector(to_unsigned(InputValue, InputValueOne'length));
										InputValue <= 0;
									elsif (AJ(0) = '1') then
									else
										InputValue <= 0; -- Nulstil display til 0
										AJ(7) <= '1'; -- Error bit til dobbelt action tryk
									
									end if;
									ButtonEnable <= '0'; -- Nu er vi ikke længere åbne for knaptryk!
									ButtonLastRow <= RowCopy;
								end if; 
							when others => -- Hvis ingen kolonne er tændt, og den sidst aktive switch hørte til denne række...
							if (ButtonEnable = '0') and (ButtonLastRow = RowCopy) then 
									ButtonEnable <= '1'; -- ...så åbnes igen for knaptryk.
								end if;
						end case;
					
					when "100" =>
						Row <="1011";
						RowCopy <= "1011";
					when "101" => -- Når række 2 er aktiv...
						case Column is 
							when "1110" => -- ...samt kolonne 0.
								if (ButtonEnable = '1') then -- Vi skal være åbne for knaptryk.
									-- Hvad skal der sker ved tryk på SW8 - "1"-knap
									if (InputValue = 0) then -- Hvis display er 0
										InputValue <= InputValue + 1;
									elsif (InputValue < 13) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
										InputValue <= InputValue * 10 + 1;
										
									else
									end if;
									ButtonEnable <= '0'; -- Nu er vi ikke længere åbne for knaptryk!
									ButtonLastRow <= RowCopy;
								end if; 
							when "1101" => -- ...samt kolonne 1.
								if (ButtonEnable = '1') then -- Vi skal være åbne for knaptryk.
									-- Hvad skal der sker ved tryk på SW9 - "2"-knap
									if (InputValue = 0) then -- Hvis display er 0
										InputValue <= InputValue + 2;
									elsif (InputValue < 13) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
										InputValue <= InputValue * 10 + 2;
									
									else
									end if;
									ButtonEnable <= '0'; -- Nu er vi ikke længere åbne for knaptryk!
									ButtonLastRow <= RowCopy;
								end if; 
							when "1011" => -- ...samt kolonne 2.
								if (ButtonEnable = '1') then -- Vi skal være åbne for knaptryk.
									-- Hvad skal der sker ved tryk på SW10 - "3"-knap
									if (InputValue = 0) then -- Hvis display er 0
										InputValue <= InputValue + 3;
									elsif (InputValue < 13) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
										InputValue <= InputValue * 10 + 3;
										
									else
									end if;
									ButtonEnable <= '0'; -- Nu er vi ikke længere åbne for knaptryk!
									ButtonLastRow <= RowCopy;
								end if; 
							when "0111" => -- ...samt kolonne 3.
								if (ButtonEnable = '1') then -- Vi skal være åbne for knaptryk.
									-- Hvad skal der sker ved tryk på SW11 - Minus-knap (-)
									-- Her skal minus funktionen skrives
									if (AJ(4 downto 0) = "00000") then
										AJ(3) <= '1';
										InputValueOne <= std_logic_vector(to_unsigned(InputValue, InputValueOne'length));
										InputValue <= 0;
									elsif (AJ(0) = '1') then
									else
										InputValue <= 0; -- Nulstil display til 0
										AJ(7) <= '1'; -- Error bit til dobbelt action tryk
									
									end if;
									ButtonEnable <= '0'; -- Nu er vi ikke længere åbne for knaptryk!
									ButtonLastRow <= RowCopy;
								end if; 
							when others => -- Hvis ingen kolonne er tændt, og den sidst aktive switch hørte til denne række...
							if (ButtonEnable = '0') and (ButtonLastRow = RowCopy) then 
									ButtonEnable <= '1'; -- ...så åbnes igen for knaptryk.
								end if;
						end case;
					
					When "110" =>
						Row <= "0111";
						RowCopy <= "0111";
					when "111" => -- Når række 3 er aktiv...
						case Column is 
							when "1110" => -- ...samt kolonne 0.
								if (ButtonEnable = '1') then -- Vi skal være åbne for knaptryk.
									-- Hvad skal der sker ved tryk på SW12 - Clear-knap (C)
									InputValue <= 0; -- Nulstil display til 0
									AJ <= "00000000"; -- Nulstil AJ til alle slukkede bits
									AJ(5) <= '1'; --Reset-bit
									ButtonEnable <= '0'; -- Nu er vi ikke længere åbne for knaptryk!
									ButtonLastRow <= RowCopy;
								end if; 
							when "1101" => -- ...samt kolonne 1.
								if (ButtonEnable = '1') then -- Vi skal være åbne for knaptryk.
									-- Hvad skal der sker ved tryk på SW13 - 0 knap
									if (InputValue = 0) then -- Hvis display er 0
									elsif (InputValue < 13) then -- Ellers flyttes tallet et ciffer til venstre og indtaster det trykkede tal på ciffer 0's plads
										InputValue <= InputValue * 10;
									else
									end if;
									ButtonEnable <= '0'; -- Nu er vi ikke længere åbne for knaptryk!
									ButtonLastRow <= RowCopy;
								end if; 
							when "1011" => -- ...samt kolonne 2.
								if (ButtonEnable = '1') then -- Vi skal være åbne for knaptryk.
									-- Hvad skal der sker ved tryk på SW14 - Facit-knap (=)
									-- Her skal facit funktionen skrives
									if (AJ(4 downto 0) = "00000") then
										-- Skal intet gøre når der ikke er valgt nogen Action
									else--if (InputValue > 0) then
										AJ(6) <= '0';
										AJ(5) <= '0';
										AJ(0) <= '1';
										InputValueTwo <= std_logic_vector(to_unsigned(InputValue, InputValueTwo'length));
									end if;
									ButtonEnable <= '0'; -- Nu er vi ikke længere åbne for knaptryk!
									ButtonLastRow <= RowCopy;
								end if; 
							when "0111" => -- ...samt kolonne 3.
								if (ButtonEnable = '1') then -- Vi skal være åbne for knaptryk.
									-- Hvad skal der sker ved tryk på SW15 - Plus-knap (+)
									-- Her skal plus funktionen skrives
									if (AJ(4 downto 0) = "00000") then
										AJ(4) <= '1';
										InputValueOne <= std_logic_vector(to_unsigned(InputValue, InputValueOne'length));
										InputValue <= 0;
									elsif (AJ(0) = '1') then
										
									else
										InputValue <= 0; -- Nulstil display til 0
										AJ(7) <= '1'; -- Error bit til dobbelt action tryk
									
									end if;
									ButtonEnable <= '0'; -- Nu er vi ikke længere åbne for knaptryk!
									ButtonLastRow <= RowCopy;
								end if; 
							when others => -- Hvis ingen kolonne er tændt, og den sidst aktive switch hørte til denne række...
						if (ButtonEnable = '0') and (ButtonLastRow = RowCopy) then 
									ButtonEnable <= '1'; -- ...så åbnes igen for knaptryk.
								end if;
						end case;
				when others =>
			end case;
			ActionJackson <= AJ;
		end if; 
		
		
		if (IO_TBR = '1') and (AJ(5) = '0') then
			AJ(6) <= '1';
		else
			AJ(6) <= '0';
		end if;
	end process;
	
end architecture;