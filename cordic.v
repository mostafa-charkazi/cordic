module cordic(
	input clk, rst, radian_en,
	input [15:0] angle, 
	output [15:0] sin, cos, tan, cot,
	output done
);
	// 16 bit signed => degree
	// (1 bit + 7 bit + 8 bit) => radian
	
	wire counter_en, cordic_reset, cordic_state;
	assign done = cordic_state;
	
	wire [15:0] radian_angle, my_angle;
	rad2deg inst (angle, radian_angle);
	assign my_angle = (radian_en) ? radian_angle : angle;
	
	wire [1:0] sector;
	wire [15:0] n_angle;
	
	anglefixer angle_fix (my_angle, sector, n_angle);
	
	controller controll_inst (
		clk, rst, cordic_state,	n_angle,
		cordic_reset, counter_en
	);

	datapath datapath_inst (
		clk, cordic_reset, counter_en,
		n_angle,sector,
		sin, cos, tan, cot,
		cordic_state // done
	);

endmodule
