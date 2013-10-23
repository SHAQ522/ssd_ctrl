module key_sure(
	input clk,
	input KEY_IN,
	output reg KEY_OUT
	);
	
reg [31:0] count=32'd0;	
reg KEY_REG;

always @(posedge clk)
begin
	if(KEY_OUT != KEY_IN)
	begin
		if(count>=32'd50_000_000)
			KEY_OUT <= KEY_IN;
		else
		begin
			count<=count+1;
		end
	end
	else
		count <= 32'd0;
end

endmodule
