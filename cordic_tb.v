`timescale 1ns/1ns
module cordic_tb();

	reg clk,rst,radian_en;
	reg [15:0] angle;
	wire [15:0] sin, cos, tan, cot;
	wire done;
	
	cordic UUT (clk, rst, radian_en, angle, sin, cos, tan, cot, done);
	
	initial begin
		radian_en = 1'b0;
		rst = 1'b0;
		clk = 1'b1;
		angle = 16'hFE8E; // -370
	end
	
	always #5 clk = ~clk;

	always begin
		#200
		angle = angle + 16'd1;
	end
	
	initial #154200 $stop;
endmodule
