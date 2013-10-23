module SSDReadyCon(
						input clk,
						input reset_n,
						
						input fifo_full_h,
						input ssd_oe,
						
						output reg ssd_ready,
						output reg ssd_oe_out
);
	reg fifo_full_h_reg;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			fifo_full_h_reg <= 1'b0;
			ssd_oe_out <= 1'b0;
		end
		else
		begin
			fifo_full_h_reg <= fifo_full_h;
			ssd_oe_out <= ssd_oe;
		end
	end 
	
	parameter [10 : 0] max_num = 11'd1000;
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
			ssd_ready <= 1'b0;
		else if ((fifo_full_h_reg)||(!ssd_oe_out))
			ssd_ready <= 1'b0;
		else
			ssd_ready <= 1'b1;
	end 
	
endmodule 