LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;
USE work.aux_package.ALL;
ENTITY tb_alu IS
	generic (
		n : positive := 8 ;
		m : positive := 5 ;
		k : positive := 2);
END tb_alu;

ARCHITECTURE dftb_alu OF tb_alu IS

			signal rst,ena,clk,cin : STD_LOGIC;
			signal A,B : std_logic_vector(n-1 downto 0);
			signal OPC : std_logic_vector(m-1 downto 0);
		----------------------------------------
			signal RES : std_logic_vector(2*n-1 downto 0); -- RES(HI,LO)
			signal STATUS : std_logic_vector(k-1 downto 0);
	
begin
	tester : ALU generic map(n, m, k) port map(rst,ena,clk,cin,A,B,OPC,RES);
	-- run for 3600 ns
	--------- start of stimulus section ------------------	
	tb_test : PROCESS
	BEGIN
		A<="00000010";
		B<="00000001";
		cin <= '0' ;
		OPC<="00101";
		wait for 50 ns;OPC<="00101";
		wait for 50 ns;OPC<="00101";
		wait for 50 ns;OPC<="00101";
		wait for 50 ns;OPC<="00101";
		wait for 50 ns;OPC<="00101";
		wait for 50 ns;
		
		-- OPC<="00101";
		-- wait for 100 ns;
		
		-- OPC<="00100";
		-- wait for 100 ns;
		-- OPC<="00101";
		-- wait for 100 ns;
		-- OPC<="00100";
		-- wait for 100 ns;
		-- OPC<="00101";
		-- wait for 100 ns;
		-- OPC<="00100";
		-- wait for 100 ns;		
		-- OPC<="00101";
		-- wait for 100 ns;
		-- wait for 100 ns;
		-- OPC<="00100";
		-- wait for 100 ns;		
		-- OPC<="00101";
		-- wait for 100 ns;
		-- wait for 100 ns;
		-- OPC<="00100";
		-- wait for 100 ns;		
		-- OPC<="00101";
		-- wait for 100 ns;
		
		-- cin <= '1' ;
		-- OPC <= (others=>'0');
		-- wait for 100 ns;
		-- OPC<="00101";
		-- wait for 100 ns;
		-- OPC<="00101";
		-- wait for 100 ns;
		-- OPC<="00101";
		-- wait for 100 ns;
		-- OPC<="00101";
		-- wait for 100 ns;
		-- OPC<="00101";
		-- wait for 100 ns;
		-- OPC<="00101";
		-- wait for 100 ns;
		-- OPC<="00101";
		-- wait for 100 ns;		
		-- OPC<="00101";
		-- wait for 100 ns;
		
		-- FOR i IN 0 TO 10 LOOP
			-- OPC <= OPC +'1';
			-- wait for 100 ns;
		-- END LOOP;
		
		-- cin <= '1';
		
		-- OPC <= (others=>'0');
		-- FOR i IN 0 TO 10 LOOP
			-- OPC <= OPC +'1';
			-- wait for 100 ns;
		-- END LOOP;
		WAIT;
	END PROCESS tb_test;

tb_ena : PROCESS
	BEGIN
		ena <= '1';--, '1' after 200 ns
		
		wait;
	END PROCESS tb_ena;
	
	tb_rst : PROCESS
	BEGIN
		rst <= '0';
		-- wait for 100 ns;
		-- rst <= '0';
		wait;
	END PROCESS tb_rst;
	
		tb_clk : PROCESS
	BEGIN
		clk <= '0' ;
		WAIT FOR 50 ns;
		clk <= '1'; 
		WAIT FOR 50 ns;
	END PROCESS tb_clk;

END dftb_alu;