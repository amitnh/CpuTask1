LIBRARY ieee;
USE ieee.std_logic_1164.all;


package aux_package is
-----------------------------------------------------------------
  component top is
	generic (
		n : positive := 8 ; -- A,B length
		m : positive := 5 ; -- OPC length
		k : positive := 2   -- STATUS length
	);
	port(
		rst,ena,clk,cin : in std_logic;
		A,B : in std_logic_vector(n-1 downto 0);
		OPC : in std_logic_vector(m-1 downto 0);
		----------------------------------------
		RES : out std_logic_vector(2*n-1 downto 0); -- RES(HI,LO)
		STATUS : out std_logic_vector(k-1 downto 0)
	);
  end component;
  
  component ALU IS
  generic (
		n : positive := 8 ; -- A,B length
		m : positive := 5 ; -- OPC length
		k : positive := 2   -- STATUS length
	);
  PORT (    cin : IN STD_LOGIC;
			A,B : in std_logic_vector(n-1 downto 0);
			OPC : in std_logic_vector(m-1 downto 0);
		----------------------------------------
			RES : out std_logic_vector(2*n-1 downto 0); -- RES(HI,LO)
			STATUS : out std_logic_vector(k-1 downto 0));
END component;
-----------------------------------------------------------------
	






  
  
  
  
end aux_package;

