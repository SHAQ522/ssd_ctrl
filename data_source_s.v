module data_source_s(
	input clk,
	input nRST,
	output reg [7:0] data_out,
	output reg data_en
	);

reg [7:0] data_reg;
reg [7:0] count;

always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			data_reg <= 8'd0;
			count <= 8'd0;
		end
	else
		begin
			data_reg <= data_reg + 1'b1;
			if(data_reg == 8'd255)
				count <= count + 1;
		end
end

always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			data_out <= 8'd0;
			data_en  <= 1'b0;
		end
	else
		begin
			if(data_reg == 8'd0)
				data_out <= count;
			else
			data_out <= data_reg;	
			data_en  <= 1'b1;
		end
end

endmodule
