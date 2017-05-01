module VNLP_tb();

	// parameter definition
	parameter word_size = 24;
  	parameter len_size = 8;
	parameter memory_size = 512;
	parameter state_size = 2;
	parameter precis = 39;

	reg start, clk, full_precis;
	wire [precis-1:0] norm2_full;
	wire [word_size-1:0] norm2;
	wire [len_size-1:0] len;
	wire done;
	wire [state_size-1:0] the_state;
	wire [7:0] i;

	wire [word_size-1:0] 	word0, word1, word2, word3, word49, word50;
	wire [word_size-1:0]	word51, word52, word39, word40, word41, word42;

	// initialize DUT
	VNLP DUT (
		.i(i),
		.norm2(norm2),
		.norm2_full(norm2_full),
		.len(len),
		.the_state(the_state),
		.done(done),
		.clk(clk),
		.start(start),
		.full_precis(full_precis)
	);
	
	// define probes
	assign word0 = DUT.M2.memory[0];
	assign word1 = DUT.M2.memory[1];
	assign word2 = DUT.M2.memory[2];
	assign word3 = DUT.M2.memory[3];

	assign word39 = DUT.M2.memory[39];
	assign word40 = DUT.M2.memory[40];
	assign word41 = DUT.M2.memory[41];
	assign word42 = DUT.M2.memory[42];

	assign word49 = DUT.M2.memory[49];
	assign word50 = DUT.M2.memory[50];
	assign word51 = DUT.M2.memory[51];
	assign word52 = DUT.M2.memory[52];

	// generate clock
	initial begin clk = 0; forever #10 clk = ~clk; end

	// flush memory
	integer k;
	initial begin 
		#2 
		for (k=0; k < memory_size; k=k+1) 
			DUT.M2.memory[k] = 0;
	end

	// start
	initial begin
		# 7
		start = 1'b0;
		# 1
		start = 1'b1;
		# 7
		start = 1'b0;
	end

	// full precis
	initial begin
		# 10
		full_precis = 1'b0;
		# 150
		full_precis = 1'b1;
	end

	// apply stimulus
	initial begin
		# 5
		DUT.M2.memory[0]  = 24'b0_00000000_000000000110001;
		DUT.M2.memory[1]  = 24'b0_00000000_000000000100010;
		DUT.M2.memory[2]  = 24'b1_00000110_100001001000000;
		DUT.M2.memory[3]  = 24'b0_00000101_101111100000000;

		DUT.M2.memory[39] = 24'b0_00000000_000000000000000;
		DUT.M2.memory[40] = 24'b0_00000000_000000000110010;
		DUT.M2.memory[41] = 24'b0_00000110_111000100110000;
		DUT.M2.memory[42] = 24'b0_00000110_110000101010000;

		DUT.M2.memory[49] = 24'b0_00000000_000000000100111;
		DUT.M2.memory[50] = 24'b0_00000000_000000000000001;
		DUT.M2.memory[51] = 24'b0_00000111_110010111111000;
		DUT.M2.memory[52] = 24'b0_00000110_111111010000000;
	end

	integer f;
	initial begin
		$timeformat(-9, 1, "ns", 12);
		f = $fopen("C:\\Users\\Kevin\\Desktop\\test_benches\\vnlp.txt");
		//$fmonitor(f, "time = %t, done=%d, len=%d, norm2=%01b_%08b_%15b", 
					//$realtime, done, len, norm2[23], norm2[22:15], norm2[14:0]);
		$fmonitor(f, "time = %t, done=%d, len=%d, norm2_full=%09b_%30b, norm2=%01b_%08b_%15b", 
					$realtime, done, len, norm2_full[38:30], norm2_full[29:0], 
					norm2[23], norm2[22:15], norm2[14:0]);
	end

	initial begin
		# 200
		$fclose(f);
		$stop;
	end
endmodule
