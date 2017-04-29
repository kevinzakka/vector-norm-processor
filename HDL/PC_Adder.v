/* 

PC Address Adder implementation. 

Permits +2 or +3 addition to current PC value using 
parametrized operand. Useful for computing the address
of x_i or y_i given the current address.

*/

module PC_Adder #(parameter operand, parameter word_size=9)
	(
		output	[word_size-1:0]	data_out,
		input 	[word_size-1:0]	data_in
	);
	
	assign data_out = data_in + operand;	
endmodule
