`timescale 1ns/1ns
module cordic_deg2rad_tb();

	reg clk,rst,radian_en;
	reg [15:0] angle;
	wire [15:0] sin, cos, tan, cot;
	wire done;
	
	cordic UUT (clk, rst, radian_en, angle, sin, cos, tan, cot, done);
	
	initial begin
		radian_en = 1'b0;
		rst = 1'b0;
		clk = 1'b1;
		angle = 16'h000;
	end
	
	always #5 clk = ~clk;

	always begin
		#10
		angle = 16'h001E;	// degree: 30
							// radian:0.1171875 -> degree: 6.71434916171 -> 6 
		#200
		radian_en = 1'b1;
		#200
		$stop;
	end
	
endmodule
