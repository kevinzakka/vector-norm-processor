/* 

Top Module. 

Refer to the attached PDF for more details.

*/

module VNLP (i, norm2, norm2_full, len, the_state, done, clk, start, full_precis);

	// parameter definition
  	parameter word_size = 24;
  	parameter len_size = 8;
	parameter addr_bits = 9;
	parameter precis = 39;
	parameter state_size = 2;

	output [state_size-1:0] the_state;
	output [word_size-1:0] norm2;
	output [precis-1:0] norm2_full;
	output [len_size-1:0] len;
	output [7:0] i;
	output done;
	input clk, start;
	input full_precis;

	// data nets
	wire [word_size-1:0]	D1, D2;
	wire [addr_bits-1:0]	PC_in, PC_out, A1, A2, next;
	wire [addr_bits-1:0]	o_PC_plus2, o_PC_plus3, i_PC_plus2, i_PC_plus3;

	// control nets
	wire rst_PC, rst_Length, rst_ALU;
	wire ld_PC, ld_Result_Acc, inc_Length;
	wire Sel_Mux_1;

	// submodules
	Datapath M0			(next, norm2, norm2_full, len, A1, A2, clk, D1, D2, PC_out, 
						 rst_PC, rst_Length, rst_ALU, ld_Result_Acc, ld_PC, 
						 inc_Length, Sel_Mux_1, PC_in, done, o_PC_plus2, o_PC_plus3, 
						 i_PC_plus2, i_PC_plus3, full_precis);
	Controller M1		(i, the_state, done, rst_PC, rst_Length, rst_ALU, ld_Result_Acc,
						 ld_PC, inc_Length, Sel_Mux_1, clk, start, next);
	Memory M2			(D1, D2, A1, A2);
endmodule
