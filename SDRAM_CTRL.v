module SDRAM_CTRL(
	input clk,//----------------系统时钟
	input nRST,//---------------系统复位，0 is active。
/**********************系统控制信号**************************************/
	input	sdram_wr,
	input	sdram_rd,
	input	[15:0]	wraddr_begin_in,			//写开始地址
	input	[15:0]	wraddr_end_in,			    //写结束地址
	input	[15:0]	rdaddr_begin_in,			//写开始地址
	input	[15:0]	rdaddr_end_in,			    //写结束地址
	output	reg sdram_wr_done,	
/**********************SDRAM的地址控制信号**************************************/	
	output	reg PingPong,			            //乒乓操作的标志信号 1为写 0为读		
	output	reg	start_wr,						//开始写
	output	[15:0]	wraddr_begin,				//写开始地址
	output	[15:0]	wraddr_end,			   	    //写结束地址
	output	reg	start_rd,						//开始读
	output	[15:0]	rdaddr_begin,				//读开始地址
	output	[15:0]	rdaddr_end,			   	    //读结束地址
	input	flag_wr,
	input	flag_rd,
	output	reg	clr,						    //FIFO清零
	
	output reg err//------------------------------错误输出
	);

//===================================
//寄存器定义
//===================================
reg [7:0] state;
reg [15:0] count;//--------------------------------计数器
reg sdram_wr0,sdram_wr1;
reg sdram_rd0,sdram_rd1;
reg flag_wr0,flag_wr1;
reg flag_rd0,flag_rd1;

assign wraddr_begin = wraddr_begin_in;
assign wraddr_end =   wraddr_end_in;
assign rdaddr_begin = rdaddr_begin_in;
assign rdaddr_end =   rdaddr_end_in;

always @(posedge clk)
begin
	sdram_wr0 <= sdram_wr;
	sdram_wr1 <= sdram_wr0;
	sdram_rd0 <= sdram_rd;
	sdram_rd1 <= sdram_rd0;
	flag_wr0 <= flag_wr;
	flag_wr1 <= flag_wr0;
	flag_rd0 <= flag_rd;
	flag_rd1 <= flag_rd0;
end	

/*********************主程序*******************************/
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			PingPong <= 1'b1;
			start_wr <= 1'b0;
			start_rd <= 1'b0;
			sdram_wr_done <= 1'b0;
			clr <= 1'b1;
			state <= 8'd0;
		end	
	else
		case(state)
		8'd0:
			begin
				PingPong <= 1'b1;
				start_wr <= 1'b0;
				start_rd <= 1'b0;
				sdram_wr_done <= 1'b0;
				clr <= 1'b1;
				if(sdram_wr1 & !sdram_rd1)
					state <= 8'd1;
				else if(!sdram_wr1 & sdram_rd1)
					state <= 8'd7;
				else
					state <= 8'd0;
			end	
		8'd1:
			begin
				sdram_wr_done <= 1'b0; 
				clr <= 1'b0;
				state <= 8'd2;
			end	
		8'd2:
			begin
				PingPong <= 1'b1;
				start_wr <= 1'b1;
				start_rd <= 1'b0;	
				state <= 8'd3;	
			end		
		8'd3:
			begin
				if(flag_wr1)
					state <= 8'd4;
				else
					state <= 8'd3;		
			end	
		8'd4:
			begin
				if(!flag_wr1)
					state <= 8'd5;
				else
					state <= 8'd4;
			end	
		8'd5:
			begin
				start_wr <= 1'b0;
				clr <= 1'b1;
				state <= 8'd6;
			end	
		8'd6:
			begin
				sdram_wr_done <= 1'b1;
				if(!sdram_wr1)
					state <= 8'd0;
				else
					state <= 8'd6;
			end		
		8'd7:
			begin
				PingPong <= 1'b0;
				start_rd <= 1'b1;
				state <= 8'd8;
			end	
		8'd8:
			begin
				if(flag_rd1)
					state <= 8'd9;
				else
					state <= 8'd8;
			end	
		8'd9:
			begin
				start_rd <= 1'b0;
				if(!flag_rd1)
					state <= 8'd10;
				else
					state <= 8'd9;
			end	
		8'd10:
			begin
				start_rd <= 1'b0;
				if(!sdram_rd1)
					state <= 8'd0;
				else
					state <= 8'd7;
			end		
		default:
				state <= 8'd0;
		endcase	
end
/*********************主程序结束*******************************/

endmodule
