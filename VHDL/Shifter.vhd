LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.aux_package.all;
USE ieee.numeric_std.ALL;
--USE ieee.std_logic_ARITH.all;
use ieee.std_logic_unsigned.all;
-------------------------------------
ENTITY Shifter IS
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
END Shifter;
------------- complete the top Architecture code --------------
ARCHITECTURE struct OF Shifter IS
	-- SIGNAL adderResult : std_logic_vector(2*n-1 DOWNTO 0);
	-- SIGNAL bsResultultbsResult : std_logic_vector(2*n-1 DOWNTO 0);
	-- SIGNAL XwithZero : std_logic_vector(n DOWNTO 0); -- for the BarrelShfter
	-- SIGNAL ACC : std_logic_vector(2*n-1 DOWNTO 0):=(others=> '0'); -- for the BarrelShfter
	-- SIGNAL Result:std_logic_vector(2*n-1 downto 0);


BEGIN

			
PROCESS (OPC,A,B,cin)
	variable A_unsig: UNSIGNED(n DOWNTO 0);
	variable Bint: integer;
	variable AandCin: std_logic_vector(n DOWNTO 0);

	BEGIN	
		RES<=(others=> '0');
		STATUS<=(others=> '0');

		Bint := to_integer(unsigned(B));
		case OPC(4 downto 0) is
		  when "01100" =>-- RLA
						AandCin(n-1 downto 0) :=   A; --start values
						AandCin(n) := cin;
						A_unsig := unsigned(AandCin);
						for i in 1 to Bint loop														 
							A_unsig := A_unsig rol 1; --rotate B times	
							A_unsig(0) := '0'; -- put 0 int the first bit 
						end loop;						
						AandCin := std_logic_vector(A_unsig);
						
		  when "01101" => --RLC
		  
						AandCin(n-1 downto 0) :=   A;
						AandCin(n) := cin;
						A_unsig := unsigned(AandCin) rol Bint;
						AandCin := std_logic_vector(A_unsig); -- finished result
	
		  when "01110" => --RRA
						AandCin(n-1 downto 0) :=   A; --start values
						A_unsig := unsigned(AandCin);
						for i in 1 to Bint loop
							A_unsig (n) := A_unsig (n-1); 
							A_unsig := A_unsig ror 1; --rotate B times	
						end loop;						
						AandCin := std_logic_vector(A_unsig); -- finished result
						
		  when "01111" =>  --RRC
						AandCin(n-1 downto 0) :=   A;
						AandCin(n) := cin;
						A_unsig := unsigned(AandCin) ror Bint;
						AandCin := std_logic_vector(A_unsig); -- finished result
		  when others => A_unsig := unsigned(AandCin);
		  end case;

		

		RES (n-1 downto 0) <= AandCin (n-1 downto 0);
		STATUS(0) <= AandCin(n);
		if AandCin (n-1 downto 0) = 0 then
			STATUS(1) <= '1';
		end if;
	END PROCESS;
	
	


END struct;












--configure list -delta collapse





















