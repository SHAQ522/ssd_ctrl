module data_source_16bit(
	input clk,
	input nRST,
	input [13:0] wrusedw,
	output reg [15:0] data_out,
	output reg data_en
	);

reg [15:0] data_reg;
reg [31:0] count;
reg fifo_ready;

always @(posedge clk)
begin
	if(wrusedw<14'd8000)
		fifo_ready <= 1'b1;
	else
		fifo_ready <= 1'b0;
end

always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			data_reg <= 16'd0;
			count <= 32'd0;
		end
	else if(fifo_ready)
		begin
			if(data_reg == 16'd511)
				data_reg <= 16'd0;
			else	
				data_reg <= data_reg + 1'b1;
			if(data_reg == 16'd511)
				count <= count + 1'b1;
		end
end

always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			data_out <= 16'd0;
			data_en  <= 1'b0;
		end
	else if(fifo_ready)
		begin
			if(data_reg == 16'd0)
				data_out <= 16'h1acf;
			else if(data_reg == 16'd1)
				data_out <= 16'hfc1d;	
			else if(data_reg == 16'd2)
				data_out <= count[31:16];
			else if(data_reg == 16'd3)
				data_out <= count[15:0];
			else
				data_out <= data_reg[15:0];
			data_en  <= 1'b1;
		end
	else
			data_en  <= 1'b0;
end

endmodule
