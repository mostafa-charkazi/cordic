module rad2deg(input [15:0] rad, output [15:0] deg);
	parameter [15:0] fifty_seven = 16'b0011100101001011;
	wire [15:0] pos_rad = (~rad[15]) ? rad : (~rad + 1);
	wire [31:0] degree = pos_rad * fifty_seven;
	wire [15:0] pos_deg = degree >> 5'd16;
	assign deg = (~rad[15]) ? pos_deg : (~pos_deg + 1) ;
endmodule