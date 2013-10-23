module fifo_ready_ctrl_s(
	input clk,
	input [14:0] usedw_b,
	
	output reg fifo_ready
	);

always @(posedge clk)
begin
	if(usedw_b < 15'd5000)
		fifo_ready <= 1'b1;
	else
		fifo_ready <= 1'b0;
end


endmodule
