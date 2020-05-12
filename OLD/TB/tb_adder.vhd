-- Test Bench for Adder.
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity tb_adder is
	constant m : integer := 8;
end tb_adder;

architecture rtb of tb_adder is
  component Adder is
	GENERIC (n : INTEGER);
	PORT (   cin: IN STD_LOGIC;
			 x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			 sel: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
            cout: OUT STD_LOGIC;
               s: OUT STD_LOGIC_VECTOR(n-1 downto 0));
  end component;
	SIGNAL cin,cout : STD_LOGIC;
	SIGNAL sel : STD_LOGIC_VECTOR (1 DOWNTO 0);
	SIGNAL x,y,s : STD_LOGIC_VECTOR (m-1 DOWNTO 0);
begin
	L0 : Adder generic map (m) port map(cin,x,y,sel,cout,s);
    
	--------- start of stimulus section ------------------ TEST#1	
        tb : process
        begin

		  x <= "11101101";
		  y <= "11111001";
		  cin<='0';
		  sel<="00";
		  for i in 0 to 2 loop
			wait for 50 ns;
			sel <= sel +1;
		  end loop;
		  sel<="00";
		  cin<='1';
		  for i in 0 to 2 loop
			wait for 50 ns;
			sel <= sel +1;
		  end loop;
		  ------------------------------------------------TEST#2	
		  x <= "11111111";
		  y <= "11111111";
		  cin<='0';
		  sel<="00";
		  for i in 0 to 2 loop
			wait for 50 ns;
			sel <= sel +1;
		  end loop;
		  sel<="00";
		  cin<='1';
		  for i in 0 to 2 loop
			wait for 50 ns;
			sel <= sel +1;
		  end loop;
		  ------------------------------------------------TEST#3	
		  x <= "11111111";
		  y <= "00000001";
		  cin<='0';
		  sel<="00";
		  for i in 0 to 2 loop
			wait for 50 ns;
			sel <= sel +1;
		  end loop;
		  sel<="00";
		  cin<='1';
		  for i in 0 to 2 loop
			wait for 50 ns;
			sel <= sel +1;
		  end loop;
		  
		  wait;
		  
		  
        end process tb;
		  		
  
end architecture rtb;
