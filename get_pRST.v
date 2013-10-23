module get_pRST(
	input clk,
	input pRST_IN,
	output reg pRST);
	
reg [31:0] count=32'd0;	
always @(posedge clk or posedge pRST_IN)
	if(pRST_IN==1)
	begin
		count<=0;
		pRST<=1;
	end
	else
	begin
		if(count>=100000000)
			pRST<=0;
		else
		begin
			count<=count+1;
			pRST<=1;
		end
	end

endmodule
