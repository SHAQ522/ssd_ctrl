module fifo_ready_ctrl(
	input clk,
	input [6:0] usedw_a,
	input [12:0] usedw_b,
	
	output reg fifo_ready
	);

always @(posedge clk)
begin
	if((usedw_a < 7'd30) & (usedw_b < 13'd3000))
		fifo_ready <= 1'b1;
	else
		fifo_ready <= 1'b0;
end


endmodule
