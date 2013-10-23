module CpuWriteCon(
	input clk,
	input pRST,
	input cpu_wr_n,
	input [8:0] cpu_addr,
	input [31:0] cpu_wdata,
/****MAC控制*************************/	
	output reg  mac_reset,//--------------------MAC层模块复位，NIOS地址为1
	output reg  [31:0]packet_size,//------------UDP数据一包的长度，NIOS地址为2
	output reg  start_send,//-------------------UDP数据发送信号，NIOS地址为3
	
	output reg [7 : 0] sdram_channel, 
	
	output reg sdram_wr,
	output reg sdram_rd,
	output reg [15 : 0] sdram_wraddr_begin,
	output reg [15 : 0] sdram_wraddr_end,
	output reg [15 : 0] sdram_rdaddr_begin,
	output reg [15 : 0] sdram_rdaddr_end,
	output reg  sdram_pre_clr,
	output reg  sdram_post_clr,
	
	output reg [7 : 0] source_channel,
	output reg [15 : 0] source_framelen,
	output reg [15 : 0] source_blanklen,
	output reg source_start_send,
	output reg source_stop_send,
	output reg [31 : 0] source_totalnum,
	output reg [31 : 0] source_cutnum,
	output reg source_headen,
	output reg source_clrfifo,
	
	output reg error
	
	);
//***MAC控制***************************************************************************************************************************************************************//	
always @(posedge clk or posedge pRST)
if(pRST)
	mac_reset<=1'b0;
else
	if((cpu_wr_n==0) && (cpu_addr==1))
		mac_reset<=cpu_wdata[0];
always @(posedge clk or posedge pRST)
if(pRST)
	packet_size<=32'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==2))
		packet_size<=cpu_wdata[31:0];	
always @(posedge clk or posedge pRST)
if(pRST)
	start_send<=1'b0;
else
	if((cpu_wr_n==0) && (cpu_addr==3))
		start_send<=cpu_wdata[0];	
		
//***SDRAM**************************************************************************************************************************************************************//	
always @(posedge clk or posedge pRST)
if(pRST)
	sdram_wr<=1'b0;
else
	if((cpu_wr_n==0) && (cpu_addr==4))
		sdram_wr<=cpu_wdata[0];	
always @(posedge clk or posedge pRST)
if(pRST)
	sdram_rd<=1'b0;
else
	if((cpu_wr_n==0) && (cpu_addr==5))
		sdram_rd<=cpu_wdata[0];	
always @(posedge clk or posedge pRST)
if(pRST)
	sdram_wraddr_begin<=16'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==6))
		sdram_wraddr_begin<=cpu_wdata[15:0];	
always @(posedge clk or posedge pRST)
if(pRST)
	sdram_wraddr_end<=16'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==7))
		sdram_wraddr_end<=cpu_wdata[15:0];	
always @(posedge clk or posedge pRST)
if(pRST)
	sdram_rdaddr_begin<=16'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==8))
		sdram_rdaddr_begin<=cpu_wdata[15:0];	
always @(posedge clk or posedge pRST)
if(pRST)
	sdram_rdaddr_end<=16'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==9))
		sdram_rdaddr_end<=cpu_wdata[15:0];
always @(posedge clk or posedge pRST)
if(pRST)
	sdram_pre_clr<=1'b0;
else
	if((cpu_wr_n==0) && (cpu_addr==10))
		sdram_pre_clr<=cpu_wdata[0];	
always @(posedge clk or posedge pRST)
if(pRST)
	sdram_post_clr<=1'b0;
else
	if((cpu_wr_n==0) && (cpu_addr==11))
		sdram_post_clr<=cpu_wdata[0];
always @(posedge clk or posedge pRST)
if(pRST)
	sdram_channel<=8'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==12))
		sdram_channel<=cpu_wdata[7:0];		
//***SDRAM**************************************************************************************************************************************************************//	
//***SOURCE**************************************************************************************************************************************************************//	
always @(posedge clk or posedge pRST)
if(pRST)
	source_channel<=8'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==20))
		source_channel<=cpu_wdata[7 : 0];	

always @(posedge clk or posedge pRST)
if(pRST)
	source_framelen<=16'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==21))
		source_framelen<=cpu_wdata[15 : 0];	
always @(posedge clk or posedge pRST)
if(pRST)
	source_blanklen<=8'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==22))
		source_blanklen<=cpu_wdata[15 : 0];	
		
always @(posedge clk or posedge pRST)
if(pRST)
	source_start_send<=1'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==23))
		source_start_send<=cpu_wdata[0];	
always @(posedge clk or posedge pRST)
if(pRST)
	source_stop_send<=1'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==24))
		source_stop_send<=cpu_wdata[0];	
		
always @(posedge clk or posedge pRST)
if(pRST)
	source_totalnum<=32'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==25))
		source_totalnum<=cpu_wdata[31 : 0];	
always @(posedge clk or posedge pRST)
if(pRST)
	source_cutnum<=32'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==26))
		source_cutnum<=cpu_wdata[31 : 0];	
		
always @(posedge clk or posedge pRST)
if(pRST)
	source_headen<=1'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==27))
		source_headen<=cpu_wdata[0];	
always @(posedge clk or posedge pRST)
if(pRST)
	source_clrfifo<=1'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==28))
		source_clrfifo<=cpu_wdata[0];	
		


//***SOURCE**************************************************************************************************************************************************************//	
	
		
endmodule
