module shifter (
	input signed [15:0] number, 
	input [3:0] cnt,
	output signed [15:0] out
);

	assign out = number >>> cnt;

endmodule