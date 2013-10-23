module sdram_fifo_ctrl(
	input clk,
	input nRST,
	input [14:0] usedw_rd_1,
	input [14:0] usedw_rd_2,
	input [14:0] usedw_rd_3,
	input [14:0] usedw_rd_4,
	input [12:0] usedw_wr,
	output reg ack
	);
	
always @(posedge clk or negedge nRST)
begin
if(!nRST)
	ack <= 0;
else
	begin
		if((usedw_wr < 13'd4000) && (usedw_rd_1 > 14'd100) && (usedw_rd_2 > 14'd100) && (usedw_rd_3 > 14'd100) && (usedw_rd_4 > 14'd100))
			ack <= 1;
		else
			ack <= 0;
	end	
end
	
endmodule
