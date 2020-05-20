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
  PORT (    cin : IN STD_LOGIC:='0';
			A,B : in std_logic_vector(n-1 downto 0):=(others=> '0');
			OPC : in std_logic_vector(m-1 downto 0):=(others=> '0');

		----------------------------------------
			RES : out std_logic_vector(2*n-1 downto 0)); -- Result(HI,LO)


END ALU;
------------- complete the top Architecture code --------------
ARCHITECTURE struct OF ALU IS


	SIGNAL ACC : std_logic_vector(2*n-1 DOWNTO 0):=(others=> '0'); -- for the BarrelShfter
	--SIGNAL Result:std_logic_vector(2*n-1 downto 0);
	--adder:
	Signal sel:std_logic_vector(1 downto 0):="00";
	Signal adderRes:std_logic_vector(n-1 downto 0);
	signal adderCout:std_logic;
	
BEGIN

AddSub:Adder generic map (n) port map (cin,A,B,sel,adderCout,adderRes);
sel(1)<=OPC(1);
sel(0)<=OPC(1) XNOR OPC (0);


PROCESS (OPC,A,B,cin)
variable Along,Blong,Result:std_logic_vector(2*n-1 downto 0);
variable AccVar,tmp:std_logic_vector(2*n DOWNTO 0);

	BEGIN
	
	Along:=(others=> '0');
	Blong:=(others=> '0');
	Along(n-1 downto 0) := A;
	Blong(n-1 downto 0) := B;
	
	Result := ( others => '0');
	


	  	case OPC(4 downto 0) is
		  when "00001" =>   
							Result(n downto 0) := adderCout & adderRes;	
		  when "00010" =>   
							Result(n downto 0) := adderCout & adderRes;
							Result(2*n-1 downto n) := (others => adderCout);
		  when "00011" =>   
							Result(n downto 0) := adderCout & adderRes;
							
		  when "00100" =>   Result := std_logic_vector(unsigned(A)*unsigned(B));
		  
		  -- when "00101" =>   AccVar := ( others => '0');
							-- AccVar(2*n-1 downto 0) := std_logic_vector(unsigned(A)*unsigned(B));							
							
							-- if (AccVar + ACC) < 2**(2*n) - 1  then -- check if Acc makes CARRY and zeroes him
							-- AccVar := AccVar + ACC;
							-- ACC <=AccVar(2*n-1 DOWNTO 0);
							-- Result := AccVar(2*n-1 DOWNTO 0);

							-- else
					
							-- tmp := (AccVar + ACC) -2**(2*n);
							-- Result := tmp(2*n-1 DOWNTO 0);
							-- ACC<= (others=> '0');
							-- end if;						
							
							
		  -- when "00110" =>   ACC <= (others=>'0'); --acc Resultet
		  when "00111" => if A<B then
							Result := Blong; --max
							else Result := Along;
							end if;
							
		  when "01000" => if A<B then
				Result := Along; --min
				else Result := Blong;
				end if;
			when "01001" => --and
						Result(n-1 downto 0) := A and B;				
			when "01010" => -- or
						Result(n-1 downto 0) := A or B;
			when "01011" =>	--xor	
						Result(n-1 downto 0) := A xor B;			
		   when others => Result := (others=> '1'); --not for me 
		end case;
		

		RES <= Result; -- we used an internal signal Result
		
	END PROCESS;
	
	
	PROCESS(OPC,A,B)
	
	variable Result:std_logic_vector(2*n-1 downto 0);
	variable AccVar,tmp:std_logic_vector(2*n DOWNTO 0);
	begin
			if OPC(4 downto 0)= "00101" then
							AccVar := ( others => '0');
							AccVar(2*n-1 downto 0) := std_logic_vector(unsigned(A)*unsigned(B));							
							
							if (AccVar + ACC) < 2**(2*n) - 1  then -- check if Acc makes CARRY and zeroes him
							AccVar := AccVar + ACC;
							ACC <=AccVar(2*n-1 DOWNTO 0);
							Result := AccVar(2*n-1 DOWNTO 0);

							else
					
							tmp := (AccVar + ACC) -2**(2*n);
							Result := tmp(2*n-1 DOWNTO 0);
							ACC<= (others=> '0');
							end if;						
							
							
		  elsif OPC(4 downto 0)= "00110" then
							ACC <= (others=>'0'); --acc Resultet
		  end if;

RES <= Result; -- we used an internal signal Result
	end process;
	
	
	
	
	
	

END struct;

--configure list -delta collapse