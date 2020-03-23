-- Segment Driver [By Johnni :D]

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
--use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


entity segment_driver is
	--setup:
	port	(	display_A	:	in 	std_logic_vector(3 downto 0);
				display_B	:	in 	std_logic_vector(3 downto 0);
				display_C	:	in 	std_logic_vector(3 downto 0);
				display_D	:	in 	std_logic_vector(3 downto 0);
				
				segA	:	out	std_logic;
				segB	:	out	std_logic;
				segC	:	out	std_logic;
				segD	:	out	std_logic;
				segE	:	out	std_logic;
				segF	:	out	std_logic;
				segG	:	out	std_logic;
				
				select_display_A		:	out	std_logic;
				select_display_B		:	out	std_logic;
				select_display_C		:	out	std_logic;
				select_display_D		:	out	std_logic;
				
				clk	:	in	std_logic);
	
end segment_driver;


architecture rtl of segment_driver is
	-- loop:
	-- Component declaration:
	
	component segmentDecoder
		port	(
					Digit	:	in	std_logic_vector(3 downto 0);
					segment_A	:	out	std_logic;
					segment_B	:	out	std_logic;
					segment_C	:	out	std_logic;
					segment_D	:	out	std_logic;
					segment_E	:	out	std_logic;
					segment_F	:	out	std_logic;
					segment_G	:	out	std_logic
				);
				
	end component;	
	
	component clock_divider
		port	(
					clk		:	in std_logic;
					enable	:	in std_logic;
					reset		:	in std_logic;
					data_clk	:	in std_logic_vector(15 downto 0)
				);
	end component;
	
signal temperary_data : std_logic_vector(3 downto 0);
signal clock_word	: std_logic_vector(15 downto 0);
signal slow_clock : std_logic;

begin
	-- component instantiation
	uut	: work.segment_decoder port map(
												Digit => temperary_data,
												segment_A => segA,
												segment_B => segB,
												segment_C => segC,
												segment_D => segD,
												segment_E => segE,
												segment_F => segF,
												segment_G => segG
											);
											
	uut1	: work.clock_divider port	map(
												clk 		=> clk,
												enable	=> '1',
												reset		=> '0',
												data_clk	=> clock_word
											);
	slow_clock <= clock_word(15);

	process(slow_clock)
		variable display_selection : std_logic_vector(1 downto 0);
		
		begin
			if slow_clock'event and slow_clock = '1' then
				case display_selection is
				
					when "00" => temperary_data <= display_A;

						select_display_A <= '0';
						select_display_B <= '1';
						select_display_C <= '1';
						select_display_D <= '1';
						
						display_selection := display_selection + '1';
					
					when "01" => temperary_data <= display_B;

						select_display_A <= '1';
						select_display_B <= '0';
						select_display_C <= '1';
						select_display_D <= '1';
						
						display_selection := display_selection + '1';
					
					when "10" => temperary_data <= display_C;

						select_display_A <= '1';
						select_display_B <= '1';
						select_display_C <= '0';
						select_display_D <= '1';
						
						display_selection := display_selection + '1';
					
					when others => temperary_data <= display_D;

						select_display_A <= '1';
						select_display_B <= '1';
						select_display_C <= '1';
						select_display_D <= '0';
						
						display_selection := display_selection + '1';
					
				end case;
			
			end if;
				
	end process;				
	
end rtl;








