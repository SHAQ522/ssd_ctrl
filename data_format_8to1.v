module  data_format_8to1(
						input [7:0]din,
						output [7:0]dout
						);

assign  dout= {din[0],din[1],din[2],din[3],din[4],din[5],din[6],din[7]};

endmodule
