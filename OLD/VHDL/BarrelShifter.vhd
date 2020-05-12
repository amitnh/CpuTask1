LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.math_real.all;
-------------------------------------
ENTITY BarrelShfter IS
  GENERIC (n : INTEGER;m : INTEGER);
  PORT (    x: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			yi: IN STD_LOGIC_VECTOR (n-2 DOWNTO 0);
            s: OUT STD_LOGIC_VECTOR(n-1 downto 0));
END BarrelShfter;
--------------------------------------------------------------
ARCHITECTURE dbs OF BarrelShfter IS
COMPONENT MuxChain IS
  GENERIC (n : INTEGER);
  PORT (    xi: IN STD_LOGIC_VECTOR (2*n-1 DOWNTO 0);
			y: IN STD_LOGIC;             
			zi: OUT STD_LOGIC_VECTOR(n-1 downto 0));
END COMPONENT;
	TYPE matrix1 is array (0 to m-1) OF STD_LOGIC_VECTOR (2*n-1 downto 0);
	TYPE matrix2 is array (0 to m) OF STD_LOGIC_VECTOR (n-1 downto 0);
	--TYPE matrix is array (0 to m-1,2*n-1 downto 0) OF STD_LOGIC;
	SIGNAL entry: matrix1;-- matrix of entrie to each muxChain
	SIGNAL exitMat: matrix2;-- matrix of exits to each muxChain
	
BEGIN	
	exitMat(0)<=x;
		yFor:for i in 0 to m-1 GENERATE
			muxFor:for j in 0 to n-1-(2**i) GENERATE 
				entry(i)(2*j+1)<=exitMat(i)(j);				
				entry(i)((2**i-1)*2+1+2*j+1)<=exitMat(i)(j);
			END GENERATE;
			rest:for j in n-(2**i) to n-1 GENERATE
				entry(i)(2*j+1)<=exitMat(i)(j);
				entry(i)((n-1-j)*2)<='0';
			END GENERATE;
			chain :  MuxChain generic map (n=>n) port map(
				xi => entry(i),
				y => yi(i),
				zi=>exitMat(i+1)
			);
		END GENERATE;	
		s<=exitMat(m);
END dbs;

