module source_out_1bit_s(
	input clk,
	input clk_s,
	input data_en_in,
	input out_en,
	input data_in,
	output reg data_en,
	output reg data_en_neg,
	output reg data_out
	);
	
reg data_en_neg0,data_en_neg1;

always @(posedge clk)
begin
	data_en <= data_en_in;
	data_out <= data_in;
end

always @(posedge clk_s)
begin
	data_en_neg0 <= data_en_in;
	data_en_neg1 <= data_en_neg0;
	data_en_neg <= data_en_neg1;
end

endmodule
