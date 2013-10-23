module WrRamSourceCon(
						input clk,
						input reset_n,
						
						input update_flag,
						
						input fifo_ready,
						
						input [15 : 0] dat_in,
						output reg fifo_rdeq,
						
						output reg [15 : 0] wr_dat,
						output reg [9  : 0] wr_addr,
						output reg wr_en,
						output reg ram_flag
						
						);
						
	reg flag_reg0;
	reg flag_reg1;
	reg fifo_ready_reg;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			flag_reg0 <= 1'b0;
			flag_reg1 <= 1'b0;
			fifo_ready_reg <= 1'b0;
		end
		else
		begin
			flag_reg0 <= update_flag;
			flag_reg1 <= flag_reg0;
			fifo_ready_reg <= fifo_ready;
		end
	end 
	
	reg [2:0] state;
	reg [9:0] counter;
	reg wrreg_en;
	
	parameter idle = 3'd0;
	parameter judge_fifo = 3'd1;
	parameter judge_sync0 = 3'd2;
	parameter judge_sync1 = 3'd3;
	parameter calc = 3'd4;
	
	parameter [15 : 0] sync_code0 = 16'heb90;
	parameter [15 : 0] sync_code1 = 16'hfaf3;
	
	parameter [9 : 0] counter_max = 10'd511;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			state <= idle;
			counter <= 10'd0;
			fifo_rdeq <= 1'b0;
			wrreg_en <= 1'b0;
			ram_flag <= 1'b0;
		end 
		else if (flag_reg0)
		begin
			state <= idle;
			counter <= 10'd0;
			fifo_rdeq <= 1'b0;
			wrreg_en <= 1'b0;
			ram_flag <= 1'b0;
		end 
		else
		begin
			case (state)
				idle:
				begin
					if (flag_reg1)//
					begin//
						state <= judge_fifo;
						counter <= 10'd0;
						fifo_rdeq <= 1'b0;
						wrreg_en <= 1'b0;
					end//
					else;//
				end 
				judge_fifo:
				begin
					if (fifo_ready_reg)
					begin
						state <= judge_sync0;
						fifo_rdeq <= 1'b1;	
					end
					else
						state <= judge_fifo;
				end
				judge_sync0:
				begin
					if (dat_in == sync_code0)
					begin
						state <= judge_sync1;
						fifo_rdeq <= 1'b1;
						
					end
					else
					begin
						state <= judge_fifo;
						fifo_rdeq <= 1'b0;	
					end
				end
				judge_sync1:
				begin
					if (dat_in == sync_code1)
					begin
						state <= calc;
						fifo_rdeq <= 1'b1;
						wrreg_en <= 1'b1;	
					end
					else
					begin
						state <= judge_fifo;
						fifo_rdeq <= 1'b0;	
					end
				end
				calc:
				begin
					if (counter < counter_max)
					begin
						state <= calc;
						counter <= counter + 1'b1;
						wrreg_en <= 1'b1;	
					end 
					else
					begin
						//state <= calc;
						state <= idle;
						ram_flag <= 1'b1;
						fifo_rdeq <= 1'b0;
						counter <= 10'd0;
						wrreg_en <= 1'b0;
					end
				end
				default:; 
			endcase
		end 
	end 
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			wr_addr <= 10'd0;
			wr_dat  <= 16'd0;
			wr_en   <=  1'b0;
		end
		else
		begin
			wr_addr <= counter;
			wr_dat  <= dat_in;
			wr_en   <=  wrreg_en;
		end
	end 
endmodule 
	
	