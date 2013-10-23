module udp_data_issue(
	input clk,//----------------系统时钟
	input nRST,//---------------系统复位，0 is active。
	
	input pingpong,
	
	input [31:0] ram_data,//-------------------ram_data
	output reg [9:0] ram_addr,//---------------ram_addr
	
	output reg[31:0]data_out,
	output reg data_en,
	output reg command_en,
	output reg ram_en,
	
	output reg err//--------------------------------错误输出，当udp_busy为高时ping_pong翻转，则置高电平
	);

//===================================
//寄存器定义
//===================================
reg [7:0] state;
reg [15:0] count;//-------------------------------数据计数器
reg pingpong0,pingpong1;//------------------------ping_pong信号缓冲
reg en_start;
reg [7:0] udp_flag;

//=====================================================================================
//=====================================================================================
//	参数的设置以及状态机的状态值
//=====================================================================================	
parameter   idle = 8'd0,wait_send = 8'd1,start_send = 8'd2,
			wait_end = 8'd3,send_end = 8'd4,delay1=8'd5,delay2=8'd6;
//=====================================================================================	
always @(posedge clk)
begin
	pingpong0 <= pingpong;
	pingpong1 <= pingpong0;
end	

always @(posedge clk)
begin
	data_out <= {ram_data[15:0],ram_data[31:16]};
end	

always @(posedge clk)
begin
	if((pingpong0 != pingpong1) && (state != idle))
		err <= ~err;
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
			en_start <= 1'b0;
			state <= idle;
		end	
	else
		case(state)
		idle:
			begin
				en_start <= 1'b0;
				if(pingpong0 != pingpong1)
				begin
					state <= delay1;
					ram_addr[8:0] <= 9'd11;
				end	
			end	
		delay1:state <= delay2;
		delay2:state <= wait_send;
		wait_send:
			begin		
				if(ram_data == 32'h3a87c5d7)
				begin
					en_start <= 1'b1;
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
				en_start <= 1'b1;
				if(ram_addr[8:0] == 9'h10f)
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
	if(en_start & (ram_addr[8:0] == 9'h00e) & (ram_data[31:24] == 8'h01))
		udp_flag <= 8'd0;//---命令
	else if(en_start & (ram_addr[8:0] == 9'h00e) & (ram_data[31:24] == 8'h02))
		udp_flag <= 8'd1;//---数据
	else if(en_start & (ram_addr[8:0] == 9'h00e) & (ram_data[31:24] == 8'h04))
		udp_flag <= 8'd2;//---RAM数据	
	else
		udp_flag <= udp_flag;
end

always @(posedge clk)
begin
	if((udp_flag == 8'd0) & (ram_addr[8:0] == 9'h00f))
		command_en <= 1'b1;
	else if((udp_flag == 8'd0) & (ram_addr[8:0] == 9'h02f))
		command_en <= 1'b0;
	else
		command_en <= command_en;
end

always @(posedge clk)
begin
	if((udp_flag == 8'd1) & (ram_addr[8:0] == 9'h00f))
		data_en <= 1'b1;
	else if((udp_flag == 8'd1) & (ram_addr[8:0] == 9'h10f))
		data_en <= 1'b0;
	else
		data_en <= data_en;
end

always @(posedge clk)
begin
	if((udp_flag == 8'd2) & (ram_addr[8:0] == 9'h00f))
		ram_en <= 1'b1;
	else if((udp_flag == 8'd2) & (ram_addr[8:0] == 9'h10f))
		ram_en <= 1'b0;
	else
		ram_en <= ram_en;
end

//=====================================================================================	
//=====================================================================================	

endmodule
