module udp_packet(
	input clk,//----------------系统时钟
	input nRST,//---------------系统复位，0 is active。
	
	input udp_start,//------------------------------开始信号
	
	input [15:0] length,//--------------------------一包数据长度，NIOS设置
	input [31:0] sum_init,//------------------------sum的初始化值，NIOS设置

	input [15:0] data_in,//-------------------------ram data_in
	output reg [10:0] rdaddr,//---------------------ram rdaddr
	
	output reg [15:0] ram_data,//-------------------ram_data
	output reg [10:0] ram_addr,//-------------------ram_addr
	output reg ram_wren,//--------------------------ram_wren
	
	output reg ping_pong,//-------------------------ping_pong信号，为ram_addr的最高位
	output reg udp_busy,//-------------------------------udp打包模块忙信号，1为busy
	
	input mac_busy,
	output reg udp_send//-------------------------MAC开始发送启动信号
	);

//===================================
//寄存器定义
//===================================
reg [7:0] state;
reg [15:0] count;//---------------------------------数据计数器
reg udp_start0,udp_start1,udp_start2;//------------------------udp_start信号缓冲
reg [31:0] sum;//-----------------------------------UDP校验和

//=====================================================================================
//=====================================================================================
//	参数的设置以及状态机的状态值
//=====================================================================================	
parameter   idle = 8'd0,wait_send = 8'd1,wait_send_1 = 8'd7,start_send = 8'd2,
			wait_end = 8'd3,wait_end_2 = 8'd4,write_sum = 8'd5,send_end = 8'd6,send_wait = 8'd8;
//=====================================================================================	
always @(posedge clk)
begin
	udp_start0 <= udp_start;
	udp_start1 <= udp_start0;
	udp_start2 <= udp_start1;
end	
//=====================================================================================
//	系统状态机
//=====================================================================================	
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			rdaddr <= 11'd0;
			ram_data <= 16'd0;
			ram_addr <= 11'd0;
			ram_wren <= 1'b0;
			ping_pong <= 1'b0;
			udp_busy <= 1'b0;
			udp_send <= 1'b0;
			count <= 16'd0;
			sum <= 32'd0;
			state <= idle;
		end	
	else
		case(state)
		idle:
			begin
				rdaddr <= {ping_pong,10'd0};
				ram_addr <= {ping_pong,10'd21};//----从第42个字节的位置开始写入数据
				ram_data <= 16'd0;
				ram_wren <= 1'b0;
				udp_busy <= 1'b0;
				udp_send <= 1'b0;
				count <= 16'd0;
				sum <= sum_init;
				if(udp_start1 & !udp_start2)
					state <= wait_send;
			end	
		wait_send:
			begin
				udp_busy <= 1'b1;
				rdaddr <= rdaddr + 1'b1;
				state <= wait_send_1;
			end	
		wait_send_1:
			begin
				udp_busy <= 1'b1;
				ram_data <= data_in;
				ram_wren <= 1'b1;
				sum <= sum + data_in;
				rdaddr <= rdaddr + 1'b1;
				count <= count + 1'b1;
				state <= start_send;
			end	
		start_send://--------------------------------------------------------从FIFO中读取length长度的数据，写入RAM_POST中
			begin
				rdaddr <= rdaddr + 1'b1;
				ram_addr <= ram_addr + 1'b1;
				ram_data <= data_in;
				ram_wren <= 1'b1;
				sum <= sum + data_in;
				if(count == length-1)
					begin
						count <= 16'd0;
						state <= wait_end;
					end	
				else	
					count <= count + 1'b1;
			end
		wait_end:
			begin
				ram_data <= 16'd0;
				ram_wren <= 1'b0;
				ping_pong <= ~ping_pong;//----ping_pong翻转
				sum <= {16'd0,sum[31:16]} + {16'd0,sum[15:0]};
				state <= wait_end_2;
			end
		wait_end_2:
			begin
				sum <= {16'd0,sum[31:16]} + {16'd0,sum[15:0]};
				state <= write_sum;
			end	
		write_sum:
			begin
				ram_addr <= {~ping_pong,10'd20};//----从第40个字节的位置开始写入数据
				ram_data <= ~sum[15:0];
				ram_wren <= 1'b1;
				state <= send_end;
			end		
		send_end:
			begin
				ram_data <= 16'd0;
				ram_wren <= 1'b0;
				udp_send <= 1'b1;
				if(count == 16'd10)
				begin
					count <= 16'd0;
					state <= send_wait;
				end	
				else
					count <= count + 1'b1;
			end	
		send_wait:
			begin
				if(mac_busy == 1'b0)
					state <= idle;
			end	
		default:
				state <= idle;
		endcase	
end		
//=====================================================================================		
endmodule
