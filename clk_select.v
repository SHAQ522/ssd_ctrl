module   clk_select(
						input clk_0,
						input clk_1,
						input clk_2,
						input clk_3,
						
						input [1:0]sel,

						output clk_out
					);


assign clk_out = (sel==2'd0)?clk_0:((sel==2'd1)?clk_1:((sel==2'd2)?clk_2:clk_3));

endmodule

