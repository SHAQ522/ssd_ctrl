module FrameSetCon(
					input clk,
					input reset_n,
					
					input update_flag,
					
					input [2 : 0] source_choose,
					input [15 : 0] framedat_length,
					input [15 : 0] trace_length,
					input [15 : 0] retrace_length,
					
					output reg [2 : 0] source_choose_out,
					output reg [15 : 0] framedat_length_out,
					output reg [15 : 0] trace_length_out,
					output reg [15 : 0] retrace_length_out
					);
	reg flag_reg0;
	reg flag_reg1;
	
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
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin			
			retrace_length_out <= 16'd0;
			trace_length_out <= 16'd0;
			framedat_length_out <= 16'd0;
			source_choose_out <= 3'd0;
		end
		else if (!flag_reg1&flag_reg0)
		begin
			retrace_length_out <= retrace_length;
			trace_length_out <= trace_length;
			framedat_length_out <= framedat_length;
			source_choose_out <= source_choose;
		end
	end 
endmodule 