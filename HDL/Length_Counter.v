
module Length_Counter (Length_out, Inc_Length, clk, rst_Length);
	parameter word_size = 8;

	output	[word_size-1:0] Length_out;
	input					clk, rst_Length, Inc_Length;

	reg		[word_size-1:0]	length;

	assign Length_out = length;

	always @(posedge clk, posedge rst_Length) begin
		if (rst_Length) length <= 0; 
		else if  (Inc_Length) length <= length +1;
	end
endmodule
