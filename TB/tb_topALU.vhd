LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;
USE work.aux_package.ALL;
ENTITY tb_topALU IS
	generic (
		n : positive := 8 ;
		m : positive := 5 ;
		k : positive := 2);
END tb_topALU;

ARCHITECTURE dtb_topALU OF tb_topALU IS

			signal cin : STD_LOGIC;
			signal A,B : std_logic_vector(n-1 downto 0);
			signal OPC : std_logic_vector(m-1 downto 0);
		----------------------------------------
			signal HI,LO : std_logic_vector(n-1 downto 0);
			signal Status: std_logic_vector(k-1 downto 0);
	
begin
	tester : topALU generic map(n, m, k) port map(cin,A,B,OPC,HI,LO,STATUS);
	-- run for 3600 ns
	--------- start of stimulus section ------------------	
	tb_clk : PROCESS
	BEGIN
	wait for 100 ns;
		A<="00000001";--add no carry
		B<="10000000";
		cin <= '1' ;
		OPC <= "00001";
		wait for 100 ns; --
		A<="00000011";--add no carry
		B<="10000000";
		cin <= '1' ;
		OPC <= "00001";
		wait for 100 ns; --
		A<="00000001";--add no carry
		B<="10000000";
		cin <= '1' ;
		OPC <= "00001";
		wait for 100 ns; --
		A<="00000001";
		B<="00000101";
		cin <= '0' ;
		OPC <= "00010";
		wait for 100 ns; --
		A<="00000001";
		B<="00000101";
		cin <= '0' ;
		OPC <= "00011";
		wait for 100 ns; 
		A<="00000001";
		B<="00000101";
		cin <= '0' ;
		OPC <= "00001";
		wait for 100 ns; --RLC 5 times
		A<="00000001";
		B<="00000101";
		cin <= '0' ;
		OPC <= "01101";
		wait for 100 ns; --XOR
		A<="10101010";
		B<="10001000";
		cin <= '0' ;
		OPC <= "01011";
		wait for 100 ns; --RRC 3 times
		A<="01010101";
		B<="00000011";
		cin <= '0' ;
		OPC <= "01111";
		
		
		
		
		
		
		
	
		WAIT;
	END PROCESS tb_clk;


END dtb_topALU;