module   syn_selcet(
						input syn_en,
						input syn_key,
						output syn_out
					);

assign 	syn_out = (!syn_en)?1'b1:syn_key;

endmodule

