module para_set_test(
	input clk,

	input [7:0] channel,
	input [7:0] channel_const,
	
	input reset_in,
	input begin_send_in,


	output reg reset,
	output reg begin_send
	);
	
always @(posedge clk)
begin
	if(channel == channel_const)
	begin
		reset <= reset_in;
		begin_send <= begin_send_in;
	end	
end

endmodule
