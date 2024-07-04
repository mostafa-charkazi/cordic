module add_sub (
	input s,
	input signed [15:0] a,b,
	output signed [15:0] out
);

	assign out = (s) ? a-b : a + b;

endmodule