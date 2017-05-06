module fp_adder_tb();
	reg		[38:0]	a, b;
	wire	[38:0]	sum;

	// initialize DUT
	fp_adder DUT (
		.a_original(a),
		.b_original(b),
		.sum(sum)
	);

	// load values
	initial begin
		# 10
		a <= 39'b000000000_110100000000000000000000000000;
		b <= 39'b000000000_111000000000000000000000000000;
		# 20
		a <= 39'b000000101_110100000000000000000000000000;
		b <= 39'b000001111_111000000000000000000000000000;
	end
	
	integer f;
	initial begin
		f = $fopen("result.txt");
		//$fmonitor(f, "time = \#%d: %b + %b = %b", $time, a, b, sum);
		$fmonitor(f, "time = \#%d: %09b_%30b + %09b_%30b = %09b_%30b", 
					$time, a[38:30], a[29:0], b[38:30], b[29:0], sum[38:30], sum[29:0]);
	end

	initial begin
		# 500
		$fclose(f);
		$finish;
	end
endmodule
 
