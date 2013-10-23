module RdSetFifoCon(
					input clk,
					input reset_n,
					
					input [10 : 0] fifo_num,
					
					output reg en_out
					);
					
					
		always @ (posedge clk or negedge reset_n)
		begin
			if (!reset_n)
			begin
				en_out <= 1'b0;
			end 
			else if (fifo_num >= 11'd3)
			begin
				en_out <= 1'b1;
			end
			else
			begin
				en_out <= 1'b0;
			end
		end 
		
endmodule 