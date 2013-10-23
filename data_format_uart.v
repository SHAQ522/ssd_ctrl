module  data_format_uart(
						input [7:0]din,
						output [10:0]dout
						);

wire d_check;

assign d_check = din[0]+din[1]+din[2]+din[3]+din[4]+din[5]+din[6]+din[7];

assign  dout= {1'b1,d_check,din,1'b0};

endmodule
