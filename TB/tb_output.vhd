LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;
USE work.aux_package.ALL;
ENTITY tb_output IS
	generic (
		n : positive := 8 ;
		m : positive := 5 ;
		k : positive := 2);
END tb_output;

ARCHITECTURE dtb_output OF tb_output IS
			
			signal HI,LO : std_logic_vector(n-1 downto 0);
			signal OPC : std_logic_vector(m-1 downto 0);
		----------------------------------------
			signal adderRes,shifterRes : std_logic_vector(2*n-1 downto 0); -- RES(HI,LO)
			signal shifterSTATUS,Status : std_logic_vector(k-1 downto 0);
	
begin
	tester : outputSelector generic map(n, m, k) port map(adderRes,shifterRes,shifterSTATUS,OPC,HI,LO,Status);
	-- run for 3600 ns
	--------- start of stimulus section ------------------	
	tbout : PROCESS
	BEGIN
		adderRes<="0000000000000000";
		shifterRes <="0000000000000001";
		shifterSTATUS<= "00";
		OPC <= "00001";
	    wait for 100 ns;
		OPC <= "11111";
		shifterRes <="0000000000000001";
		shifterSTATUS<= "11";
	    wait for 100 ns;
		OPC <= "01100";
	    wait for 100 ns;
		adderRes<="0011000000000000";
		OPC <= "00000";
	    wait for 100 ns;
		adderRes<="0011000000000100";
		OPC <= "11011";
	    wait for 100 ns;
		OPC <= "10111";
	    wait for 100 ns;
		OPC <= "01101";
		
		
		WAIT;
	END PROCESS tbout;


END dtb_output;