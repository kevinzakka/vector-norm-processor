/* 

ALU implementation. 

Contains the following:

- fp_adder 	(x1)
- fp_square (x2)

The output of the ALU gets taken as input
to an accumulator which is a secondf fp_adder
whose 2nd input is the output of a D ff.

*/

module FP_ALU (sum_sq, x, y);
	output 	[38:0] 	sum_sq;
	input 	[23:0] 	x, y;

	wire	[38:0] sq1, sq2;
	
	fp_square M0 (sq1, x, x);
	fp_square M1 (sq2, y, y);
	fp_adder  M2 (sum_sq, sq1, sq2);	
endmodule
