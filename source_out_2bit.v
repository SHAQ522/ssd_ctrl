module source_out_2bit(
	input clk,
	input data_en_in,
	input out_en,
	input [1:0]data_in,
	output reg data_en,
	output reg [1:0]data_out
	);

always @(posedge clk)
begin
	data_en <= data_en_in + out_en;
	data_out <= data_in;
end

endmodule
