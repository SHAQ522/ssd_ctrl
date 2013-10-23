module   data_convert_32to8(
							input  [127:0]din,
							output [127:0]dout
							);


assign dout = {din[119:112],din[127:120],din[103:96],din[111:104],din[87:80],din[95:88],din[71:64],din[79:72],
			   din[55:48],din[63:56],din[39:32],din[47:40],din[23:16],din[31:24],din[7:0],din[15:8]};

endmodule

