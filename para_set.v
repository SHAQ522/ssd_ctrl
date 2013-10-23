module para_set(
	input clk,

	input [7:0] channel,
	input [7:0] channel_const,
	
	input reset_in,
	input begin_send_in,
	input begin_set_in,	
	input [31:0] data_length_in,
	input [31:0] blank_length_in,
	input [7:0] mode_in,
	input out_en_in,
	input [7:0] data_mode_in,
	input [7:0] flag_mode_in,
	input syn_en_in,
	input syn_key_in,

	output reg reset,
	output reg begin_send,
	output reg begin_set,
	output reg [31:0] data_length,
	output reg [31:0] blank_length,
	output reg out_en,
	output reg [7:0] mode,	
	output reg [7:0] data_mode,	
	output reg [7:0] flag_mode,
	output reg syn_en,
	output reg syn_key,
	
	input [31:0] packet_head_in,
	input [15:0] flag_set_in,
	input [23:0] length_set_in,
	input scramble_in,	
								
	output reg [31:0] packet_head,
	output reg [15:0] flag_set,
	output reg [23:0] length_set,
	output reg scramble	
	);
	
always @(posedge clk)
begin
	if(channel == channel_const)
	begin
		reset <= reset_in;
		begin_send <= begin_send_in;
		begin_set <= begin_set_in;		
		data_length <= data_length_in;
		blank_length <= blank_length_in;
		out_en <= out_en_in;
		mode <= mode_in;
		data_mode <= data_mode_in;
		flag_mode <= flag_mode_in;
		syn_en <= syn_en_in;
		packet_head <= packet_head_in;
		flag_set    <= flag_set_in;
		length_set  <= length_set_in;
		scramble    <= scramble_in;
	end	
end

always @(posedge clk)
begin
	syn_key <= syn_key_in;
end

endmodule
