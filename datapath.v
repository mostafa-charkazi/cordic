module datapath(
	input clk, rst, cnt_en,
	input signed [15:0] angle,
	input [1:0] sector,
	output reg signed [15:0] sin,
	output reg signed [15:0] cos,
	output reg signed [15:0] tan,
	output reg signed [15:0] cot,
	output done
);
	parameter [15:0] scaling_value_pos = 16'h26DD, scaling_value_neg = 16'hD923; // 0.607252941041397
	reg signed  [15:0] present_x , present_y , present_z;
	wire signed [15:0] next_x    , next_y    , next_z;
	wire signed [15:0] shifted_x , shifted_y;
	
	//d decides whether to go clockwise or anti-clockwise.
	wire d = ~ present_z[15]; // 0: Add   1: Subtract
	
	wire signed [15:0] theta;
	wire [3:0] cnt;
	
	lut atan (cnt, theta);
	counter lutcnt (clk, rst, cnt_en, cnt);
	
	shifter shiftx (present_x, cnt, shifted_x);
	shifter shifty (present_y, cnt, shifted_y);
	
	add_sub add_sub_x ( d, present_x, shifted_y, next_x);
	add_sub add_sub_y (~d, present_y, shifted_x, next_y);
	add_sub add_sub_z ( d, present_z, theta    , next_z);
	
	always @(posedge clk, posedge rst) begin
		if (rst) begin
			case (sector)
				2'b00: begin
					present_x <= scaling_value_pos; // 0.607252941041397
					present_y <= 16'd0;
					present_z <= angle;
				end
				2'b01: begin
					// Reduce by 90deg for Q2. 
					present_x <= 16'd0; 
					present_y <= scaling_value_pos; // 0.607252941041397
					present_z <= angle;
				end
				2'b10: begin
					// Increase by 90deg for Q3.
					present_x <= 16'd0; 
					present_y <= scaling_value_neg; // -0.607252941041397
					present_z <= angle;
				end
				2'b11: begin
					present_x <= scaling_value_pos; // 0.607252941041397
					present_y <= 16'd0;
					present_z <= angle;
				end
				default: begin
					present_x <= scaling_value_pos; // 0.607252941041397
					present_y <= 16'd0;
					present_z <= angle;
				end
			endcase
		end
		else begin
			present_x <= next_x;
			present_y <= next_y;
			present_z <= next_z;
		end
	end

	always @(posedge done) begin
		if (done == 1) begin
			sin <= present_y;
			cos <= present_x;
			tan <= present_y/present_x;
			cot <= present_x/present_y;
		end
	end
	
	assign done = (cnt == 4'd12) ? 1 : 0;
	
endmodule
