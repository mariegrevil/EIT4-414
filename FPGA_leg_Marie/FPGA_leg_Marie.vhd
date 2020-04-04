library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;		-- unsigned type

-- entity declaration
entity FPGA_leg_Marie is
	-- optional generic declaration

	-- port declaration
	port (
		
		SW		:	in			STD_LOGIC_VECTOR(9 downto 0);
		LEDR	:	buffer	STD_LOGIC_VECTOR(9 downto 0));
end entity FPGA_leg_Marie;

-- architecture body
architecture RTL of FPGA_leg_Marie is
	-- internal signal declaration
	signal BitArray	:	STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
	
begin
	BitArray <= SW;
	-- processes
	process(BitArray) is
	begin
		for i in BitArray'left downto BitArray'right loop
			LEDR(i) <= BitArray(i);
		end loop;
	end process;
end architecture RTL;
