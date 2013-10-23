module ScrUpdateCon(
					input clk,
					input reset_n,
					
					input update_flag,
					
					input  scr_choose,
					input [7 : 0] unscr_length,
					
					output reg  scr_choose_out,
					output reg [7 : 0] unscr_length_out
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
			scr_choose_out <= 1'b0;
			unscr_length_out <= 8'd0;
		end
		else if (!flag_reg1&flag_reg0)
		begin
			scr_choose_out <= scr_choose;
			unscr_length_out <= unscr_length;
		end
	end 
endmodule 