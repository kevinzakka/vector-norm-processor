/* 

Memory unit implementation. 

Contains 512 words each of size 24 bits. For a 
doubly-linked list with 4 words per node, this
memory unit can contain at most 128 nodes.

The maximum value of address A is 508 (512-4).

*/

module Memory (D1, D2, A1, A2);
	parameter memory_size = 512;
	parameter word_size = 24;
	parameter num_bits = $clog2(memory_size);

	output	[word_size-1:0]		D1;
	output	[word_size-1:0]		D2;
	input 	[num_bits-1:0] 		A1;
	input 	[num_bits-1:0] 		A2;

	reg [word_size-1:0] memory[memory_size-1:0];

	// asynchronous read
	assign D1 = memory[A1];
	assign D2 = memory[A2];
endmodule
