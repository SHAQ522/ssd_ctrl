module clk_sel(
	input sel,	
	
	input clk_a,		
	input clk_b,	
	
	output clk_out
	);

assign clk_out = (sel==1'b0)?clk_a:clk_b;


endmodule
