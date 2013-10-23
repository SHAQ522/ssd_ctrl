module data_16to16(
	input [15:0] data_in,
	output[15:0] data_out
	);

assign data_out = {data_in[7:0],data_in[15:8]};
	
endmodule
