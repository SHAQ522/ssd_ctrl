module data_source_sata(
	input  clk,
	input  nRST,
	output reg en,
	output reg[7:0]data_out
	);

always@(posedge clk)
begin
	if(!nRST)
	  begin
		en <= 1'b0;
		data_out <= 8'd0;
	  end
	else
	  begin
		en <= 1'b1;
		data_out <= data_out + 1'b1;
	  end
end

endmodule 