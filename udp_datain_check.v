module udp_datain_check(
	input clk,//----------------系统时钟
	input nRST,//---------------系统复位，0 is active。
	
	input pingpong,
	
	input [31:0] ram_data,//-------------------ram_data
	output reg [9:0] ram_addr,//---------------ram_addr
	
	output reg [15:0]err_count0,
	output reg [15:0]err_count1,
	
	output reg err//--------------------------------错误输出，当udp_busy为高时ping_pong翻转，则置高电平
	);

//===================================
//寄存器定义
//===================================
reg [7:0] state;
reg [15:0] count;//---------------------------------数据计数器
reg pingpong0,pingpong1;//------------------------ping_pong信号缓冲
reg [31:0] data_reg0,data_reg1;
reg [31:0] count_reg0,count_reg1;
reg err_start;

//=====================================================================================
//=====================================================================================
//	参数的设置以及状态机的状态值
//=====================================================================================	
parameter   idle = 8'd0,wait_send = 8'd1,start_send = 8'd2,
			wait_end = 8'd3,send_end = 8'd4;
//=====================================================================================	
always @(posedge clk)
begin
	pingpong0 <= pingpong;
	pingpong1 <= pingpong0;
end	

always @(posedge clk)
begin
	data_reg0 <= ram_data;
	data_reg1 <= data_reg0;
end	

//=====================================================================================
//	系统状态机
//=====================================================================================	
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			ram_addr <= 10'd0;
			count <= 16'd0;
			err_start <= 1'b0;
			state <= idle;
		end	
	else
		case(state)
		idle:
			begin
				err_start <= 1'b0;
				if(pingpong0 != pingpong1)
				begin
					state <= wait_send;
					ram_addr[8:0] <= 9'd11;
				end	
			end	
		wait_send:
			begin		
				if(ram_data == 32'h3a87c5d6)
				begin
					err_start <= 1'b1;
					state <= start_send;
				end	
				else
				begin
					ram_addr[9] <= ~ram_addr[9];
					state <= idle;
				end	
			end	
		start_send://--------------------------------------------------------从FIFO中读取length长度的数据，写入RAM_PRE中
			begin
				err_start <= 1'b1;
				if(ram_addr[8:0] == 9'd250)
				begin	
					ram_addr[9] <= ~ram_addr[9];
					ram_addr[8:0] <= 9'd11;
					state <= idle;
				end	
				else	
					ram_addr[8:0] <= ram_addr[8:0] + 1'b1;
			end
		default:
				state <= idle;
		endcase	
end		
//=====================================================================================	
always @(posedge clk)
begin
	if(ram_addr[8:0] == 9'd13)
	begin
		count_reg0 <= ram_data;
		count_reg1 <= count_reg0;
	end	
end

always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		err_count0 <= 16'd0;
	else if((ram_addr[8:0] == 9'd20) & (count_reg0 != count_reg1 + 1'b1) & (count_reg0 != 32'd0) & (count_reg1 != 32'd0))
		err_count0 <= err_count0 + 1'b1;
	else 
		err_count0 <= err_count0;
		
end	
//=====================================================================================	
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		err_count1 <= 16'd0;
	else if((ram_addr[8:0] >= 9'd16) & (data_reg0 != data_reg1 + 32'h04040404) & (data_reg0 != 32'h00010203) & (err_start == 1'b1))
		err_count1 <= err_count1 + 1'b1;
	else 
		err_count1 <= err_count1;
		
end	
//=====================================================================================	
//=====================================================================================	

endmodule
