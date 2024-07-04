module anglefixer(input signed [15:0] angle, output reg [1:0] sector, output [15:0] out);

	
	
	wire is_neg = angle[15];
	wire [15:0] pos_angle = (~is_neg) ? angle : (~angle+1);
	wire [15:0] angle_360 = (pos_angle % 16'h0168); // mod 360
	
	reg signed [15:0] angle16;
	always @(*) begin
		
		if (angle_360 >= 16'h0000 && angle_360 <= 16'h005A && ~is_neg) begin //pos Q1
			angle16 = angle_360; // angle
			sector = 2'b00;
		end
		else if (angle_360 > 16'h005A && angle_360 <= 16'h00B4 && ~is_neg) begin //pos Q2
			angle16 = angle_360 - 16'h005A; // angle - 90
			sector = 2'b01;
		end
		else if (angle_360 > 16'h00B4 && angle_360 <= 16'h010E && ~is_neg) begin //pos Q3
			angle16 = angle_360 - 16'h010E; // angle - 270
			sector = 2'b10;
		end
		else if (angle_360 > 16'h010E && angle_360 <= 16'h0168 && ~is_neg) begin //pos Q4
			angle16 = angle_360 - 16'h0168;   // angle - 360
			sector = 2'b11;
		end
		
		
		else if (angle_360 > 16'h0000 && angle_360 <= 16'h005A && is_neg) begin //neg Q4
			angle16 = ~angle_360 + 1; // -angle
			sector = 2'b11;
		end
		else if (angle_360 > 16'h005A && angle_360 <= 16'h00B4 && is_neg) begin //neg Q3
			angle16 = 16'h005A - angle_360; // 90 - angle
			sector = 2'b10;
		end
		else if (angle_360 > 16'h00B4 && angle_360 <= 16'h010E && is_neg) begin //neg Q2
			angle16 = 16'h010E - angle_360; // 270 - angle
			sector = 2'b01;
		end
		else if (angle_360 > 16'h010E && angle_360 <= 16'h0168 && is_neg) begin //neg Q1
			angle16 = 16'h0168 - angle_360;   // angle - 360
			sector = 2'b00;
		end
		else begin // default
			angle16 = angle_360; // angle
			sector = 2'b00;
		end
	end

	assign out = {angle16 [7:0],8'd0};
	
endmodule
