LIBRARY ieee;
USE ieee.std_logic_1164.all;


package aux_package is

	component top is
	GENERIC (n : INTEGER);
	PORT (    cin : IN STD_LOGIC;
			sel : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			 X,Y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		  result: OUT STD_LOGIC_VECTOR(n downto 0));
	end component;
component BarrelShfter IS
  GENERIC (n : INTEGER; m : INTEGER);
  PORT (    x: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			yi: IN STD_LOGIC_VECTOR (n-2 DOWNTO 0);
            s: OUT STD_LOGIC_VECTOR(n-1 downto 0));
END component;  
 component Adder IS
  GENERIC (n : INTEGER);
  PORT (     cin: IN STD_LOGIC;
			 x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			 sel: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
            cout: OUT STD_LOGIC;
               s: OUT STD_LOGIC_VECTOR(n-1 downto 0));
END component;
 component outputSelector IS
  GENERIC (n : INTEGER);
  PORT (    adderResult,bsResultbsResult: IN STD_LOGIC_VECTOR (n DOWNTO 0);
			sel: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
            res: OUT STD_LOGIC_VECTOR(n downto 0));
END component outputSelector;
  
  
end aux_package;

