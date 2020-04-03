library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TopDesign is
	--setup:
	port	(	-- Dip switches:
				switch0	:	in std_logic;
				switch1	:	in std_logic;
				switch2	:	in std_logic;
				switch3	:	in std_logic;
				
				-- Debounced buttons:
				shift_btn : in std_logic;
				reset_btn : in std_logic;

				--Display:
				display 	: out std_logic_vector(41 downto 0) := (others => '0');
				LED 		: out std_logic_vector(8 downto 0) := (others => '0');
				
				-- Run order counter:
				orderCount		: buffer integer; --    ex. code: range 0 to 8;
				
				-- clock divider:
				clock : in std_logic; -- 50 Mhz in fra FPGA crystal
				LED9	: out std_logic := '0';
				clk	: buffer std_logic := '0'

				);
								
end TopDesign;


architecture rtl of TopDesign is
-- Loop

	signal Digit 			: std_logic_vector(3	downto 0) := (others => '0'); -- Dip switch array
	signal Decode_Data 	: std_logic_vector(6 downto 0); -- Her declares et 7 bit array for hvilke linjer i displaytallet som skal tændes
	signal DRAM 			: std_logic_vector(41 downto 0) := (others => '0'); 

	-- Clock divider:
	constant clk_prescaler	: unsigned(25 downto 0) := "00010011000100101101000000";  -- 5.000.000 i binary = 10Hz       ex. code:   "00000000001100001101010000"; =  50.000 i binary = 1kHz      "10111110101111000010000000"; = 50.000.000 i binary = 1Hz     "101111101011110000100000"; = 12,500,000 in binary = 4Hz
   signal 	clk_counter		: unsigned(25 downto 0) := (others => '0');
	constant clk_one			: unsigned(25 downto 0) := "00000000000000000000000001";
	signal 	newClock 		: std_logic := '0';
	
	-- Order nummer:
	constant runOrder_number : integer := 64; -- Her difineres den ønskede antal orderCount ønsket til programmet(HUSK: tæller fra 1 til og MED tallet difineret)

	-- Loop stoppers:
	signal loopCount0 :	integer := 0;
	
begin

-- Clock divider: 

clk <= newClock; -- Den ny generede clock = clk



    process(clock, newClock, clk)
	 begin
		  if rising_edge(clock) then
				clk_counter <= clk_counter + clk_one;
	
				if(clk_counter > clk_prescaler) then
					 -- Iterate
					newClock <= not newClock;
					clk_counter <= (others => '0');
					
					if (orderCount < runOrder_number) then 
						orderCount <= orderCount + 1; -- Her tællers orderCount 1 op per loop
						
					else	
						orderCount <= 0;
						
					end if;
				end if;
		  end if;
    end process;


-- De 4 dib switches state ligges i Digit arrayet
Digit(0) <= switch0;
Digit(1) <= switch1;
Digit(2) <= switch2;
Digit(3) <= switch3;

-- LED counter bits:

-- Display updateres:
display <= not DRAM;
--	Setup DRAM array [7-bit per digit]: 
--				Digit0 = DRAM(0) 	<-start bit
--				Digit1 = DRAM(7)	<-start bit
--				Digit2 = DRAM(14)	<-start bit
--				Digit3 = DRAM(21)	<-start bit
--				Digit4 = DRAM(28)	<-start bit
--				Digit5 = DRAM(35)	<-start bit

-- LED display(for math test):
LED <= std_logic_vector(to_unsigned(orderCount, LED'length)); -- konvertere integer orderCount til vector
LED9 <= clk; -- For LED9 til at blinke i takt med clocken

	-- Dip switch fortolker til tal:
	process(clk, Digit)

		begin
	
		-- Her "tegnes" tallene 0-9 på displayet(+HEX): se board manualen sektion 3.3
		case Digit is
			when "0000" => Decode_Data <= "1111110"; -- 0
			when "0001" => Decode_Data <= "0110000"; -- 1
			when "0010" => Decode_Data <= "1101101"; -- 2
			when "0011" => Decode_Data <= "1111001"; -- 3
			when "0100" => Decode_Data <= "1011011"; -- 4
			when "0101" => Decode_Data <= "1011011"; -- 5
			when "0110" => Decode_Data <= "1011111"; -- 6
			when "0111" => Decode_Data <= "1110000"; -- 7
			when "1000" => Decode_Data <= "1111111"; -- 8
			when "1001" => Decode_Data <= "1111011"; -- 9
			when "1010" => Decode_Data <= "1110111"; -- A
			when "1011" => Decode_Data <= "0011111"; -- B
			when "1100" => Decode_Data <= "1001110"; -- C
			when "1101" => Decode_Data <= "0111101"; -- D
			when "1110" => Decode_Data <= "1001111"; -- E
			when "1111" => Decode_Data <= "1000111"; -- F
			when others => Decode_Data <= "0110111"; -- Error 'H'
		end case;
		
	end process;
			 
	process(clk, DRAM, shift_btn, reset_btn, Decode_Data, orderCount,loopCount0)

		begin
		if (orderCount = 1) then
			-- Sender tallet valgt til DRAM: (Bit rækefølge inverteres for at gøre pin planner lettere)
			DRAM(6)	<=	  Decode_Data(6);
			DRAM(5)	<=	  Decode_Data(5);
			DRAM(4)	<=	  Decode_Data(4);
			DRAM(3)	<=	  Decode_Data(3);
			DRAM(2)	<=	  Decode_Data(2);
			DRAM(1)	<=	  Decode_Data(1);
			DRAM(0)	<=	  Decode_Data(0);
		
		end if;
		
--		if (shift_btn = '0') and (clk = '1') and (orderCount = 2) then --if hvis knappen trykkes
--			if (loopCount0 < 1) then
--				for i in 41 downto 7 loop				
--					DRAM(i) <= DRAM(i-7); -- Flytter ciffer på display en plads til venstre
--					loopCount0 <= loopCount0 + 1;
--					
--				end loop;
--			else
--				loopCount0 <= 0;
--			end if;
--		end if;
--		
--		if (reset_btn = '0') and (clk = '1') and (orderCount = 3) then --if hvis knappen trykkes
--			if (loopCount0 < 1) then
--				for i in 41 downto 0 loop				
--					DRAM(i) <= '0'; -- Nulstiller displayet
--					loopCount0 <= loopCount0 + 1;
--					
--				end loop;
--			else
--				loopCount0 <= 0;
--			end if;
--		end if;
		
	end process;
	
--	process(shift_btn, reset_btn)
--		begin
--		
--		if (shift_btn = '1') and (shift_btn'event) then --if hvis knappen trykkes
--		
--			buttons(0) <= '1';
--	
--		end if;
--		
--		if (reset_btn = '1') and (reset_btn'event) then --if hvis knappen trykkes
--		
--			buttons(1) <= '1';
--			
--		end if;
--			
--	end process;
--	
		
end rtl;

