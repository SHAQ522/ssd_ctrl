module udp_predo(
	input clk,//----------------系统时钟
	input nRST,//---------------系统复位，0 is active。
	
	input begin_work,//-----------------------------开始信号，NIOS设置
	input [15:0] length,//--------------------------一包数据长度，NIOS设置

	input udp_busy,//-------------------------------udp打包模块忙信号，1为busy
	
	input [15:0] data_in,//-------------------------fifo_data
	input [12:0] fifo_usedw,//----------------------fifo_rdusedw，多于一包数据时启动发送数据	
	output reg fifo_rden,//-------------------------fifo_rden
	
	output [15:0] ram_data,//-------------------ram_data
	output reg [10:0] ram_addr,//-------------------ram_addr
	output reg ram_wren,//--------------------------ram_wren
	
	output reg ping_pong,//-------------------------ping_pong信号，为ram_addr的最高位
	
	output reg udp_start,//-------------------------udp打包模块启动信号
	
	output reg err//--------------------------------错误输出，当udp_busy为高时ping_pong翻转，则置高电平
	);

//===================================
//寄存器定义
//===================================
reg [7:0] state;
reg [15:0] count;//---------------------------------数据计数器
reg begin_reg0,begin_reg1;//------------------------begin_work信号缓冲
reg busy_reg0,busy_reg1;//--------------------------udp_busy信号缓冲
reg ping_pong0,ping_pong1;//------------------------ping_pong信号缓冲

assign ram_data = data_in;
//=====================================================================================
//=====================================================================================
//	参数的设置以及状态机的状态值
//=====================================================================================	
parameter   idle = 8'd0,wait_send = 8'd1,start_send = 8'd2,
			wait_end = 8'd3,send_end = 8'd4,wait_busy = 8'd5;
//=====================================================================================	
always @(posedge clk)
begin
	begin_reg0 <= begin_work;
	begin_reg1 <= begin_reg0;
end	

always @(posedge clk)
begin
	busy_reg0 <= udp_busy;
	busy_reg1 <= busy_reg0;
end	
//=====================================================================================
//	系统状态机
//=====================================================================================	
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			fifo_rden <= 1'b0;
			ram_addr <= 11'd0;
			ram_wren <= 1'b0;
			ping_pong <= 1'b0;
			udp_start <= 1'b0;
			count <= 16'd0;
			state <= idle;
		end	
	else
		case(state)
		idle:
			begin
				fifo_rden <= 1'b0;
				ram_addr <= {ping_pong,10'd0};
				ram_wren <= 1'b0;
				udp_start <= 1'b0;
				count <= 16'd0;
				if(begin_reg1)
					state <= wait_send;
			end	
		wait_send://---------------------------------------------------------当FIFO中的数fifo_usedw多于length时开始发送
			begin
				if(fifo_usedw >= length)
					begin
						fifo_rden <= 1'b1;
						ram_wren <= 1'b1;
						count <= count + 1'b1;
						state <= start_send;
					end	
				else
					state <= wait_send;
			end	
		start_send://--------------------------------------------------------从FIFO中读取length长度的数据，写入RAM_PRE中
			begin
				fifo_rden <= 1'b1;
				ram_wren <= 1'b1;
				ram_addr <= ram_addr + 1'b1;
				if(count < length-1)
					count <= count + 1'b1;
				else	
					begin
						count <= 16'd0;
						state <= wait_end;
					end	
			end
		wait_end:
			begin
				fifo_rden <= 1'b0;
				ram_wren <= 1'b0;
				ping_pong <= ~ping_pong;//----ping_pong翻转
				state <= wait_busy;
			end
		wait_busy:
			begin
				if(busy_reg1 == 1'b0)
					state <= send_end;
			end
		send_end:
			begin
				udp_start <= 1'b1;
				if(count < 16'd10)
					count <= count + 1'b1;
				else
					state <= idle;
			end	
		default:
				state <= idle;
		endcase	
end		
//=====================================================================================	
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		err <= 1'b0;
	else
		begin
			ping_pong0 <= ping_pong;
			ping_pong1 <= ping_pong0;
			if((ping_pong0 != ping_pong1) & (busy_reg1 == 1'b1))
				err <= 1'b1;
		end		
end	


endmodule
