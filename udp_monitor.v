module udp_monitor(
	input clk,//----------------系统时钟
	input nRST,//---------------系统复位，0 is active。
	
	input begin_work,//-----------------------------开始信号，NIOS设置
	input [7:0] flag,//-----------------------------00：无 01：下一帧 02：重发本帧 
	input [15:0] frame_step,
	input [15:0] frame_addr_now,
	input [15:0] frame_addr_begin,
	input [15:0] frame_addr_end,
	
	input busy,
	
	output reg	sdram_wr,
	output reg	sdram_rd,
	output reg[15:0]	wraddr_begin,			//写开始地址
	output reg[15:0]	wraddr_end,			    //写结束地址
	output reg[15:0]	rdaddr_begin,			//写开始地址
	output reg[15:0]	rdaddr_end,			    //写结束地址
	input sdram_wr_done,
	
	output reg packet_start,//----------------------上升沿开始打包发送8MB数据
	output reg [31:0] cnt_init,//-------------------8M起始计数值
	
	output reg[15:0]	frame_length,	
	output reg err
	);

//===================================
//寄存器定义
//===================================
reg [7:0] state;
reg [15:0] count;
reg begin_reg0,begin_reg1;//---------------------begin_work信号缓冲
reg [7:0]flag0,flag1;//--------------------------flag信号缓冲
reg sdram_wr_done0,sdram_wr_done1;
//=====================================================================================	
always @(posedge clk)
begin
	begin_reg0 <= begin_work;
	begin_reg1 <= begin_reg0;
end	

always @(posedge clk)
begin
	flag0 <= flag;
	flag1 <= flag0;
end	

always @(posedge clk)
begin
	sdram_wr_done0 <= sdram_wr_done;
	sdram_wr_done1 <= sdram_wr_done0;
end	
//=====================================================================================
//	系统状态机
//=====================================================================================	
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			packet_start <= 1'b0;
			cnt_init <=32'd0;
			sdram_wr <= 1'b0;
			sdram_rd <= 1'b0;
			count <= 16'd0;
			wraddr_begin <= 16'd0;
			wraddr_end <= 16'd0;
			rdaddr_begin <= 16'd0;
			rdaddr_end <= 16'd0;
			frame_length <= 16'd0;
			state <= 8'd0;
		end	
	else
		case(state)
		8'd0:
			begin
				packet_start <= 1'b0;
				sdram_wr <= 1'b0;
				sdram_rd <= 1'b0;
				count <= 16'd0;
				wraddr_begin <= 16'd0;
				wraddr_end <= 16'd0;
				rdaddr_begin <= 16'd0;
				rdaddr_end <= 16'd0;
				frame_length <= 16'd0;
				frame_length <= 16'd0;
				if(begin_reg1)
					state <= 8'd1;
			end	
		8'd1:
			begin
				if((flag0 != flag1) && (flag0 == 8'h01) && (!busy))
					begin
						cnt_init <= 32'd0;
						wraddr_begin <= 16'd0;
						wraddr_end <= {2'b00,frame_step[15:2]};
						rdaddr_begin <= 16'd0;
						rdaddr_end <= {2'b00,frame_step[15:2]};
						frame_length <= frame_step;
						state <= 8'd2;//------------------下一帧
					end	
				else if((flag0 != flag1) && (flag0 == 8'h02) && (!busy))
					begin
						cnt_init <= 32'd0;
						rdaddr_begin <= 16'd0;
						rdaddr_end <= {2'b00,frame_step[15:2]};
						frame_length <= frame_step;
						state <= 8'd4;//------------------重发全部帧
					end	
				else if((flag0 != flag1) && (flag0 == 8'h03) && (!busy))
					begin
						cnt_init <= frame_addr_now;
						rdaddr_begin <= {2'b00,frame_addr_now[15:2]};
						rdaddr_end <= {2'b00,frame_addr_now[15:2]} + 1'b1;
						frame_length <= 16'd4;
						state <= 8'd4;//------------------重发一帧
					end	
				else if((flag0 != flag1) && (flag0 == 8'h05) && (!busy))
					begin
						cnt_init <= {2'b00,frame_addr_begin[15:2]};
						rdaddr_begin <= {2'b00,frame_addr_begin[15:2]};
						rdaddr_end <= {2'b00,frame_addr_end[15:2]};
						frame_length <= frame_addr_end - frame_addr_begin;
						state <= 8'd4;//------------------重发连续帧
					end	
				else
					state <= 8'd1;
			end	
//----------------------------------------------------------------------------------------------------------------------//			
		8'd2:
			begin
				sdram_wr <= 1'b1;
				count <= 16'd0;
				if(sdram_wr_done1)
					state <= 8'd3;
				else	
					state <= 8'd2;
			end
		8'd3:
			begin
				sdram_wr <= 1'b0;
				if(count == 16'd10)
				begin
					count <= 16'd0;
					state <= 8'd4;
				end	
					count <= count + 1'b1;	
			end
//----------------------------------------------------------------------------------------------------------------------//			
		8'd4:
			begin
				sdram_rd <= 1'b1;
				packet_start <= 1'b1;
				state <= 8'd5;
			end
		8'd5:
			begin
				if(count == 16'd10)
				begin
					count <= 16'd0;
					state <= 8'd0;
				end	
					count <= count + 1'b1;	
			end	
//----------------------------------------------------------------------------------------------------------------------//			
		default:
				state <= 8'd0;
		endcase	
end		
//=====================================================================================	
always @(posedge clk)
begin
	if((flag0 != flag1) && (busy))
		err <= ~err;
end	
endmodule
