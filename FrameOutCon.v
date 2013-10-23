module FrameOutCon(	
					input clk,
					input reset_n,
					
					input start_en,
					input stop_en,
					input head_en,
					
					input [15 : 0] frame_length,
					input [15 : 0] blank_length,
					
					input [12 : 0] fifo_rdnum,
					
					input [15 : 0] dat_in,
					
					output reg rdacq,
					
					output reg en_out,
					output reg [15 : 0] dat_out
	);
	
	reg start_reg0;
	reg start_reg1;
	reg stop_reg0;
	reg stop_reg1;
	
	always @ (posedge clk)
	begin
		start_reg0 <= start_en;
		start_reg1 <= start_reg0;
		stop_reg0 <= stop_en;
		stop_reg1 <= stop_reg0;
	end 
	
	reg fifo_available;
	always @ (posedge clk or negedge reset_n)
	begin
		if(!reset_n)
			fifo_available <= 1'b0;
		else if(fifo_rdnum>=frame_length)
			fifo_available <= 1'b1;
		else
			fifo_available <= 1'b0;
	end 

	
	reg [15 : 0] count;
	reg [4 : 0] state;
	
	parameter [5 : 0] idle			= 5'd0;
	parameter [5 : 0] judge_start	= 5'd1;
	parameter [5 : 0] send_head0 	= 5'd2;
	parameter [5 : 0] send_head1	= 5'd3;
	parameter [5 : 0] send_dat 		= 5'd4;
	parameter [5 : 0] send_blank 	= 5'd5;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			state <= idle;
			count <= 16'd0;
			rdacq <= 1'b0;
			en_out <= 1'b0;
			dat_out <= 16'd0;
		end 
		else
		begin
			case (state)
				idle:
				begin
					state <= judge_start;
					count <= 16'd0;
					rdacq <= 1'b0;
					en_out <= 1'b0;
				end
				judge_start:
				begin
					if(fifo_available&&head_en)
					begin
						state <= send_head0;
						count <= 16'd0;
						rdacq <= 1'b0;
						en_out <= 1'b0;
					end
					else if(fifo_available&&!head_en)
					begin
						state <= send_dat;
						count <= 16'd0;
						rdacq <= 1'b1;
						en_out <= 1'b0;
					end 
					else
					begin
						state <= judge_start;
						count <= 16'd0;
					end 
					
				end
				send_head0:
				begin
					count <= 16'd1;
					state <= send_head1;
					rdacq <= 1'b0;
					en_out <= 1'b1;
					dat_out <= 16'h1acf;
				end
				send_head1:
				begin
					count <= 16'd2;
					state <= send_dat;
					rdacq <= 1'b1;
					en_out <= 1'b1;
					dat_out <= 16'hfc1d;
				end
				send_dat:
				begin
					if(count < frame_length)
					begin
						count <= count + 1'b1;
						state <= send_dat;
						rdacq <= 1'b1;
						en_out <= 1'b1;
						dat_out <= dat_in;
					end 
					else if(count == frame_length)
					begin
						count <= count + 1'b1;
						state <= send_dat;
						rdacq <= 1'b0;
						en_out <= 1'b1;
						dat_out <= dat_in;
					end 
					else
					begin
						state <= send_blank;
						count <= 16'd0;
						en_out <= 1'b0;
					end 
				end
				send_blank:
				begin
					if(count < blank_length)
					begin
						count <= count + 1'b1;
						state <= send_blank;
					end 
					else
					begin
						state <= judge_start;
						count <= 16'd0;
						en_out <= 1'b0;
					end
				end
				default:;
			endcase
		end 
	end 
	
endmodule 		