LIBRARY ieee;
USE ieee.std_logic_1164.all;
-------------------------------------
ENTITY MuxChain IS
  GENERIC (n : INTEGER := 4);
  PORT (     xi: IN STD_LOGIC_VECTOR (2*n-1 DOWNTO 0);
			 y: IN STD_LOGIC;
             zi: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));             
END MuxChain;
--------------------------------------------------------------
ARCHITECTURE dMuxChain OF MuxChain IS
	component MUX is
		PORT (x1, x2, y: IN std_logic;
			      z : OUT std_logic);
	end component;	
BEGIN
	
	SETUP : for i in 0 to n-1 generate
		chain : MUX port map(
			x1 => xi(2*i),
			x2 => xi(2*i+1),
			y => y,
			z => zi(i)
		);
	end generate;
	
END dMuxChain;

