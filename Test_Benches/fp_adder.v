/* 

Floating point adder implementation.

This is the first adder in the ALU. It follows
the multiplier and comes right before the accumulator.

Input
-----
- a: 39 bit word
	- 9 bit exponent field
	- 30 bit significand field

When we add 2 fp nums, the exponent field is the maximum
of the two, and we add the mantissas so in this case, the
output has a 31 bit mantissa field.

Output
------
- sum: 39 bit word
	- 9 bit exponent field
	- 30 bit significand field
*/

module fp_adder(sum, a_original, b_original);
	input 	[38:0] 	a_original, b_original; 
	output 	[38:0] 	sum;
	
	reg 	[8:0]	sumexp;
	reg 	[30:0]	sumsig;

	reg 	[38:0]	a, b;
	reg 	[30:0]  asig, bsig;
	reg 	[8:0]  	aexp, bexp;
	reg 	[8:0]  	diff;
	
	// to assign the output
	assign sum[38:30] = sumexp;
	assign sum[29:0] = sumsig;

	// to compute the sum
	always @(a_original or b_original) begin
		// copy inputs to a and b so that a's exponent not smaller than b's
		if (a_original[38:30] < b_original[38:30]) begin
			a = b_original;  b = a_original;
		end 
		else begin
			a = a_original;  b = b_original;
		end

		// break operand into exponent and significand
		aexp = a[38:30];			bexp = b[38:30];
		asig = {1'b0, a[29:0]};		bsig = {1'b0, b[29:0]};		

		// denormalize b so that exp aexp = bexp
		diff = aexp - bexp;
		bsig = bsig >> diff;

		// compute sum
		sumsig = asig + bsig;

		// normalize the sum
		if (diff >= 8) begin
			// case 0: diff very big. b has no effect on a.

			sumexp = aexp;
			sumsig = asig;
		end
		if (sumsig[30]) begin
			// case 1: sum overflow
			// right shift significand, increment exponent

			sumexp = aexp + 1;
			sumsig = sumsig >> 1;		
		end 
		else if (sumsig) begin:A
			// case 2: sum is nonzero and did not overflow
			// In this case, we normalize

			integer pos, adj, i;
			
			// find position of first nonzero digit
			pos = 0;
			for (i = 29; i >= 0; i=i-1) if ( !pos && sumsig[i] ) pos = i;
			
			// compute shift amount and reduce exponent
			adj = 29 - pos;
			if (aexp < adj) begin
				// exponent too small, fp underflow, set to zero
				sumexp = 0;
				sumsig = 0;
			end
			else begin
				// adjust significand and exponent
				sumexp = aexp - adj;
				sumsig = sumsig << adj;
			end
		end
		else begin
			// sum is zero

			sumexp = 0;
			sumsig = 0;
		end
	end
endmodule
