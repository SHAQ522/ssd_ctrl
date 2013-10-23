//2013Äê3ÔÂ14ÈÕ15:55:25
module FrameHeadGen(
						input clk,
						input reset_n,
						
						input [3  : 0] sync_code_length,
						input [79 : 0] sync_code_content,
						
						
						input [3  : 0] cntr_length,
						input [47 : 0] cntr_init,
						input [7  : 0] cntr_step,
						
						input res_flag,
						input [7  : 0] res_content,
						
						input update_flag,
						
						input fifo_full_h,
						input [2 : 0] channel_choose,
						
						output reg [7 : 0] dat_out,
						output reg en_out
);

	reg flag_reg0;
	reg flag_reg1;
	reg fifo_full_h_reg;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			flag_reg0 <= 1'b0;
			flag_reg1 <= 1'b0;
			fifo_full_h_reg <= 1'b0;
		end 
		else
		begin
			flag_reg0 <= update_flag;
			flag_reg1 <= flag_reg0;
			fifo_full_h_reg <= fifo_full_h;
		end
	end 
	
	reg [3  : 0] sync_code_length_reg;
	reg [3  : 0] sync_code_length_tra;
	reg [79 : 0] sync_code_content_reg;
						
						
	reg [3  : 0] cntr_length_reg;
	reg [3  : 0] cntr_length_tra;
	
	reg [47 : 0] cntr_init_reg;
	reg [7  : 0] cntr_step_reg;
						
	reg res_flag_reg;
	reg [7  : 0] res_content_reg; 
	
	reg [2 : 0] channel_choose_reg;
	
	parameter sync_length_max = 4'd10;
	parameter cntr_length_max = 4'd6;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin			
			sync_code_length_reg  <= 4'd0;
			sync_code_length_tra  <= 4'd0;
			sync_code_content_reg <= 80'd0;
						
			cntr_length_reg  <= 4'd0;
			cntr_length_tra  <= 4'd0;
			cntr_init_reg    <= 48'd0;
			cntr_step_reg    <= 8'd0;
			
			res_content_reg  <= 8'd0;
			res_flag_reg  <= 1'b0;
			
			channel_choose_reg <= 3'd0;
		end
		else if (!flag_reg1&flag_reg0)
		begin
			sync_code_length_reg  <= sync_code_length;
			sync_code_length_tra  <= sync_length_max - sync_code_length;
			sync_code_content_reg <= sync_code_content;
			
			cntr_length_reg  <= cntr_length;
			cntr_length_tra  <= cntr_length_max - cntr_length;
			cntr_init_reg    <= cntr_init;
			cntr_step_reg    <= cntr_step;
			
			res_content_reg  <= res_content;
			res_flag_reg  <= res_flag;
			
			channel_choose_reg <= channel_choose;
		end
	end 
	
	reg [2 : 0] state;
	reg [3 : 0] counter;
	reg [79 : 0] sync_send_reg;
	
	reg [47 : 0] frame_cnt;
	reg [47 : 0] frame_cnt_send;
	
	reg [7 : 0] datreg_out;
	reg enreg_out;
	
	parameter idle       = 3'd0 ;
	parameter judge_fifo = 3'd1 ;
	parameter send_sync  = 3'd2 ;
	parameter send_cntr  = 3'd3 ;
	parameter delay      = 3'd4 ;
	
	parameter stop_channel = 3'd0;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			state <= idle;
			sync_send_reg <= 80'd0;
			datreg_out <= 8'd0;
			enreg_out <= 1'b0;
			counter <= 4'd0;
			frame_cnt <= 48'd0;
			frame_cnt_send <= 48'd0;
		end 
		else if (flag_reg0)
		begin
			state <= idle;
			sync_send_reg <= 80'd0;
			enreg_out <= 1'b0;
			datreg_out <= 8'd0;
			counter <= 4'd0;
			frame_cnt <= 48'd0;
			frame_cnt_send <= 48'd0;
		end 
		else
		begin
			case (state)
				idle:
				begin
					if ((flag_reg1)&&(channel_choose_reg != stop_channel))
					begin
						state <= judge_fifo;
						sync_send_reg <= sync_code_content_reg << {sync_code_length_tra , 3'd0};
						
						frame_cnt <= cntr_init_reg;
						frame_cnt_send <= cntr_init_reg<<{cntr_length_tra,3'd0};
						
						enreg_out <= 1'b0;
						datreg_out <= 8'd0;
					end 
				end
				judge_fifo:
				begin
					if (!fifo_full_h_reg)
					begin
						state <= send_sync;
						datreg_out <= sync_send_reg[79:72];
						sync_send_reg <= {sync_send_reg[71:0] , 8'd0};
						enreg_out <= 1'b1;
						counter <= 4'd1;
					end
					else
						state <= judge_fifo;
				end
				send_sync:
				begin
					if (counter < sync_code_length_reg)
					begin
						state <= send_sync;
						datreg_out <= sync_send_reg[79:72];
						sync_send_reg <= {sync_send_reg[71:0] , 8'd0};
						//enreg_out <= 1'b1;
						counter <= counter + 1'b1;
					end
					else
					begin
						state <= send_cntr;
						datreg_out <= frame_cnt_send[47:40];
						frame_cnt_send <= { frame_cnt_send[39:0] , 8'd0};
						frame_cnt <= frame_cnt + cntr_step_reg;
						//enreg_out <= 1'b1;
						counter <= 4'd1;
					end
				end
				send_cntr:
				begin
					if (counter < cntr_length_reg)
					begin
						state <= send_cntr;
						datreg_out <= frame_cnt_send[47:40];
						frame_cnt_send <= { frame_cnt_send[39:0] , 8'd0};
						//enreg_out <= 1'b1;
						counter <= counter + 1'b1;
					end
					else if (res_flag_reg)
					begin
						state <= delay;
						datreg_out <= res_content_reg;
						enreg_out <= 1'b1;
						counter <= 4'd0;
						sync_send_reg <= sync_code_content_reg << {sync_code_length_tra , 3'd0};
					
						frame_cnt_send <= frame_cnt<<{cntr_length_tra,3'd0};
					end
					else
					begin
						state <= judge_fifo;
						sync_send_reg <= sync_code_content_reg << {sync_code_length_tra , 3'd0};
					
						frame_cnt_send <= frame_cnt<<{cntr_length_tra,3'd0};
						enreg_out <= 1'b0;
						counter <= 4'd0;
					end
				end
				delay:
				begin
					state <= judge_fifo;
					enreg_out <= 1'b0;
				end
				default:; 
			endcase
		end
	end
	
		always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			dat_out <= 8'd0;
			en_out <= 1'b0;
		end 
		else
		begin
			dat_out <= datreg_out;
			en_out <= enreg_out;
		end
	end 
	
endmodule 
	
	
	
	
	
	
	
	
	
	