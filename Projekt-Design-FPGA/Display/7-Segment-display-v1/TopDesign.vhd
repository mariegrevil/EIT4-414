-- TopDesign [By Johnni :D]

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
--use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity TopDesign is
	--setup:
	port	(	switch0	:	in std_logic;
				switch1	:	in std_logic;
				switch2	:	in std_logic;
				switch3	:	in std_logic;
				switch4	:	in std_logic;
				switch5	:	in std_logic;
				switch6	:	in std_logic;
				switch7	:	in std_logic;
				
				clk	:	in std_logic;
				
				topselDispA	:	out std_logic;
				topselDispB	:	out std_logic;
				topselDispC	:	out std_logic;
				topselDispD	:	out std_logic;
				
				topsegA	:	out std_logic;
				topsegB	:	out std_logic;
				topsegC	:	out std_logic;
				topsegD	:	out std_logic;
				topsegE	:	out std_logic;
				topsegF	:	out std_logic;
				topsegG	:	out std_logic;
				
				
		);
				
				
end TopDesign;


architecture rtl of TopDesign is
	-- loop:

	component segment_driver
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
		
	end component;

signal Ai : std_logic_vector(3 downto 0);
signal Bi : std_logic_vector(3 downto 0);
signal Ci : std_logic_vector(3 downto 0);
signal Di : std_logic_vector(3 downto 0);
--signal Ei : std_logic_vector(3 downto 0);
--signal Fi : std_logic_vector(3 downto 0);
signal 	
	
begin
	uut2 : segment_driver port	map(
				
				display_A => Ai,
				display_B => Bi,
				display_C => Ci,
				display_D => Di,
				
				segA => topsegA,
				segB => topsegB,
				segC => topsegC,
				segD => topsegD,
				segE => topsegE,
				segF => topsegF,
				segG => topsegG,
				
				select_display_A => topselDispA,
				select_display_B => topselDispB,
				select_display_C => topselDispC,
				select_display_D => topselDispD,
				
				clk => clk
				);
				
	Ai(0) <= switch0;
	Ai(1) <= switch1;
	Ai(2) <= switch2;
	Ai(3) <= switch3;
	Bi(0) <= switch4;
	Bi(1) <= switch5;
	Bi(2) <= switch6;
	Bi(3) <= switch7;
	
	
	-- For at fylde de resterende display felter med 'TOM' tegnet (til test)
	Ci <= "1111";
	Di <= "1111";
	
	
end rtl;

