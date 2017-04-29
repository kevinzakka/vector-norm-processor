module Mux_2ch #(parameter word_size = 24)
	(
		output	[word_size-1:0]	o_data,
		input	[word_size-1:0]	i_data0, i_data1,
		input					select
	);
	// determine output according to select
	assign o_data = (select == 0) ? i_data0: (select == 1) ? i_data1 : 24'bx;
endmodule
