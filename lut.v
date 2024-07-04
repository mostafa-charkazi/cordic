module lut (input [3:0] s, output reg [15:0] out);
	// 13 Itteration
	// Table of angle values for use with z. 
	// Angles obtained as arctan(2^(-i)).
	
	// then mapped to (1 bit sign + 7 bit whole + 8 bit fraction).
	always @(*) begin
		out = 16'b0;
		case (s)
			4'd0:   out = 16'b0010110100000000;	// 45                 degrees
			4'd1:   out = 16'b0001101010010000;	// 26.565051177077990 degrees
			4'd2:   out = 16'b0000111000001001;	// 14.036243467926479 degrees
			4'd3:   out = 16'b0000011100100000;	// 7.125016348901798  degrees
			4'd4:   out = 16'b0000001110010011;	// 3.576334374997351  degrees
			4'd5:   out = 16'b0000000111001010;	// 1.789910608246069  degrees
			4'd6:   out = 16'b0000000011100101;	// 0.895173710211074  degrees
			4'd7:   out = 16'b0000000001110010;	// 0.447614170860553  degrees
			4'd8:   out = 16'b0000000000111001;	// 0.223810500368538  degrees
			4'd9:   out = 16'b0000000000011100;	// 0.111905677066207  degrees
			4'd10:  out = 16'b0000000000001110;	// 0.055952891893804  degrees
			4'd11:  out = 16'b0000000000000111;	// 0.027976452617004  degrees
			4'd12:  out = 16'b0000000000000011;	// 0.013988227142265  degrees
			default out = 16'b0;
		endcase
	end
	
endmodule
