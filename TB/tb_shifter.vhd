LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;
USE work.aux_package.ALL;
ENTITY tb_shifter IS
	generic (
		n : positive := 8 ;
		m : positive := 5 ;
		k : positive := 2);
END tb_shifter;

ARCHITECTURE dtb_shifter OF tb_shifter IS

			signal cin : STD_LOGIC;
			signal A : std_logic_vector(n-1 downto 0);
			signal B : std_logic_vector(2 downto 0);
			signal OPC : std_logic_vector(m-1 downto 0);
		----------------------------------------
			signal RES : std_logic_vector(2*n-1 downto 0); -- RES(HI,LO)
			signal STATUS : std_logic_vector(k-1 downto 0);
	
begin
	tester : Shifter generic map(n, m, k) port map(cin,A,B,OPC,RES,STATUS);
	-- run for 3600 ns
	--------- start of stimulus section ------------------	
	tb_clk : PROCESS
	BEGIN
		A<="00000001";
		B<="001";
		cin <= '0' ;
		OPC <= "01100";
		wait for 100 ns;
		OPC <= "01101";
		wait for 100 ns;
		OPC <= "01110";
		wait for 100 ns;
		OPC <= "01111";
		wait for 100 ns;

		cin <= '1' ;
		OPC <= "01100";
		wait for 100 ns;
		OPC <= "01101";
		wait for 100 ns;
		OPC <= "01110";
		wait for 100 ns;
		OPC <= "01111";
		wait for 100 ns;
		
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
	END PROCESS tb_clk;


END dtb_shifter;