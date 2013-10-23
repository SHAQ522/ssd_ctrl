module FIFOReadyCheck(
					input clk,
					input reset_n,
					
					input [10 : 0] fifo_num,
					
					output reg fifo_ready
					);
	parameter [10 : 0] ready_num = 	11'd514;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			fifo_ready <= 1'b0;
		end 
		else if(fifo_num >= ready_num)
		begin
			fifo_ready <= 1'b1;
		end 
		else
		begin
			fifo_ready <= 1'b0;
		end 		
	end 
endmodule 