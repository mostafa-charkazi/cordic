module counter (input clk, rst, en, output [3:0] out);

	reg [3:0] ps, ns;
	
	always @(*) begin
		ns = 4'd0;
		case(ps)
			4'd0: ns = en ? 4'd1 : ps;
			4'd1: ns = en ? 4'd2 : ps;
			4'd2: ns = en ? 4'd3 : ps;
			4'd3: ns = en ? 4'd4 : ps;
			4'd4: ns = en ? 4'd5 : ps;
			4'd5: ns = en ? 4'd6 : ps;
			4'd6: ns = en ? 4'd7 : ps;
			4'd7: ns = en ? 4'd8 : ps;
			4'd8: ns = en ? 4'd9 : ps;
			4'd9: ns = en ? 4'd10 : ps;
			4'd10: ns = en ? 4'd11 : ps;
			4'd11: ns = en ? 4'd12 : ps;
			default: ns = en ? 4'd0 : ps;
		endcase
	end
	
	always @(posedge clk, posedge rst) begin
		if (rst)
			ps <= 4'b0;
		else
			ps <= ns;
	end
	
	assign out = ps;
	
endmodule