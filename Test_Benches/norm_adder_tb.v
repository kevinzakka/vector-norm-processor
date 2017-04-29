module norm_adder_tb();
	reg		[23:0]	x, y;
	reg				rst, clk, en;
	wire	[38:0]	norm;

	// initialize DUT
	norm_adder DUT (
		.x(x),
		.y(y),
		.norm(norm),
		.rst(rst),
		.clk(clk),
		.en(en)
	);

	// generate clock
	initial begin clk = 0; forever #20 clk = ~clk; end

	// sets reset & enable
	initial begin
		rst = 1'b1;
		en	= 1'b0;
		# 5
		rst = 1'b0;
		en = 1'b1;
		# 380
		en = 1'b0;
	end

	// applies stimulus
	initial begin
		# 5
		x <= 24'b1_00000110_100001001000000;
		y <= 24'b0_00000101_101111100000000; // 1
		# 40
		x <= 24'b0_00000101_100110000100000;
		y <= 24'b0_00000111_110011000000000; // 2
		# 40
		x <= 24'b0_00000101_110011000000000;
		y <= 24'b1_00000111_101110100100000; // 3
		# 40
		x <= 24'b0_00000100_100000100000000;
		y <= 24'b0_00000111_101101000011000; // 4
		# 40
		x <= 24'b0_00000101_111110100100000;
		y <= 24'b0_00000110_100000010110000; // 5
		# 40
		x <= 24'b0_00000110_101111000100000;
		y <= 24'b1_00000100_101101111000000; // 6
		# 40
		x <= 24'b0_00000101_110011100000000;
		y <= 24'b0_00000111_101100000100000; // 7
		# 40
		x <= 24'b0_00000110_111000100110000;
		y <= 24'b0_00000110_110000101010000; // 8
		# 40
		x <= 24'b0_00000111_111000010111000;
		y <= 24'b0_00000111_100010111001000; // 9
		# 40
		x <= 24'b0_00000111_110010111111000;
		y <= 24'b0_00000110_111111010000000; // 10
	end
	
	integer f;
	initial begin
		$timeformat(-9, 1, "ns", 12);
		f = $fopen("C:\\Users\\Kevin\\Desktop\\test_benches\\norm_adder.txt");
		$fmonitor(f, "time = %t, %01b_%08b_%15b, %01b_%08b_%15b, %09b_%30b", 
					$realtime, x[23], x[22:15], x[14:0], y[23], y[22:15], y[14:0], norm[38:30], norm[29:0]);
	end

	initial begin
		# 390
		$fclose(f);
		$stop;
	end
endmodule
 