LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------------------------------
entity top is
	generic (
		n : positive := 8 ; -- A,B length
		m : positive := 5 ; -- OPC length
		k : positive := 2   -- STATUS length
	);
	port(
		rst,ena,clk: in std_logic;
		cin : in std_logic;
		A,B : in std_logic_vector(n-1 downto 0);
		OPC : in std_logic_vector(m-1 downto 0);
		----------------------------------------
		RES : out std_logic_vector(2*n-1 downto 0); -- RES(HI,LO)
		STATUS : out std_logic_vector(k-1 downto 0)
	);
end top;
------------- complete the top Architecture code --------------
architecture arc_sys of top is
	signal cinlast :std_logic:='0';
	signal HI,LO :std_logic_vector(n-1 downto 0):=(others=> '0');
	signal Alast,Blast : std_logic_vector(n-1 downto 0):=(others=> '0');
	signal OPClast : std_logic_vector(m-1 downto 0):=(others=> '0');
	signal RESlast :  std_logic_vector(2*n-1 downto 0):=(others=> '0');
	signal STATUSlast,STA :  std_logic_vector(k-1 downto 0):=(others=> '0');
	
begin
--------------------------------------------------------------
ALUBuild : topALU generic map(n, m, k) port map(rst,ena,clk,cinlast,Alast,Blast,OPClast,HI,LO,STA);
		-- RESlast(n-1 downto 0)<=LO;
		-- RESlast(2*n-1 downto n)<=HI;
--------------------------------------------------------------
PROCESS (clk, rst) --sequntial
  BEGIN
	IF (rst='1') THEN
		Alast <= (others => '0');
		Blast <= (others => '0');
		cinlast<='0';
		OPClast <= (others => '0');
		RESlast <= (others => '0');
	ELSIF (clk'EVENT and clk='1') THEN
		IF (ena = '1') THEN
		---------------in------------------
		Alast <= A;
		Blast <= B;
		cinlast<=cin;
		OPClast <= OPC;
		-------------out-------------------
		RESlast(n-1 downto 0)<=LO;
		RESlast(2*n-1 downto n)<=HI;
		STATUSlast<=STA;
		END IF;
   END IF;
  END PROCESS;
  

   Res<=RESlast;
   STATUS<=STATUSlast;
   
end arc_sys;







