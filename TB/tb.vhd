LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.ALL;
USE work.aux_package.ALL;
use std.textio.all;
ENTITY tb IS
	generic (
		n : positive := 8 ;
		m : positive := 5 ;
		k : positive := 2;
		ton:time := 50 ns);
END tb; 
	
ARCHITECTURE dtb OF tb IS

			signal rst,ena,clk :std_logic;
			signal cin :std_logic:='0';
			signal A,B : std_logic_vector(n-1 downto 0):=(others=> '0');
			signal OPC : std_logic_vector(m-1 downto 0):=(others=> '0');
		----------------------------------------
			signal RES : std_logic_vector(2*n-1 downto 0):=(others=> '0');
			signal Status: std_logic_vector(k-1 downto 0):=(others=> '0');
			
			signal gen: boolean:=true;
			signal done: boolean:=false;
			constant read_file_location:string(1 to 33) := "C:\Users\amitn\Desktop\infile.txt";
			constant write_file_location:string(1 to 34) := "C:\Users\amitn\Desktop\outfile.txt";
	

begin
	
	tester : top generic map(n, m, k) port map(rst,ena,clk,cin,A,B,OPC,RES,STATUS);
	rst<='0';
	ena<='1';
	gen <= not gen after ton;

	--------- start of stimulus section ------------------	
	tb_clk : PROCESS
	file infile : text open read_mode is read_file_location;
	file outfile : text open write_mode is write_file_location;
	variable L:Line;
	variable in_OPC:bit_vector(m-1 downto 0);
	variable in_A:bit_vector(n-1 downto 0);
	variable in_B:bit_vector(n-1 downto 0);
	variable in_cin:bit;
	variable HI,LO:std_logic_vector(n-1 downto 0);
	variable good:boolean;
	constant write_fileheader:string(1 to 29):= "RES(HI)    RES(LOW)    STATUS";
	
	BEGIN
	write(L,write_fileheader);
	writeline(outfile,L);

		--------------------------------

	while not endfile(infile) loop
		readline (infile,L);
		--------------------------------
		read(L,in_OPC,good);
		next when not good;		
		--------------------------------
		read(L,in_A,good);
		next when not good;		
		--------------------------------
		read(L,in_B,good);
		next when not good;
		--------------------------------
		read(L,in_cin,good);
		next when not good;
		
		--------------------------------
		wait until (gen'event and gen=false);
		clk<='1';
		OPC<=to_stdlogicvector(in_OPC);
		A<=to_stdlogicvector(in_A);
		B<=to_stdlogicvector(in_B);
		cin<=to_stdulogic(in_cin);
		--------------------------------
		
		wait until (gen'event and gen=true);
		clk<='0';
		--HI:=RES(2*n-1 downto n);
		--LO:= RES(n-1 downto 0);
		write(L,to_bitvector(RES(2*n-1 downto n)),left,10);
		write(L,to_bitvector(RES(n-1 downto 0)),left,10);
		write(L,to_bitvector(STATUS));
		writeline(outfile,L);

	
	end loop;
	
	done<= true;
	file_close(infile);
	file_close(outfile);
	report "End of Test" severity note;
	wait;
	END PROCESS tb_clk;

--configure list -delta collapse
END dtb;