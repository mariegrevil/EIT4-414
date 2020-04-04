entity T01_HelloWorldTb is
end entity;

architecture sim of T01_HelloWorldTb is
begin

	process is
	begin

		report "Hello World!";
		wait for 100 ns;
		report "Hello World!";
		wait for 100 ns;
		report "Hello World!";
		wait for 100 ns;


	end process;
	
end architecture;