module IDE_rDATA_FIFO_control(
	input clk,
	input nRST,
	input [10:0] usedw_rd,
	input [13:0] usedw_wr_1,
	input [13:0] usedw_wr_2,
	input [13:0] usedw_wr_3,
	input [13:0] usedw_wr_4,
	output reg ack
	);
	
always @(posedge clk or negedge nRST)
begin
if(!nRST)
	ack <= 0;
else
	begin
		if((usedw_rd > 11'd100) && (usedw_wr_1 < 14'd8000) && (usedw_wr_2 < 14'd8000) && (usedw_wr_3 < 14'd8000) && (usedw_wr_4 < 14'd8000))
			ack <= 1;
		else
			ack <= 0;
	end	
end
	
endmodule
