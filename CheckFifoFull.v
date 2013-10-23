module CheckFifoFull(
						input clk,
						input reset_n,
						
						input [10 : 0] fifo_num,
						
						output reg fifo_full_h,
						output reg fifo_ready_h
);
	reg [10 : 0] fifo_num_reg;
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
			fifo_num_reg <= 11'd0;
		else
			fifo_num_reg <= fifo_num;
	end 
	
	parameter [10 : 0] max_num = 11'd1000;
	parameter [10 : 0] min_num = 11'd10;
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
			fifo_full_h <= 1'b0;
		else if (fifo_num_reg > max_num)
			fifo_full_h <= 1'b1;
		else
			fifo_full_h <= 1'b0;
	end 
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
			fifo_ready_h <= 1'b0;
		else if (fifo_num_reg > min_num)
			fifo_ready_h <= 1'b1;
		else
			fifo_ready_h <= 1'b0;
	end 
	
endmodule 