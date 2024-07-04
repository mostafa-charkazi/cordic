module controller (
	input clk, rst, done,
	input [15:0] angle,
	output reg output_rst,
	output output_en
);
	parameter [1:0] Idle = 2'b00, Wait = 2'b01, Work = 2'b10;
	
	reg [15:0] p_angle;
	always @(posedge clk) begin
		p_angle <= angle;
	end
	wire is_angle_changed = |{angle ^ p_angle};
	
	reg [1:0] ps, ns;
	
	always @(done, angle, ps) begin
		case (ps)
			Idle : ns = (is_angle_changed) ? Wait : Idle;
			Wait : ns = Work;
			Work : ns = (done) ? Idle : Work;
			default : ns = Idle;
		endcase
	end
	
	always @(done, angle, ps) begin
		case (ps)
			Idle : output_rst = 1'b1;
			Wait : output_rst = 1'b1;
			Work : output_rst = 1'b0;
			default : ns = Idle;
		endcase
	end
	
	always @(posedge clk, posedge rst) begin
		if (rst)
			ps <= 0;
		else
			ps <= ns;
	end
	assign output_en = 1'b1;
	
endmodule