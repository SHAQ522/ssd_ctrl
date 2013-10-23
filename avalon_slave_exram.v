module avalon_slave_exram
(
	input  clk,
	input  in_avs_chipselect_n,
	input  in_avs_write_n,
	input  in_avs_read_n,
	input  [15:0] in_avs_address,
	input  [7:0] in_avs_writedata,
	output [7:0] in_avs_readdata,
	
	output  reg wr_n,
	output  reg rd_n,
	output  reg [15:0] addr,
	output  reg [7:0] wdata,
	input  [7:0] rdata
);

always @(posedge clk)
	if((in_avs_chipselect_n==1'd0) && (in_avs_write_n==1'd0))
		wr_n<=1'd0;
	else
		wr_n<=1'd1;
		
always @(posedge clk)
	if((in_avs_chipselect_n==1'd0) && (in_avs_read_n==1'd0))
		rd_n<=1'd0;
	else
		rd_n<=1'd1;
		
always @(posedge clk)
	addr<=in_avs_address;
	
always @(posedge clk)
	wdata<=in_avs_writedata;


assign	in_avs_readdata=rdata;
	
endmodule
