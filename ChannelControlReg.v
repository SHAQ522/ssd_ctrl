module ChannelControlReg(
						input clk,
						input reset_n,
						
						input cs,
						
						input [15 : 0] frame_length,
						input [15 : 0] blank_length,
						input start_send,
						input stop_send,
						input [31 : 0] datnum_total,
						input [31 : 0] datnum_cut,
						input clr_fifo,
						input head_en,
						
						
						output reg [15 : 0] frame_lenout,
						output reg [15 : 0] blank_lenout,
						output reg start_out,
						output reg stop_out,
						output reg [31 : 0] datnum_total_out,
						output reg [31 : 0] datnum_cut_out,
						output reg fifoclr_out,
						output reg head_en_out
						
						);
						
						
		always @ (posedge clk or negedge reset_n)
		begin
			if(!reset_n)
			begin
				frame_lenout <= 16'd0;
				blank_lenout <= 16'd0;			
				start_out <= 1'b0;
				stop_out <= 1'b0;
				
				datnum_total_out <= 32'd0;
				datnum_cut_out <= 32'd0;
				fifoclr_out <= 1'b0;
				head_en_out <= 1'b0;
			end 
			else if(!cs)
			begin
				frame_lenout <= frame_length;
				blank_lenout <= blank_length;			
				start_out <= start_send;
				stop_out <= stop_send;
				
				datnum_total_out <= datnum_total;
				datnum_cut_out <= datnum_cut;
				fifoclr_out <= clr_fifo;
				head_en_out <= head_en;
			end 
			else;
		end 
		
	endmodule 