LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.aux_package.all;

-------------------------------------
ENTITY top IS
  GENERIC (n : INTEGER := 8);
  PORT (    cin : IN STD_LOGIC;
			sel : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			 X,Y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		  result: OUT STD_LOGIC_VECTOR(n downto 0));
END top;
------------- complete the top Architecture code --------------
ARCHITECTURE struct OF top IS
	SIGNAL adderRes : std_logic_vector(n DOWNTO 0);
	SIGNAL bsResultbsRes : std_logic_vector(n DOWNTO 0);
	SIGNAL XwithZero : std_logic_vector(n DOWNTO 0); -- for the BarrelShfter
	
BEGIN
	XwithZero <= '0' & X;
	AddSub:Adder generic map (n) port map (
		cin => cin,
		x => X,y => Y,
		sel => sel, 
		s => adderRes(n-1 downto 0),
		cout =>adderRes(n)
	);
	Bshifter:BarrelShfter generic map (n+1,3) port map ( -- we did also Y(m) generic as a Bonus
		x => XwithZero,
		yi => Y,
		s =>bsResultbsRes
	);
	OutSel:outputSelector generic map (n) port map (
		adderResult => adderRes,
		bsResultbsResult => bsResultbsRes, 
		sel =>sel,
		res =>result
	);
	

END struct;

