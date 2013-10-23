module mov16t16(
					input [15 : 0] din,
					output  [15 : 0] dout
					);
	assign dout[15 : 8] = din[7 : 0];
	assign dout[7 : 0] = din[15 : 8];
	
					
	endmodule 