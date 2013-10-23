module data_source(
	input clk,
	input nRST,
	input [14:0] wrusedw,
	output reg [7:0] data_out,
	output reg data_en
	);

reg [15:0] data_reg;
reg [31:0] count;
reg fifo_ready;

always @(posedge clk)
begin
	if(wrusedw<15'd16000)
		fifo_ready <= 1'b1;
	else
		fifo_ready <= 1'b0;
end

always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			data_reg <= 8'd0;
			count <= 32'd0;
		end
	else if(fifo_ready)
		begin
			if(data_reg == 16'd1023)
				data_reg <= 16'd0;
			else	
				data_reg <= data_reg + 1'b1;
			if(data_reg == 16'd1023)
				count <= count + 1'b1;
		end
end

always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			data_out <= 8'd0;
			data_en  <= 1'b0;
		end
	else if(fifo_ready)
		begin
			if(data_reg == 16'd0)
				data_out <= 8'h1a;
			else if(data_reg == 16'd1)
				data_out <= 8'hcf;	
			else if(data_reg == 16'd2)
				data_out <= 8'hfc;
			else if(data_reg == 16'd3)
				data_out <= 8'h1d;
			else if(data_reg == 16'd4)
				data_out <= count[31:24];
			else if(data_reg == 16'd5)
				data_out <= count[23:16];	
			else if(data_reg == 16'd6)
				data_out <= count[15:8];
			else if(data_reg == 16'd7)
				data_out <= count[7:0];
			else
				data_out <= data_reg[7:0];	
			data_en  <= 1'b1;
		end
	else
			data_en  <= 1'b0;
end

endmodule
