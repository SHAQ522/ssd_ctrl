module rambus_sel(
	input sel,

	input [15:0] data_a,
	input [10:0] addr_a,
	input wren_a,
	
	input [15:0] data_b,
	input [10:0] addr_b,
	input wren_b,
	
	output [15:0] data_out,
	output [10:0] addr_out,
	output wren_out
	);

assign data_out = (sel)?data_a:data_b;
assign addr_out = (sel)?addr_a:addr_b;
assign wren_out = (sel)?wren_a:wren_b;


endmodule
