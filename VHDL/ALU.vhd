LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.aux_package.all;
USE ieee.numeric_std.ALL;
--USE ieee.std_logic_ARITH.all;
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
			RES : out std_logic_vector(2*n-1 downto 0); -- Result(HI,LO)
			STATUS : out std_logic_vector(k-1 downto 0));
END ALU;
------------- complete the top Architecture code --------------
ARCHITECTURE struct OF ALU IS

	SIGNAL adderResult : std_logic_vector(2*n-1 DOWNTO 0);
	SIGNAL bsResultultbsResult : std_logic_vector(2*n-1 DOWNTO 0);
	SIGNAL XwithZero : std_logic_vector(n DOWNTO 0); -- for the BarrelShfter
	SIGNAL ACC : std_logic_vector(2*n-1 DOWNTO 0):=(others=> '0'); -- for the BarrelShfter
	SIGNAL Result:std_logic_vector(2*n-1 downto 0);
BEGIN


PROCESS (OPC,A,B,cin)
variable Along,Blong:std_logic_vector(2*n-1 downto 0);
variable AccVar:std_logic_vector(2*n DOWNTO 0);
	BEGIN
	Along:=(others=> '0');
	Blong:=(others=> '0');
	Along(n-1 downto 0) := A;
	Blong(n-1 downto 0) := B;


	Result <= ( others => '0');

	  	case OPC(4 downto 0) is
		  when "00001" =>   Result <= Along+Blong;
		  when "00010" =>   Result <= Along-Blong;
		  when "00011" =>   Result <= Along+Blong+cin;
		  when "00100" =>   Result <= std_logic_vector(unsigned(A)*unsigned(B));
		  when "00101" => AccVar :=  std_logic_vector(unsigned(A)*unsigned(B)+ unsigned(ACC));
						ACC <=AccVar(2*n-1 DOWNTO 0);
						Result <= AccVar(2*n-1 DOWNTO 0);
		  when "00110" =>   ACC <= (others=>'0'); --acc Resultet
		  when "00111" => if A<B then
							Result <= Blong; --max
							else Result <= Along;
							end if;
							
		  when "01000" => if A<B then
				Result <= Along; --min
				else Result <= Blong;
				end if;
							
		   when others => Result <= (others=> '1'); --not for me 
		end case;
		
		
		if Result = 0 then 
			STATUS <= "10";
			else 
			STATUS<= "00";
		end if;
		if AccVar(2*n) = '0' then
			STATUS <= "00";
			else 
			STATUS<= "01";
			AccVar:=(others=> '0');
		end if;
		RES<= Result;
	END PROCESS;
	
	
	
	
	
	

END struct;

--configure list -delta collapse