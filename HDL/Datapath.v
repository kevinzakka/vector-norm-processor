/* 

Datapath implementation. 

Refer to the attached PDF for more details.

*/

module Datapath
	(
		next, norm2, len, A1, A2, clk, D1, D2, PC_out, 
		rst_PC, rst_Length, rst_ALU, ld_Result_Acc, ld_PC, 
		inc_Length, Sel_Mux_1, PC_in, done, o_PC_plus2, o_PC_plus3, 
		i_PC_plus2, i_PC_plus3
	);

	// parameter definition
  	parameter word_size = 24;
  	parameter len_size = 8;
	parameter addr_bits = 9;
	parameter precis = 39;

	// input & output definition
	output	[precis-1:0] norm2;
	output	[len_size-1:0]	len;
	output	[addr_bits-1:0] next, A1, A2;

	input clk, done, rst_PC, rst_Length, rst_ALU;
	input ld_Result_Acc, ld_PC, inc_Length, Sel_Mux_1;
	input [addr_bits-1:0] PC_in, PC_out;
	input [addr_bits-1:0] o_PC_plus2, o_PC_plus3, i_PC_plus2, i_PC_plus3;
	input [word_size-1:0] D1, D2;
	
	// wires
	wire [38:0] temp_norm;
	wire [len_size-1:0]	o_len;

	// assign outputs
	//assign norm2 = (done) ? {1'b0, temp_norm[37:30], temp_norm[29:15]} : 24'bx;
	assign norm2 = (done) ? temp_norm : 39'bx;
	assign len = (done) ? o_len : 8'bx; 
	
	// assign inputs
	assign PC_in = D1[addr_bits-1:0];
	assign next = PC_in;
	assign i_PC_plus2 = PC_out;
	assign i_PC_plus3 = PC_out;
	assign A2 = o_PC_plus3;
	
	// submodules
	D_flop #(.word_size(addr_bits)) PC (PC_out, PC_in, clk, rst_PC, ld_PC);
  	Length_Counter Length (o_len, inc_Length, clk, rst_Length);
	Mux_2ch #(.word_size(addr_bits)) Mux_1 (A1, o_PC_plus2, PC_out, Sel_Mux_1);
	PC_Adder #(.operand(2))	add_plus2 (o_PC_plus2, i_PC_plus2);
	PC_Adder #(.operand(3))	add_plus3 (o_PC_plus3, i_PC_plus3);
	norm_adder FP_unit (temp_norm, D1, D2, clk, rst_ALU, ld_Result_Acc);							
endmodule
