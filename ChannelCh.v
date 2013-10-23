module ChannelCh(
					input [7 : 0] channel_contant,
					input [7 : 0] channel_in,
					
					output channel_cs					
					
					);
					
	assign channel_cs = channel_in== (channel_contant) ? 1'b0 : 1'b1;
	
endmodule 