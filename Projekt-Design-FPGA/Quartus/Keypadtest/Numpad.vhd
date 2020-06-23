library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Numpad is
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
end  Numpad;

architecture sim of Numpad is

	-- KUN TIL TEST --
	-- Skal kobles til de eksterne pins, som 16-knap-matrixen er tilsluttet.
	-- Rækker og kolonner. Knapperne i matrixen skaber en unik forbindelse mellem en række og en kolonne.
	--signal Row			: std_logic_vector(3 downto 0) := (others => '0');
	--signal Column		: std_logic_vector(3 downto 0) := (others => '0');
	-- KUN TIL TEST --
	
	-- Siger om vi på nuværende tidspunkt er klar til at tage imod et knaptryk.
	signal ButtonEnable : boolean := true;
	
	-- Holder den samlede indtastede værdi mellem operationer.
	--signal InputValue	: integer := 0; 
	
	-- Holder nummeret på den knap der sidst blev trykket på et gyldigt tidspunkt.
	signal Switch		: std_logic_vector(3 downto 0) := (others => '0');
	
	-- Tæller der styrer tændingen af hver række.
	signal Counter		: integer := 0;
	
	-- KUN TIL TEST --
	-- Skal slettes.
	-- signal TestButton	: std_logic_vector(15 downto 0) := (others => '0');
	-- KUN TIL TEST --

	

	
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
		
		
		-- Hvad skal der gøres når en knap er trykket:
		if (ButtonEnable'event) and (ButtonEnable = false) then
			case Switch is 
				when "0000" => -- SW0
					LED0 <= '1';
					
				when "0001" => -- SW1
					LED1 <= '1';
				when "0010" =>
					-- Hvad skal der sker ved tryk på SW2 - "9"-knap
					LED2	<= '1';
					
				when "0011" =>
					-- Hvad skal der sker ved tryk på SW3 - Divider-knap (/)
					LED3 <= '1';
					
				when "0100" =>
					-- Hvad skal der sker ved tryk på SW4 - "4"-knap
					LED4 <= '1';
				when others =>
						
			end case;
		end if;
	end process;
	
end architecture;