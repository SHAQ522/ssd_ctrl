module FrameOutputCon(
						input clk,
						input reset_n,
						
						input update_flag,
						
						input [15 : 0] trace_length,
						input [15 : 0] retrace_length,
												
						input clk_dat,
						input ready_send,
						input start_send,
						
						input fifo_ready,
						
						output reg fifo_rdeq,
						output reg ch_start
						
						
						);
						
	reg  flag_reg0;
	reg  flag_reg1;
	reg  fifo_ready_reg;
	
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
	
	reg [15 : 0] trace_length_reg;
	reg [15 : 0] retrace_length_reg;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			trace_length_reg <= 16'd0;
			retrace_length_reg <= 16'd0;
		end
		else if(!flag_reg0&flag_reg1)
		begin
			trace_length_reg <= {1'b0,trace_length[15:1]};
			retrace_length_reg <= {1'b0,retrace_length[15:1]};
		end
	end 
	
	reg  ready_send_reg;
	reg  start_send_reg0;
	reg  start_send_reg1;
	
	always @ (posedge clk_dat or negedge reset_n)
	begin
		if (!reset_n)
		begin
			ready_send_reg <= 1'b0;
			start_send_reg0 <= 1'b0;
			start_send_reg1 <= 1'b0;
			//fifo_ready_reg <= 1'b0;
		end
		else
		begin
			ready_send_reg <= ready_send;
			start_send_reg0 <= start_send;
			start_send_reg1 <= start_send_reg0;
			//fifo_ready_reg <= fifo_ready;
		end
	end 
	
	reg [15 : 0] cnt;
	reg [2:0] state;
	
	parameter start = 3'd0;
	parameter trace = 3'd1;
	parameter retrace = 3'd2;
	
	always @ (posedge clk_dat or negedge reset_n)
	begin
		if (!reset_n)
		begin
			cnt <= 16'd0;
			state <= start;
			fifo_rdeq <= 1'b0;
			ch_start <= 1'b0;
		end
		else if(!ready_send_reg)
		begin
			cnt <= 16'd0;
			state <= start;
			fifo_rdeq <= 1'b0;
			ch_start <= 1'b0;
		end
		else
		begin
			case (state)
				start :
				begin
					if((!start_send_reg1)&&(start_send_reg0))
					begin
						cnt <= 16'd0;
						state <= trace;
						fifo_rdeq <= 1'b0;
						ch_start <= 1'b1;
					end
					else
						state <= start;
				end
				trace :
				begin
					if(cnt < trace_length_reg)
					begin
						cnt <= cnt + 1'b1;
						state <= trace;
						fifo_rdeq <= 1'b1;
					end
					else if (!fifo_ready_reg)
					begin
						//cnt <= 16'd1;
						state <= trace;
						fifo_rdeq <= 1'b0;
					end
					else if(retrace_length_reg!=16'd0)
					begin
						cnt <= 16'd1;
						state <= retrace;
						fifo_rdeq <= 1'b0;
					end
					else 
					begin
						cnt <= 16'd1;
						state <= trace;
						fifo_rdeq <= 1'b1;
					end
					//else;
				end
				retrace :
				begin
					if(cnt < retrace_length_reg)
					begin
						cnt <= cnt + 1'b1;
						state <= retrace;
						fifo_rdeq <= 1'b0;
					end
					else  if (fifo_ready_reg)
					begin
						cnt <= 16'd1;
						state <= trace;
						fifo_rdeq <= 1'b1;
					end
					else
					begin
						//cnt <= cnt + 1'b1;
						state <= retrace;
						fifo_rdeq <= 1'b0;
					end
				end
				default:;
			endcase
		end
	end 
endmodule 
	
	
	