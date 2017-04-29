// D flip-flop implementation

module D_flop #(parameter word_size)
	(
		output	reg [word_size-1:0]	data_out,
		input 	[word_size-1:0]		data_in,
		input 						clk, rst, en
	);
	
	always @ (posedge clk, posedge rst) begin
		if (rst) data_out <= 0;
		else if (en) data_out <= data_in; 
	end
endmodule
