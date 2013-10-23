module source_ct(
	input clk,//----------------系统时钟
	input nRST,//---------------系统复位
	input en_in,
	input [15:0]data_in,
	
	output reg data_en,
	output reg [15:0]data_out
	);
	
reg [2:0]count;

always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		count <= 3'd0;
	else if(en_in == 1'b1)
		count <= count + 1'b1;
	else
		count <= count;	
end

always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		data_en <= 1'b1;
	else if(count == 4'd7)
		data_en <= 1'b0;
	else
		data_en <= 1'b1;
		
end

always @(posedge clk)
begin
	data_out <= data_in;	
end

endmodule
