LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;
USE work.aux_package.ALL;
entity tb_top is
	generic (
		n : positive := 8 ; -- A,B length
		m : positive := 5 ; -- OPC length
		k : positive := 2   -- STATUS length
	);
end tb_top;

ARCHITECTURE dtb_top OF tb_top IS

		signal rst,ena,clk,cin : std_logic;
		signal A,B : std_logic_vector(n-1 downto 0);
		signal OPC : std_logic_vector(m-1 downto 0);
		----------------------------------------
		signal RES : std_logic_vector(2*n-1 downto 0); -- RES(HI,LO)
		signal STATUS : std_logic_vector(k-1 downto 0);
	
begin
	tester : top generic map(n, m, k) port map(rst,ena,clk,cin,A,B,OPC,RES,STATUS);
	-- run for 3600 ns
	--------- start of stimulus section ------------------	
	tb_top_test : PROCESS
	BEGIN
		A<="00000001";
		B<="10000000";
		cin <= '0' ;
		OPC <= "00001";		--add no carry
		wait for 50 ns; 
		cin <= '1' ;
		wait for 50 ns;

		A<="00000001";
		B<="10000000";
		cin <= '0' ;
		OPC <= "00010";		--sub
		wait for 50 ns; 
		cin <= '1' ;
		wait for 50 ns;
		
		A<="00000001";
		B<="10000000";
		cin <= '0' ;
		OPC <= "00011";		--add with carry
		wait for 50 ns; 
		cin <= '1' ;
		wait for 50 ns;
		
		A<="00000011";
		B<="00000100";
		cin <= '0' ;
		OPC <= "00100";		--mult
		wait for 50 ns; 
		cin <= '1' ;
		wait for 50 ns;
		
		A<="00000001";
		B<="00000010";
		cin <= '0' ;
		OPC <= "00101";		--mac
		wait for 50 ns; 
		 
		A<="00000001";
		B<="00000010";
		cin <= '0' ;
		OPC <= "00101";		--mac
		wait for 50 ns; 
		A<="00000001";
		B<="00000010";
		cin <= '0' ;
		OPC <= "00101";		--mac
		wait for 50 ns; 
		 
		
		A<="00000001";
		B<="10000000";
		cin <= '0' ;
		OPC <= "00110";		--mac rst
		wait for 50 ns; 
		
		
		A<="00000001";
		B<="10000000";
		cin <= '0' ;
		OPC <= "00111";		--max
		wait for 50 ns; 
		cin <= '1' ;
		wait for 50 ns;
		
		A<="00000001";
		B<="10000000";
		cin <= '0' ;
		OPC <= "01000";		--min
		wait for 50 ns; 
		cin <= '1' ;
		wait for 50 ns;
		
		A<="00000001";
		B<="10000000";
		cin <= '0' ;
		OPC <= "01001";		--AND
		wait for 50 ns; 
		cin <= '1' ;
		wait for 50 ns;
		
		A<="00000001";
		B<="10000000";
		cin <= '0' ;
		OPC <= "01010";		--OR
		wait for 50 ns; 
		cin <= '1' ;
		wait for 50 ns;
		
		A<="00000001";
		B<="10000000";
		cin <= '0' ;
		OPC <= "01011";		--XOR
		wait for 50 ns; 
		cin <= '1' ;
		wait for 50 ns;
		
		A<="00000001";
		B<="00000010";
		cin <= '0' ;
		OPC <= "01100";		--RLA
		wait for 50 ns;
		A<="00000001";
		B<="00000100";
		cin <= '0' ;
		OPC <= "01100";		--RLA
		wait for 50 ns; 
		A<="00000001";
		B<="00100000";
		cin <= '0' ;
		OPC <= "01100";		--RLA
		wait for 50 ns; 
		
		A<="00000001";
		B<="00000100";
		cin <= '0' ;
		OPC <= "01101";		--RLC
		wait for 50 ns;
		A<="00000001";
		B<="00010000";
		cin <= '0' ;
		OPC <= "01101";		--RLC
		wait for 50 ns; 
		A<="00000001";
		B<="10000000";
		cin <= '0' ;
		OPC <= "01101";		--RLC
		wait for 50 ns; 
		
		A<="00000001";
		B<="00000100";
		cin <= '0' ;
		OPC <= "01110";		--RRA
		wait for 50 ns; 
		A<="00000001";
		B<="00010000";
		cin <= '0' ;
		OPC <= "01110";		--RRA
		wait for 50 ns; 
		A<="00000001";
		B<="10000000";
		cin <= '0' ;
		OPC <= "01110";		--RRA
		wait for 50 ns; 

		A<="00000001";
		B<="00000100";
		cin <= '0' ;
		OPC <= "01111";		--RRC
		wait for 50 ns; 
		A<="00000001";
		B<="00010000";
		cin <= '0' ;
		OPC <= "01111";		--RRC
		wait for 50 ns;
		A<="00000001";
		B<="10000000";
		cin <= '0' ;
		OPC <= "01111";		--RRC
		wait for 50 ns; 
		
		
		WAIT;
	END PROCESS tb_top_test;
	
	
	tb_ena : PROCESS
	BEGIN
		ena <= '1';--, '1' after 200 ns
		
		wait;
	END PROCESS tb_ena;
	
	tb_rst : PROCESS
	BEGIN
		rst <= '0';
		-- wait for 50 ns;
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

END dtb_top;