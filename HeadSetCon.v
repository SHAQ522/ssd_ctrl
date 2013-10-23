module HeadSetCon(
					input clk,
					input reset_n,
					
					input update_flag,
					
					input [3  : 0] sync_code_length,
					input [79 : 0] sync_code_content,
						
						
					input [3  : 0] cntr_length,
					input [47 : 0] cntr_init,
					input [7  : 0] cntr_step,
						
					input res_flag,
					input [7  : 0] res_content,
					
					input [7 : 0] framehead_len,
						
					output reg [3  : 0] sync_code_length_out,
					output reg [79 : 0] sync_code_content_out,
						
						
					output reg [3  : 0] cntr_length_out,
					output reg [47 : 0] cntr_init_out,
					output reg [7  : 0] cntr_step_out,
						
					output reg res_flag_out,
					output reg [7  : 0] res_content_out,
					
					output reg [7 : 0] framehead_len_out
					
					
					);
	reg flag_out0;
	reg flag_out1;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			flag_out0 <= 1'b0;
			flag_out1 <= 1'b0;
		end
		else
		begin
			flag_out0 <= update_flag;
			flag_out1 <= flag_out0;
		end
	end 
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin			
			sync_code_length_out  <= 4'd0;
			sync_code_content_out <= 80'd0;
						
			cntr_length_out  <= 4'd0;
			cntr_init_out    <= 48'd0;
			cntr_step_out    <= 8'd0;
			
			res_content_out  <= 8'd0;
			res_flag_out  <= 1'b0;
			
			framehead_len_out <= 8'd0;
			
		end
		else if (!flag_out1&flag_out0)
		begin
			sync_code_length_out  <= sync_code_length;
			sync_code_content_out <= sync_code_content;
			
			cntr_length_out  <= cntr_length;
			cntr_init_out    <= cntr_init;
			cntr_step_out    <= cntr_step;
			
			res_content_out  <= res_content;
			res_flag_out  <= res_flag;
			
			framehead_len_out <= framehead_len;
			
		end
	end 
endmodule 