module   source_para(
							input clk,
							input [7:0]channel,
							input [7:0]channel_constant,
							
							input [31:0] packet_head,
							input [15:0] flag_set,
							input [23:0] length_set,
							input scramble,	
														
							output reg [31:0] packet_head_out,
							output reg [15:0] flag_set_out,
							output reg [23:0] length_set_out,
							output reg scramble_out	
							);

always @(posedge clk)
begin
	if(channel == channel_constant)
		begin
			packet_head_out <= packet_head;
			flag_set_out    <= flag_set;
			length_set_out  <= length_set;
			scramble_out    <= scramble;
		end
end
		
endmodule
