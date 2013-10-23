module data_format(
	input clk,//----------------系统时钟
	input nRST,//---------------系统复位，0 is active
	
	input	sdram_rd,							//sdram读开始

	input	[31:0]	frame_length,				//一帧图像大小
	input	[31:0]	sdram_length,			   	//SDRAM数据大小
	input	[14:0]	fifo_num_pre,
	input	fifo_post_ready,	
	
	output	reg fifo_rden,                      //前置fifo读使能
	output	reg fifo_wren                       //后置fifo写使能
	);

//===================================
//寄存器定义
//===================================
reg [7:0] state;
reg [31:0] count;//--------------------------------计数器
reg sdram_rd0,sdram_rd1;
reg fifo_empty_pre;
reg fifo_ready;

always @(posedge clk)
begin
	sdram_rd0 <= sdram_rd;
	sdram_rd1 <= sdram_rd0;
end	

always @(posedge clk)
begin
	if(fifo_num_pre > 15'd10)
		fifo_empty_pre <= 1'b1;
	else
		fifo_empty_pre <= 1'b0;
end	

always @(posedge clk)
begin
	fifo_ready <= fifo_empty_pre & fifo_post_ready;
end	

/*********************主程序*******************************/
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			fifo_rden <= 1'b0;
			fifo_wren <= 1'b0;
			count <= 32'd0;
			state <= 8'd0;
		end	
	else
		case(state)
		8'd0:
			begin
				fifo_rden <= 1'b0;
				fifo_wren <= 1'b0;
				count <= 32'd0;
				if(sdram_rd1)
					state <= 8'd1;
				else
					state <= 8'd0;
			end	
		8'd1:
			begin
				if(fifo_ready)
				begin
					if(count < frame_length)
					begin
						fifo_rden <= 1'b1;
						fifo_wren <= 1'b1;
						count <= count + 1'b1;
						state <= 8'd1;
					end
					else
					begin
						fifo_rden <= 1'b0;
						fifo_wren <= 1'b0;
						state <= 8'd2;
					end
				end
				else
				begin
					fifo_rden <= 1'b0;
					fifo_wren <= 1'b0;
					state <= 8'd1;
				end	
			end	
		8'd2:
			begin
				if(fifo_empty_pre)
				begin
					if(count < sdram_length)
					begin
						fifo_rden <= 1'b1;
						fifo_wren <= 1'b0;
						count <= count + 1'b1;
						state <= 8'd2;
					end
					else
					begin
						fifo_rden <= 1'b0;
						fifo_wren <= 1'b0;
						state <= 8'd3;
					end
				end
				else
				begin
					fifo_rden <= 1'b0;
					fifo_wren <= 1'b0;
					state <= 8'd2;
				end		
			end		
		8'd3:
			begin
				fifo_rden <= 1'b0;
				fifo_wren <= 1'b0;
				count <= 32'd0;
				if(sdram_rd1)
					state <= 8'd1;
				else
					state <= 8'd0;	
			end	
		default:
				state <= 8'd0;
		endcase	
end
/*********************主程序结束*******************************/

endmodule
