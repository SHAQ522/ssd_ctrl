module ChannelChooseCon(
						input clk,
						input reset_n,
						
						input [3 : 0] constant_channel,
						input [3 : 0] choose_channel, 
						
						input update_flag,
						
						output reg ch_update_flag
						
						);
	reg [3 : 0] constant_reg;
	reg [3 : 0] choose_reg;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			constant_reg <= 4'd0;
			constant_reg <= 4'd0;
		end
		else
		begin
			constant_reg <= constant_channel;
			choose_reg <= choose_channel;
		end 
	end 
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			ch_update_flag <= 1'b0;
		end
		else if (constant_reg == choose_reg)
		begin
			ch_update_flag <= update_flag;
		end 
	end 
	
endmodule 