module FixedSetCon(
					input clk,
					input reset_n,
					
					input update_flag,
					
					input [7 : 0] fixed_init,
					input [7 : 0] fixed_step,
					
					output reg [7 : 0] fixed_init_out,
					output reg [7 : 0] fixed_step_out 
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
			fixed_init_out <= 8'd0;
			fixed_step_out <= 8'd0;
		end
		else if (!flag_reg1&flag_reg0)
		begin
			fixed_init_out <= fixed_init;
			fixed_step_out <= fixed_step;
		end
	end 
endmodule 