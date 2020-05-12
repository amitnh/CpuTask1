LIBRARY ieee;
USE ieee.std_logic_1164.all;
-------------------------------------
ENTITY Adder IS
  GENERIC (n : INTEGER);
  PORT (     cin: IN STD_LOGIC;
			 x,y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			 sel: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
            cout: OUT STD_LOGIC;
               s: OUT STD_LOGIC_VECTOR(n-1 downto 0));
END Adder;
--------------------------------------------------------------
ARCHITECTURE dfl OF Adder IS
	component FA is
		PORT (xi, yi, cin: IN std_logic;
			      s, cout: OUT std_logic);
	end component;
	SIGNAL reg : std_logic_vector(n-1 DOWNTO 0);
	SIGNAL c0 :std_logic;
	SIGNAL lastbit :std_logic;
	SIGNAL yin:std_logic_vector(n-1 DOWNTO 0);
	
BEGIN
	set_y: for i in 0 to n-1 generate
		yin(i) <= y(i) XOR sel(1); -- by karno map in DOC
	end generate;
	
	c0<=sel(1) OR (sel(0) AND cin); -- by karno map in DOC
	
	first : FA port map(
			xi => x(0),
			yi => yin(0), -- for (X-Y)
			cin => c0,
			s => s(0),
			cout => reg(0)
	);
	
	rest : for i in 1 to n-2 generate
		chain : FA port map(
			xi => x(i),
			yi => yin(i),--for (X-Y)
			cin => reg(i-1),
			s => s(i),
			cout => reg(i)
		);
	end generate;
	last: FA port map(
			xi => x(n-1),
			yi => yin(n-1),--for (X-Y)
			cin => reg(n-2),
			s => lastbit,
			cout => reg(n-1)
		);
	s(n-1) <= lastbit;
	cout <= lastbit when sel="10" else reg(n-1);

END dfl;

