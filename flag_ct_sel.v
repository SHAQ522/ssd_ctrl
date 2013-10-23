module flag_ct_sel(
	input sel,	
	
	input en_a,	
	input [15:0]data_a,
	
	input en_b,	
	input [15:0]data_b,
	
	output data_en,
	output [15:0]data_out
	);

assign data_en = (sel==1'b0)?en_a:en_b;
assign data_out = (sel==1'b0)?data_a:data_b;


endmodule
