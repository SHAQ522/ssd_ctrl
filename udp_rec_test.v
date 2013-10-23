module udp_rec_test(
			input clk,
			input nRST,
			input en_in,
			input [31:0]	data_in,
			
			output reg[31:0]data_out,	
			output reg en_out,		
			output reg[11:0]addr	
			);

always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			data_out <= 32'd0;
			en_out <= 1'b0;
			addr <= 12'd0;
		end	
	else if(!en_in)
		begin
			data_out <= 32'd0;
			en_out <= 1'b0;
			addr <= 12'd0 - 1'b1;
		end
	else
		begin
			data_out <= data_in;
			en_out <= 1'b1;
			addr <= addr + 1'b1;
		end
end			

endmodule
