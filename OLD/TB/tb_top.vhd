-- Test Bench for Counter.
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;


entity tb_top is
  GENERIC (n : INTEGER := 4);
end tb_top;

architecture rtl of tb_top is  
signal  X,Y:STD_LOGIC_VECTOR (n-1 DOWNTO 0);  --For PART#1
signal	cin :STD_LOGIC;
signal	sel :STD_LOGIC_VECTOR (1 DOWNTO 0);
signal result:STD_LOGIC_VECTOR(n downto 0);

signal  X2,Y2:STD_LOGIC_VECTOR (2*n-1 DOWNTO 0);  --For PART#2
signal	cin2 :STD_LOGIC;
signal	sel2 :STD_LOGIC_VECTOR (1 DOWNTO 0);
signal result2:STD_LOGIC_VECTOR(2*n downto 0);


begin
        tester1 : top generic map (4) port map(
			X=>X,Y=>Y,sel=>sel,cin=>cin, result=>result
		);
        tester2 : top generic map (8) port map(
			X=>X2,Y=>Y2,sel=>sel2,cin=>cin2, result=>result2
		);
        testbench : process
        begin
		----------Part 1 
           --------- start of stimulus section - TEST#1 ------------------

           X <="1111";
		   Y <="0000";
		   cin<= '0';
		   sel<="00";
		   for i in 0 to 3 loop		--SEL FOR
			wait for 50 ns;
			cin <= '1';
			wait for 50 ns;
			sel <= sel +1;
			cin <= '0';
		   end loop;
		   --------- start of stimulus section - TEST#2 ------------------
           X <="1010";
		   Y <="0010";
		   cin<= '0';
		   sel<="00";
		   for i in 0 to 3 loop		--SEL FOR
			wait for 50 ns;
			cin <= '1';
			wait for 50 ns;
			sel <= sel +1;
			cin <= '0';
		   end loop;
		   --------- start of stimulus section - TEST#3 ------------------
           X <="0001";
		   Y <="1010";
		   cin<= '0';
		   sel<="00";
		   for i in 0 to 3 loop		--SEL FOR
			wait for 50 ns;
			cin <= '1';
			wait for 50 ns;
			sel <= sel +1;
			cin <= '0';
		   end loop;
		   --------- start of stimulus section - TEST#4 ------------------
           X <="0001";
		   Y <="1111";
		   cin<= '0';
		   sel<="00";
		   for i in 0 to 3 loop		--SEL FOR
			wait for 50 ns;
			cin <= '1';
			wait for 50 ns;
			sel <= sel +1;
			cin <= '0';
		   end loop;

		  ----------Part 2 
           --------- start of stimulus section - TEST#1 ------------------

           X2 <="11011001";
		   Y2 <="01011100";
		   cin2<= '0';
		   sel2<="00";
		   for i in 0 to 3 loop		--SEL FOR
			wait for 50 ns;
			cin2 <= '1';
			wait for 50 ns;
			sel2 <= sel2 +1;
			cin2 <= '0';
		   end loop;
		   --------- start of stimulus section - TEST#2 ------------------
           X2 <="11101101";
		   Y2 <="11111001";
		   cin2<= '0';
		   sel2<="00";
		   for i in 0 to 3 loop		--SEL FOR
			wait for 50 ns;
			cin2 <= '1';
			wait for 50 ns;
			sel2 <= sel2 +1;
			cin2 <= '0';
		   end loop;
		   --------- start of stimulus section - TEST#3 ------------------
           X2 <="00010001";
		   Y2 <="10101010";
		   cin2<= '0';
		   sel2<="00";
		   for i in 0 to 3 loop		--SEL FOR
			wait for 50 ns;
			cin2 <= '1';
			wait for 50 ns;
			sel2 <= sel2 +1;
			cin2 <= '0';
		   end loop;
		   --------- start of stimulus section - TEST#4 ------------------
           X2 <="00010001";
		   Y2 <="11111111";
		   cin2<= '0';
		   sel2<="00";
		   for i in 0 to 3 loop		--SEL FOR
			wait for 50 ns;
			cin2 <= '1';
			wait for 50 ns;
			sel2 <= sel2 +1;
			cin2 <= '0';
		   end loop;
		  wait;
		  --------- end of stimulus section----------------------------

        end process testbench;
        
end rtl;
