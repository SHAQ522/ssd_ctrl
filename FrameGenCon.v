module FrameGenCon(
						input clk,
						input reset_n,
						
						//input [2 : 0] channel_choose,
						
						//input [15 : 0] retrace_length,
						input [15 : 0] dat_length,
						input [7  : 0] head_length,
						input [7  : 0] unscr_length,
						
						input update_flag,
						
						input head_ready,
						input dat_ready,
						
						output reg head_rdeq,
						input  [15 : 0] head_in,//ackFIFO
						
						output reg dat_rdeq,
						input  [15 : 0] dat_in,//ackfifo
						
						output reg en_out,
						output reg [15 : 0] dat_out,
						
						input fifo_full,
						
						output reg [10 : 0] addr_scr,
						output reg scr_flag_out,
						
						input [15 : 0] scr_dbin,
						input scr_choose						
					
					);
					
	reg  flag_reg0;
	reg  flag_reg1;
	reg scr_flag;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			flag_reg0 <= 1'b0;
			flag_reg1 <= 1'b0;
		end
		else
		begin
			flag_reg0 <= update_flag;
			flag_reg1 <= flag_reg0;
		end
	end 
	
	reg  head_ready_reg;
	reg  dat_ready_reg;
	reg  fifo_full_reg;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			head_ready_reg <= 1'b0;
			dat_ready_reg <= 1'b0;
			fifo_full_reg <= 1'b0;
		end
		else
		begin
			head_ready_reg <= head_ready;
			dat_ready_reg <= dat_ready;
			fifo_full_reg <= fifo_full;
		end
	end 
	
	//reg [15 : 0] retrace_length_reg;
	reg [15 : 0] dat_length_reg;
	reg [ 7 : 0] head_length_reg;
	reg [ 7 : 0] unscr_length_reg;
	reg scr_choose_reg;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			//retrace_length_reg <= 16'd0;
			dat_length_reg   <= 16'd0;
			head_length_reg    <=  8'd0;
			unscr_length_reg    <=  8'd0;
			scr_choose_reg <= 1'b0;
		end
		else if(flag_reg0&!flag_reg1)
		begin
			//retrace_length_reg <= {1'b0,retrace_length[15 : 1]};
			dat_length_reg     <= {1'b0,dat_length[15 : 1]};
			head_length_reg    <= {1'b0,head_length[7 : 1]};
			unscr_length_reg    <= {1'b0,unscr_length[7 : 1]};
			scr_choose_reg <= scr_choose;
		end
	end
	
	reg [2 : 0] state;
	
	//reg [15 : 0] frame_cnt;
	//output reg scr_flag;
	
	reg [15 : 0] count;
	
	parameter idle       = 3'd0 ;
	parameter judge_fifo = 3'd1 ;
	parameter send_head  = 3'd2 ;
	parameter send_dat   = 3'd3 ;
	//parameter send_ret   = 3'd4 ;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			state <= idle;

			count <= 16'd0;
			head_rdeq <= 1'b0;
			dat_rdeq <= 1'b0;
			
			scr_flag <= 1'b0;
		end
		else if (flag_reg0)
		begin
			state <= idle;

			count <= 16'd0;
			head_rdeq <= 1'b0;
			dat_rdeq <= 1'b0;
			
			scr_flag <= 1'b0;
		end 
		else
		begin
			case (state)
			idle:
				if (flag_reg1)
					begin
						state <= judge_fifo;
					end
					else;
			
			judge_fifo:
			begin
				if ((head_ready_reg)&&(dat_ready_reg))
				begin
					state <= send_head;
				
					head_rdeq <= 1'b0;
					
					count <= 16'd0;
					
					scr_flag <= 1'b0;
				end
				else
				begin
					state <= judge_fifo;
				end
			end
			
			send_head:
			begin
				if ((count < unscr_length_reg)&&(!fifo_full_reg))
				begin
					count <= count + 1'b1;
					state <= send_head;
					
					head_rdeq <= 1'b1;
					
					scr_flag <= 1'b0;
				end
				else if ((count < head_length_reg)&&(!fifo_full_reg))
				begin
					count <= count + 1'b1;
					state <= send_head;
					
					head_rdeq <= 1'b1;
					
					scr_flag <= scr_choose_reg;
										
				end
				else if((count >= head_length_reg)&&(!fifo_full_reg))
				begin
					count <= 16'd1;
					state <= send_dat;
					
					head_rdeq <= 1'b0;
					dat_rdeq <= 1'b1;
					
					scr_flag <= 1'b1;
					
				end 
				else if(fifo_full_reg)
				begin
					state <= send_head;
					head_rdeq <= 1'b0;
					dat_rdeq <= 1'b0;
					
					scr_flag <= 1'b0;
				end
				else;
			end
			
			send_dat:
			begin
				
				if ((!dat_ready_reg)||(fifo_full_reg))
				begin
					state <= send_dat;
					head_rdeq <= 1'b0;
					dat_rdeq <= 1'b0;
					//enreg_out  <=  1'b0;
					scr_flag <= 1'b0;
				end
				else if(count >= dat_length_reg)
				begin
					count <= 16'd0;
					state <= judge_fifo;
					dat_rdeq <= 1'b0;
					scr_flag <= 1'b0;
				end 
				else 
				begin
					count <= count + 1'b1;
					state <= send_dat;
					dat_rdeq <= 1'b1;
					scr_flag <= scr_choose_reg;//
				end
			end
			
//			send_ret:
//			begin
//				if (count < retrace_length_reg)
//				begin
//					count <= count + 1'b1;
//					state <= send_ret;	
//				end
//				else
//				begin
//					count <= 16'd0;
//					state <= judge_fifo;
//				end
//			end
			
			default:;
			endcase
		end 
	end 

	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			addr_scr <= 11'd0;
		end
		else if (state == judge_fifo)
		begin
			addr_scr <= 11'd0;
		end
		else if (scr_flag)
		begin
			if (addr_scr < 11'd254)
				addr_scr <= addr_scr +1'b1;
			else
				addr_scr <= 11'd0;
		end 
	end
	
	wire [15 : 0] datreg_out;
	wire enreg_out;
	
	assign enreg_out = head_rdeq|dat_rdeq;
	assign datreg_out = (dat_rdeq) ? dat_in : head_in;
	
	reg [15 : 0] datreg1_out;
	reg enreg1_out;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			datreg1_out <= 16'd0;
			enreg1_out  <=  1'b0;
			scr_flag_out <= 1'b0;
		end
		else
		begin
			datreg1_out <=  datreg_out;
			enreg1_out  <=   enreg_out;
			scr_flag_out <= scr_flag;
		end
	end 
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			dat_out <= 16'd0;
			en_out  <=  1'b0;
		end
		else if (scr_flag_out)
		begin
			dat_out <=  datreg1_out^scr_dbin;
			en_out  <=   enreg1_out;
		end
		else 
		begin
			dat_out <=  datreg1_out;
			en_out  <=   enreg1_out;
		end
	end 

endmodule 
	
	
	
	
	