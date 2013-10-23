module source_out_1bit(
	input clk,
	input en_in,	
	input data_in,
	input out_en,
	output reg data_en,
	output reg data_out
	);

always @(posedge clk)
begin
	data_en <= en_in + out_en;
	data_out <= data_in;
end


endmodule
