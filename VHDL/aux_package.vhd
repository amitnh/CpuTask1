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
			RES : out std_logic_vector(2*n-1 downto 0)); -- RES(HI,LO)
			
END component;
-----------------------------------------------------------------
component Shifter IS
  generic (
		n : positive := 8 ; -- A,B length
		m : positive := 5 ; -- OPC length
		k : positive := 2   -- STATUS length
	);
  PORT (    cin : IN STD_LOGIC;
			A : in std_logic_vector(n-1 downto 0);
			B : in std_logic_vector(2 downto 0);
			OPC : in std_logic_vector(m-1 downto 0);

		----------------------------------------
			RES : out std_logic_vector(2*n-1 downto 0); -- Result(HI,LO)
			STATUS : out std_logic_vector(k-1 downto 0));
END component;
-----------------------------------------------------------------------------------
component outputSelector IS
  generic (
		n : positive := 8 ; -- A,B length
		m : positive := 5 ; -- OPC length
		k : positive := 2   -- STATUS length
	);
  PORT (    adderRes,shifterRes: in STD_LOGIC_VECTOR (2*n-1 downto 0);
			       shifterSTATUS : in std_logic_vector(k-1 downto 0);
            OPC : in std_logic_vector(m-1 downto 0);

		----------------------------------------
			

		----------------------------------------
			HI,LO : out std_logic_vector(n-1 downto 0);
			Status: out std_logic_vector(k-1 downto 0)
			);
END component;
------------------------------------------------------------
component topALU IS
  GENERIC (
		n : positive := 8 ; -- A,B length
		m : positive := 5 ; -- OPC length
		k : positive := 2   -- STATUS length
		);
  PORT ( 			
		----------------------------------------
			cin : IN STD_LOGIC;
			A : in std_logic_vector(n-1 downto 0);
			B : in std_logic_vector(2 downto 0);
			OPC : in std_logic_vector(m-1 downto 0);

		----------------------------------------
			HI,LO : out std_logic_vector(n-1 downto 0);
			Status: out std_logic_vector(k-1 downto 0));
			
END component;
-------------------------------------
component Adder IS
  GENERIC (n : INTEGER);
  PORT (     cin: IN STD_LOGIC;
			 x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			 sel: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
            cout: OUT STD_LOGIC;
               s: OUT STD_LOGIC_VECTOR(n-1 downto 0));
END component;
  
end aux_package;

