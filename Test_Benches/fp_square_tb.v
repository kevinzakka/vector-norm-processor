module fp_square_tb();
	reg		[23:0]	a, b;
	wire	[38:0]	prod;

	// initialize DUT
	fp_square DUT (
		.a(a),
		.b(b),
		.prod(prod)
	);

	// load values
	initial begin
		# 10
		a <= 24'b0_00000000_101000000000000;
		b <= 24'b0_00000000_010000000000000;
	end
	
	integer f;
	initial begin
		f = $fopen("result_mult.txt");
		$fmonitor(f, "time = \#%d: %01b_%08b_%15b \* %01b_%08b_%15b = %09b_%30b", 
					$time, a[23], a[22:15], a[14:0], b[23], b[22:15], b[14:0], prod[38:30], prod[29:0]);
	end

	initial begin
		# 500
		$fclose(f);
		$finish;
	end
endmodule
 