LIBRARY ieee;
USE ieee.std_logic_1164.all;
-------------------------------------
ENTITY outputSelector IS
  GENERIC (n : INTEGER);
  PORT ( adderResult,bsResultbsResult: IN STD_LOGIC_VECTOR (n DOWNTO 0);
			sel: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
            res: OUT STD_LOGIC_VECTOR(n downto 0));
END outputSelector;
--------------------------------------------------------------
ARCHITECTURE ops OF outputSelector IS
	
BEGIN
	res <= bsResultbsResult when (sel= "11") else adderResult;
	
END ops;

