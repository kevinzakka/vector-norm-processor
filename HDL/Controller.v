module Controller
	(
		i, the_state, done, rst_PC, rst_Length, rst_ALU, ld_Result_Acc,
		ld_PC, inc_Length, Sel_Mux_1, clk, start, next
	);
	
	// parameters
	parameter state_size = 2;
	parameter word_size = 24;
	parameter addr_bits = 9;
	
	// input & output
	output done, Sel_Mux_1;
	output [state_size-1:0] the_state;
	output [7:0] i;
	output rst_PC, rst_Length, rst_ALU;
	output ld_PC, ld_Result_Acc, inc_Length;
	input clk, start;
	input [addr_bits-1:0] next;

	// state encoding
	parameter s_idle = 0, s_calc = 1, s_fetch = 2, s_done = 3;
	reg	[state_size-1:0] present_state, next_state, the_state;
	reg done, Sel_Mux_1;
	reg rst_PC, rst_Length, rst_ALU;
	reg ld_PC, ld_Result_Acc, inc_Length;
	reg [7:0] i;
	reg incr_i, is_done;

	// to compute output
	always @ (present_state) begin
		if (is_done) done <= 1;
		else done <= 0;
		the_state <= present_state;
	end

	// to update state
	always @ (posedge clk, posedge start) begin
		if (start) present_state <= s_idle;
		else present_state <= next_state;		
	end

	// to compute next_state
	always @ (present_state, next) begin
		case (present_state)
			s_idle: begin
				done = 0;
				i = 0;
				rst_PC = 1; rst_Length = 1; rst_ALU = 1;
				ld_Result_Acc = 0; ld_PC = 0; inc_Length = 0;
				next_state = s_calc;
			end
			s_calc: begin
				rst_PC = 0; rst_Length = 0; rst_ALU = 0;
				Sel_Mux_1 = 0;
				incr_i = 1;
				inc_Length = 1;	
				ld_Result_Acc = 1;
				ld_PC = 0;
				next_state = s_fetch;
			end
			s_fetch: begin
				ld_PC = 1;
				next_state = s_calc;
				Sel_Mux_1 = 1;
				ld_Result_Acc = 0;
				inc_Length = 0;	
				incr_i = 0;
				if ((next == 0) && (i > 0)) begin
					next_state = s_done;
					is_done = 1;
					ld_PC = 0;
				end 
			end
			s_done: begin
				next_state = s_done;
			end
			default: next_state = s_idle;
		endcase  
	end

	always @ (posedge clk) begin
		if (incr_i) i <= i+1;
	end
endmodule
