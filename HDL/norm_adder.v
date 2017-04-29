/* 

ALU + Accumulator

Refer to the attached PDF for more details.

*/

module norm_adder (norm, x, y, clk, rst, en);
	output 	[38:0] 	norm;
	input 	[23:0] 	x, y;
	input			clk, rst, en;

	wire	[38:0]	o_adder, sum_sq;	
	
	// submodules
	FP_ALU					M0	(sum_sq, x, y);
	fp_adder				M1 	(o_adder, sum_sq, norm);	
	D_flop #(.word_size(39))M2 	(norm, o_adder, clk, rst, en);
endmodule
