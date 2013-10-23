module source_out_16bit_v1(
	input clk,
	input data_en_in,
	input [15:0]data_in,
	input out_en,
	output reg data_en,
	output reg data_en_neg,
	output reg [15:0]data_out
	);

always @(posedge clk)
begin
	data_en <= data_en_in;
	data_out <= data_in;
end

always @(negedge clk)
begin
	data_en_neg <= data_en_in;
end

endmodule
