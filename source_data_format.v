module source_data_format(
	input [15:0] data_in,
	output wire [15:0] data_out_16,
	output wire [15:0] data_out_8,
	output wire [15:0] data_out_4,
	output wire [15:0] data_out_2,
	output wire [15:0] data_out_1
	);
	
assign	data_out_16 = data_in;
assign	data_out_8 = data_in;
assign	data_out_4 = {data_in[11:8],data_in[15:12],data_in[3:0],data_in[7:4]};
assign	data_out_2 = {data_in[9:8],data_in[11:10],data_in[13:12],data_in[15:14],data_in[1:0],data_in[3:2],data_in[5:4],data_in[7:6]};
assign	data_out_1 = {data_in[8],data_in[9],data_in[10],data_in[11],data_in[12],data_in[13],data_in[14],data_in[15],
					  data_in[0],data_in[1],data_in[2],data_in[3],data_in[4],data_in[5],data_in[6],data_in[7]};
					  	
/*
assign	data_out_16 = data_in;
assign	data_out_8 = {data_in[7:0],data_in[15:8]};
assign	data_out_4 = {data_in[3:0],data_in[7:4],data_in[11:8],data_in[15:12]};
assign	data_out_2 = {data_in[1:0],data_in[3:2],data_in[5:4],data_in[7:6],data_in[9:8],data_in[11:10],data_in[13:12],data_in[15:14]};
assign	data_out_1 = {data_in[0],data_in[1],data_in[2],data_in[3],data_in[4],data_in[5],data_in[6],data_in[7],
					  data_in[8],data_in[9],data_in[10],data_in[11],data_in[12],data_in[13],data_in[14],data_in[15]};
*/
endmodule
