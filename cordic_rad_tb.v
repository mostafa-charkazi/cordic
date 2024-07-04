`timescale 1ns/1ns
module cordic_rad_tb();

	reg clk,rst,radian_en;
	reg [15:0] angle;
	wire [15:0] sin, cos, tan, cot;
	wire done;
	
	cordic UUT (clk, rst, radian_en, angle, sin, cos, tan, cot, done);
	
	initial begin
		radian_en = 1'b1;
		rst = 1'b0;
		clk = 1'b1;
		angle = 16'hF800; // -8
	end
	
	always #5 clk = ~clk;

	always begin
		#200
		angle = angle + 16'h0033; // angle + 0.19921875 (approximately 1 deg)
	end
	
	initial #20000 $stop;
endmodule
