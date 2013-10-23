module source_out_16bit(
	input clk,
	input nRST,
	input data_en_in,
	input [15:0]data_in,
	input out_en,
	output reg data_en,
	output reg data_en_neg,
	output reg [15:0]data_out
	);

always @(posedge clk or negedge nRST)
begin
	if(!nRST)
	begin
		data_en <= data_en_in + out_en;
		data_out <= 16'd0;
	end	
	else
	begin
		data_en <= data_en_in + out_en;
		data_out <= data_in;
	end
end

always @(negedge clk  or negedge nRST)
begin
	if(!nRST)
	begin
		data_en_neg <= 1'b0;
	end	
	else
	begin
		data_en_neg <= data_en_in;
	end
end

endmodule
