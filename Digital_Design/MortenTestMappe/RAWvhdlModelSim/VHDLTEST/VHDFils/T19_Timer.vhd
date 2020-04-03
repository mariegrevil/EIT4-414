library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T19_Timer is
generic(ClockFrequencyHz : integer);
port(
	Clk 	: in std_logic;
	nRst 	: in std_logic;
	Seconds : inout integer;
	Minutes : inout integer;
	Hours 	: inout integer);
	
end entity;

architecture rtl of T19_Timer is
signal Ticks : integer;

procedure IncrementWrap(signal 	 Counter : inout integer;
						constant WrapVal : in integer;
						constant Enable  : in boolean;
						variable Wrapped : out boolean) is
	begin
		if Enable then
			if Counter = WrapVal -1 then
				Wrapped := true;
				Counter <= 0;
			else
				Wrapped := false;
				Counter <= Counter + 1;
			end if;
		end if;	
end procedure;

begin
	
	process(Clk) is
		variable Wrap : boolean;
	begin 
		if rising_edge(Clk) then
		
			if nRst = '0' then -- if negative rest is active
				Ticks 	<= 0;
				Seconds <= 0;
				Minutes <= 0;
				Hours 	<= 0;
			else
			
			IncrementWrap(Ticks, 	ClockFrequencyHz,	true, Wrap);
			IncrementWrap(Seconds,  60, 				Wrap, Wrap);
			IncrementWrap(Minutes,  60, 				Wrap, Wrap);
			IncrementWrap(Hours, 	24, 				Wrap, Wrap);
			
			end if;
				
		end if;
	
	end process;
	
end architecture;