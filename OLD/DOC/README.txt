

FA-
regular Full Adder. 
IN- X, Y, Cin(1 bit). 
OUT- S, Cout(1 bit). 

MUX-
regular MUX. 
IN- X1, X2, Y(1 bit). 
OUT- Z(1 bit).

Adder-
Chaining FAs, select by 2 SEL bits from 3 options:
	00- X+Y=S
	01- X+Y+Cin=S
	10- X-Y=S
generic n
IN- X(n bits), Y(n bits), Cin (1 bit).
OUT- S(n+1 bits), Cout (1 bit).

MuxChain-
Chaining MUXs.
generic n.
IN- xi(2*n-1 bits), y(1 bit).
OUT- zi(n bits).

BarrelShifter-
Chaining m(GENERIC) muxchains making a barrelshifter with n bits as input and can shift y[0,m-1] times.
IN- X(n bits), Y(n bits(uses only m bits)).
OUT- S(n bits).

outputSelector-
select between 2  vectors. 
generic n.
IN-	adderResult,bsResultbsResult(n+1 bits).
	sel (2 bits).
OUT- res(n downto 0)).

aux_package-
package include 4 components - top, barrelshifter, adder, output selector.

top-
top entity fixing sizes from input to the components, taking result from outpus selector.
top-
IN- X(n bits), Y(n bits), Cin (1 bit), sel (2 bits).
OUT- result(n+1 bits).

