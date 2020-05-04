library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity matrix_keypad is
port(
		clock,rst : in std_logic;
		col_line : in   std_logic_vector(3 downto 0);
		row_line : out std_logic_vector(3 downto 0);
		led : out   std_logic_vector(9 downto 0)
);
end matrix_keypad;

architecture Behavioral of matrix_keypad is
	signal temp : std_logic_vector(29 downto 0);
	
begin

test: process(clock,rst) is
begin


if(rst='0') then
	led <= "1111111111";
elsif rising_edge(clock) then
	temp <= temp + 1;
		case temp(10 downto 8) is
			when "000" =>
				row_line <= "0111"; --first row
			when "001" =>   
				 if col_line = "0111" then
					  led <= "0000001000"; -- 3  S16
				 elsif col_line = "1011" then
					  led <= "0000000100"; -- 2 S15
				 elsif col_line = "1101" then
					  led <= "0000000010"; -- 1 S14
				 elsif col_line = "1110" then
					  led <= "0000000001"; -- 0 S13
				 end if;
			when "010" =>
				row_line <= "1011"; --second row
			when "011" =>
				 if col_line = "1110" then
					  led <= "0000010000"; -- 4 S9
				 elsif col_line = "1101" then
					  led <= "0000100000"; -- 5 S10
				 elsif col_line = "1011" then
					  led <= "0001000000"; -- 6 S11
				 elsif col_line = "0111" then
					  led <= "0010000000"; -- 7 S12
				 end if;
			when "100" =>
				row_line <= "1101"; --third row
			when "101" =>
				 if col_line = "1110" then
					  led <= "0100000000"; -- 8 S5
				 elsif col_line = "1101" then
					  led <= "1000000000"; -- 9 S6
				 elsif col_line = "1011" then
					  led <= "1000000001"; -- a S7
				 elsif col_line = "0111" then
					  led <= "1000000010"; -- b S8
				 end if;
			when "110" =>
				row_line <= "1110"; --fourth row
			when "111" =>
				 if col_line = "1110" then
					  led <= "1000000100"; -- C S1
				 elsif col_line = "1101" then
					  led <= "1000001000"; -- d S2
				 elsif col_line = "1011" then
					  led <= "1000010000"; -- e S3
				 elsif col_line = "0111" then
					  led <= "1000100000"; -- f S4
				 end if;
			when others => led <= "1010101010";
		end case;
end if;
end process;
end Behavioral;