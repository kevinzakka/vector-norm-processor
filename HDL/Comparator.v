/*

Comparator implementation.

Determines the length of the doubly-linked list in memory.
The input comes from the updated PC register (we ignore the first value of 0).

At each clock cycle, we compare the value of PC with 0. If we have not reached
the end of the list, then PC > 0 which means the output of f_a_lt is 0 and thus
the register Length gets incremented by 1. Otherwise, we have reached the end
of the list and this results in no increment.

*/

module Comparator #(parameter word_size = 24)
	(
		output f_a_lt,
		input [word_size-1:0] i_a,
		input enable	
	);
	
	assign f_a_lt = (i_a < 0) ? 1 : 1'bx;
endmodule		
