/* 

Basic Adder unit implementation. 

For use with the accumulators Result_Acc and Length.
Takes 2 inputs and outputs the sum.

*/

module Adder #(parameter word_size)
	(
		output	[word_size-1:0]	data_out,
		input 	[word_size-1:0]	data_in1, data_in2
	);
	
	assign data_out = data_in1 + data_in2;	
endmodule
