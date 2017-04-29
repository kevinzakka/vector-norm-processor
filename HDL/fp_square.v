/* 

Floating point multiplier implementation.

This is the multiplier in the ALU. There are
2 instances of this module, each taking an
24 bit word fp input and outputting
its square.

We ignore the sign bit since the square of a number
is always positive.

Input
-----
- a: 24 bit word
	- 8 bit exponent field
	- 15 bit significand field
	- 1 bit sign field

When we add multiply fp nums, the exponent fields are added
and the mantissa fields are multiplied.

Output
------
- prod: 39 bit word
	- 9 bit exponent field
	- 30 bit significand field
*/

module fp_square(prod, a, b);
	input 	[23:0] 	a, b; 
	output 	[38:0] 	prod;
	
	reg 	[8:0]	sumexp;
	reg 	[29:0]	prodsig;

	reg 	[14:0]  asig, bsig;
	reg 	[7:0]  	aexp, bexp;
	
	// to assign the output
	assign prod[38:30] = sumexp;
	assign prod[29:0] = prodsig;

	// to compute product
	always @(a or b) begin
		// break operand into exponent and signficand
		// get rid of sign bit
		aexp = a[22:15];	bexp = b[22:15];
		asig = a[14:0];		bsig = b[14:0];

		// compute product
		prodsig = asig * bsig;
		sumexp = aexp + bexp;
	end
endmodule
