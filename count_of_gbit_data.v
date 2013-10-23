module count_of_gbit_data(
	input clk,
	input nRST,
	input wen,
	
	output reg [31:0] packet_count);
	
reg [7:0] now_col;
	
always @(posedge clk or negedge nRST)
if(!nRST)
begin
	now_col<=0;
	packet_count<=0;
end
else
begin
	if(wen)
	begin
		now_col<=now_col+8'd1;
		if(now_col==8'd255)
			packet_count<=packet_count+32'd1;
	end
end

endmodule
