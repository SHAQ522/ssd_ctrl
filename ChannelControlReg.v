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
						
						
						output reg [15 : 0] frame_lenout,
						output reg [15 : 0] blank_lenout,
						output reg start_out,
						output reg stop_out,
						output reg [15 : 0] rdaddr_begin_out,
						output reg [15 : 0] rdaddr_end_out,
						output reg pre_fifoclr_out,
						output reg post_fifoclr_out
						
						);
						
						
		always @ (posedge clk or negedge reset_n)
		begin
			if(!reset_n)
			begin
				wr_out <= 1'b0;
				rd_out <= 1'b0;
				wraddr_begin_out <= 16'd0;
				wraddr_end_out <= 16'd0;
				rdaddr_begin_out <= 16'd0;
				rdaddr_end_out <= 16'd0;
				pre_fifoclr_out <= 1'b0;
				post_fifoclr_out <= 1'b0;
			end 
			else if(!cs)
			begin
				wr_out <= wr_sdram;
				rd_out <= rd_sdram;
				wraddr_begin_out <= wraddr_begin;
				wraddr_end_out <= wraddr_end;
				rdaddr_begin_out <= rdaddr_begin;
				rdaddr_end_out <= rdaddr_end;
				pre_fifoclr_out <= pre_fifoclr;
				post_fifoclr_out <= post_fifoclr;
			end 
			else;
		end 
		
	endmodule 