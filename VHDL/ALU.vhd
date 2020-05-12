LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.aux_package.all;
--USE ieee.numeric_std.ALL;
USE ieee.std_logic_ARITH.all;
use ieee.std_logic_unsigned.all;
-------------------------------------
ENTITY ALU IS
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
END ALU;
------------- complete the top Architecture code --------------
ARCHITECTURE struct OF ALU IS
	SIGNAL adderRes : std_logic_vector(2*n-1 DOWNTO 0);
	SIGNAL bsResultbsRes : std_logic_vector(2*n-1 DOWNTO 0);
	SIGNAL XwithZero : std_logic_vector(n DOWNTO 0); -- for the BarrelShfter
	SIGNAL ACC : std_logic_vector(2*n-1 DOWNTO 0); -- for the BarrelShfter
	
BEGIN
ACC<=(others=> '0');
PROCESS (OPC)
    variable intOPC: integer;
    BEGIN
    intOPC:= conv_integer(unsigned(OPC));
    RES<=(others=> '0');
	
  	case intOPC is
	  when 1 =>   RES(n downto 0) <= A+B;
	  when 2 =>   RES(n-1 downto 0) <= A-B;
	  when 3 =>   RES(n downto 0) <= A+B+cin;
	  when 4 =>   RES <= A*B;
	  when 5 =>   ACC <= A*B+ACC; RES<=ACC;
	  when 6 =>   ACC <= (others=>'0');
	  --when 7 and A<B =>   RES <= B; --max
	 -- when 7  =>   RES <= B;
	 -- when 8 and A<B =>   RES <= A; -- min
	  when others => RES(n-1 downto 0) <= B; --8
	end case;
  END PROCESS;
	
	
	
	
	
	
	-- XwithZero <= '0' & X;
	-- AddSub:Adder generic map (n) port map (
		-- cin => cin,
		-- x => X,y => Y,
		-- sel => sel, 
		-- s => adderRes(n-1 downto 0),
		-- cout =>adderRes(n)
	-- );
	-- MakeShifter: Shifter generic map (n+1,3) port map ( -- we did also Y(m) generic as a Bonus
		-- x => XwithZero,
		-- yi => Y,
		-- s =>bsResultbsRes
	-- );
	-- OutSel:outputSelector generic map (n) port map (
		-- adderResult => adderRes,
		-- bsResultbsResult => bsResultbsRes, 
		-- sel =>sel,
		-- res =>result
	-- );
	

END struct;
