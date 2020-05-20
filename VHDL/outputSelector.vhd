LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.aux_package.all;
USE ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.all;
-------------------------------------
ENTITY outputSelector IS
  GENERIC (
		n : positive := 8 ; -- A,B length
		m : positive := 5 ; -- OPC length
		k : positive := 2   -- STATUS length
		);
  PORT ( 	
			adderRes,shifterRes: in STD_LOGIC_VECTOR (2*n-1 downto 0);
			shifterSTATUS : in std_logic_vector(k-1 downto 0);
			OPC : in std_logic_vector(m-1 downto 0);
		
		----------------------------------------
			HI,LO : out std_logic_vector(n-1 downto 0);
			Status: out std_logic_vector(k-1 downto 0));
			
END outputSelector;
--------------------------------------------------------------
ARCHITECTURE ops OF outputSelector IS
	
BEGIN

PROCESS (OPC,adderRes,shifterRes,shifterSTATUS)
BEGIN
	if OPC(3 downto 2) = "11" then --shifter
		HI<=shifterRes(2*n-1 downto n);
		LO<=shifterRes(n-1 downto 0);
		STATUS<= shifterSTATUS;
	else -- alu result
		if adderRes(2*n-1 downto n)>0 then STATUS(0)<='1'; else STATUS(0)<='0'; END IF;
		if adderRes(n-1 downto 0)=0 then STATUS(1)<='1';else STATUS(1)<='0'; END IF;
		HI<=adderRes(2*n-1 downto n);
		LO<=adderRes(n-1 downto 0);
	end if;
end process;

	
END ops;

--configure list -delta collapse