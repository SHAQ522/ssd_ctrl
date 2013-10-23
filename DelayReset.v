module DelayReset(
					input clk,
					input reset_n,
					
					input [7:0] reset_db,
					
					output reg reset_out_n	
					);
	reg [31 : 0] cnt;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
			cnt <= 32'd0;
		else if (reset_db == 8'd55)
			cnt <= 32'd0;
		else if (cnt < 32'd500000000)
			cnt <= cnt + 1'b1;
	end
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
			reset_out_n <= 1'b1;
		else if ((cnt < 32'd400000000)&&(cnt > 32'd350000000))
			reset_out_n <= 1'b0;
		else
			reset_out_n <= 1'b1;
	end
endmodule 
		