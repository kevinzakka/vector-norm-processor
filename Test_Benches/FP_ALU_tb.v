module FP_ALU_tb();
	reg		[23:0]	x, y;
	wire	[38:0]	sum_sq;

	// initialize DUT
	FP_ALU DUT (
		.x(x),
		.y(y),
		.sum_sq(sum_sq)
	);

	// load values
	initial begin
		# 10
		x <= 24'b0_00000000_110100000000000;
		y <= 24'b0_00000000_101000000000000;
	end
	
	integer f;
	initial begin
		f = $fopen("C:\\Users\\Kevin\\Desktop\\test_benches\\alu_res.txt");
		$fmonitor(f, "time = \#%0d, %01b_%08b_%15b, %01b_%08b_%15b, %09b_%30b", 
					$time, x[23], x[22:15], x[14:0], y[23], y[22:15], y[14:0], sum_sq[38:30], sum_sq[29:0]);
	end

	initial begin
		# 500
		$fclose(f);
		$finish;
	end
endmodule
 
