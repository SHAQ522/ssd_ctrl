module load_data_generator(
	input clk,
	input nRST,
	input fifo_ready,

	input [31:0] packet_head,
	input [15:0] flag_set,
	input [23:0] length_set,
	input scramble,	
	
	input [15:0] scr_in,//--------------------------加扰结果
	output reg scr_rst,
	output reg scr_en,
	output reg [15:0] scr_out,
	
	input [15:0] crc_in,//--------------------------CRC校验结果
	output reg crc_init,
	output reg crc_en,
	output reg [15:0] crc_out,
	
	output reg [15:0] data_out,//-------------------数据输出
	output reg data_en//----------------------------数据使能输出
	);

//===================================
//寄存器定义
//===================================
reg [15:0] data_out_reg;
reg data_en_reg;
reg data_en_reg0;
reg  [7:0]  state;
reg  [31:0] count;//---------------------------------包内有效数据计数,4个字节
reg  [23:0] packet_count;//--------------------------包计数,23bit
wire [31:0] count_num;//-----------------------------包内有效数据计数最大值,4个字节，为pos_length-8
reg  [15:0] crc_reg;//-------------------------------CRC校验结果寄存器
reg  [7:0]  crc_wait_time;
reg  fifo_ready_reg0;

assign 	count_num = length_set-32'd14;
//=====================================================================================
//=====================================================================================
//	参数的设置以及状态机的状态值
//=====================================================================================	
parameter   idle = 8'd0,start_send = 8'd1,
			send_head_0 = 8'd2,send_head_1 = 8'd3,
			send_count_1 = 8'd6,
			send_count_2 = 8'd7,
			send_length_1 = 8'd20,
			send_length_2 = 8'd21,
			send_data = 8'd13,
			send_crc_0 = 8'd14,send_crc_1 = 8'd15,crc_wait = 8'd23,
			state_back = 8'd19;
//=====================================================================================	
always @(posedge clk)
begin
	fifo_ready_reg0 <= fifo_ready;
end	
//=====================================================================================
//	系统状态机
//=====================================================================================	
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			data_out_reg <= 16'd0;
			data_en_reg <= 1'b0;
			scr_out <= 16'd0;
			scr_en <= 1'b0;
			count <= 32'd0;
			packet_count <= 24'd0;		
			scr_rst <= 1'b1;
			crc_init <= 1'b1;
			crc_wait_time <= 8'd0; 
			
			state <= idle;
		end	
	else
		case(state)
		idle:
			begin
			data_out_reg <= 16'd0;
			data_en_reg <= 1'b0;
			scr_out <= 16'd0;
			scr_en <= 1'b0;
			count <= 32'd0;
			packet_count <= 24'd0;
			scr_rst <= 1'b1;
			crc_init <= 1'b1;
			crc_wait_time <= 8'd0; 
			state <= start_send;
			end	
		start_send://-------------------------------------------------------循环发送
			begin
				count <= 32'd0;
				scr_rst <= 1'b0;
				crc_init <= 1'b0;
				crc_wait_time <= 8'd0; 
				state <= send_head_0;
			end
		send_head_0://---------------------------------------------发送包头，4个字节，5716EB90，分2个时钟周期发送
			begin
				data_out_reg <= packet_head[31:16];
				data_en_reg <= 1'b1;
				scr_out <= packet_head[31:16];
				scr_en <= 1'b1;
				state <= send_head_1;
			end
		send_head_1:
			begin
				data_out_reg <= packet_head[15:0];
				data_en_reg <= 1'b1;
				scr_out <= packet_head[15:0];
				scr_en <= 1'b1;
				state <= send_count_1;
			end	
		send_count_1://--------------------------------------------发送计数器高16bit
			begin
				data_out_reg <= packet_count[23:8];
				data_en_reg <= 1'b1;
				scr_out <= packet_count[23:8];
				scr_en <= 1'b1;
				state <= send_count_2;
			end	
		send_count_2://--------------------------------------------发送计数器低8bit+载荷标识高8bit
			begin
				data_out_reg <= {packet_count[7:0],flag_set[15:8]};
				data_en_reg <= 1'b1;
				scr_out <= {packet_count[7:0],flag_set[15:8]};
				scr_en <= 1'b1;
				packet_count <= packet_count + 1'b1;
				state <= send_length_1;
			end		
		send_length_1://--------------------------------------------发送载荷标识低8bit+包长高8bit
			begin
				data_out_reg <= {flag_set[7:0],length_set[23:16]};
				data_en_reg <= 1'b1;
				scr_out <= {flag_set[7:0],length_set[23:16]};
				scr_en <= 1'b1;
				state <= send_length_2;
			end	
		send_length_2://--------------------------------------------包长低16bit//发送计数器+0xff，2个字节
			begin
				data_out_reg <= length_set[15:0];
				data_en_reg <= 1'b1;
				scr_out <= length_set[15:0];
				scr_en <= 1'b1;
				state <= send_data;
			end	
		send_data://---------------------------------------------------------发送数据，从00至FF循环发送，发送字节数为count_num=pos_length-32'd8
			begin
				if((fifo_ready_reg0) & (count<count_num))
					begin
						count <= count + 8'd2;
						data_out_reg[15:8] <= count[7:0];
						data_out_reg[7:0] <= count[7:0] + 8'd1;
						data_en_reg <= 1'b1;
						scr_out[15:8] <= count[7:0];
						scr_out[7:0] <= count[7:0] + 8'd1;
						scr_en <= 1'b1;
						state <= send_data;
					end
				else
					if(fifo_ready_reg0)
					begin
						count <= 32'd0;
						data_out_reg <= 16'd0;
						data_en_reg <= 1'b0;
						scr_out <= 16'd0;
						scr_en <= 1'b0;
						state <= crc_wait;
					end
				else	
					begin
						data_out_reg <= 16'd0;
						data_en_reg <= 1'b0;
						scr_out <= 16'd0;
						scr_en <= 1'b0;
						state <= send_data;
					end
			end	
		crc_wait://------------------------------------------------------------等待CRC校验，10个时钟周期
			begin
				crc_wait_time <= crc_wait_time + 1'b1; 
				if(crc_wait_time==8'd10)
					state <= send_crc_0;
				else
					state <= crc_wait;
			end		
		send_crc_0://----------------------------------------------------------发送CRC校验结果，4个字节，分4个时钟周期发送
			begin
				crc_reg <= crc_in;
				crc_wait_time <= 8'd0;
				state <= send_crc_1;
			end	
		send_crc_1:
			begin
			//	data_out_reg <= crc_reg;
			//	data_en_reg <= 1'b1;
				state <= state_back;
			end		
		state_back://-----------------------------------------------------------该包发送结束，返回发送下一包数据
			begin
				data_out_reg <= 16'd0;
				data_en_reg <= 1'b0;
				scr_rst <= 1'b1;//---------------------------加扰复位
				crc_init <= 1'b1;//--------------------------CRC复位
				state <= start_send;
			end	
		default:
				state <= idle;
		endcase	
end		
//=====================================================================================	
//=====================================================================================
//	加扰
//=====================================================================================	
always @(posedge clk)
begin
	data_en_reg0 <= data_en_reg;
	if(state == send_crc_1)
	begin
		data_out <= crc_reg;
		data_en <= 1'b1;
	end
	else if(!scramble)
		begin
		data_out <= data_out_reg;
		data_en <= data_en_reg;
		end
	else
		begin
		data_out <= scr_in;
		data_en <= data_en_reg0;
		end
end	
//=====================================================================================
//	CRC校验
//=====================================================================================	
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			crc_en <= 1'b0;
			crc_out <= 16'd0;
		end		
	else
		if(crc_init)
		begin
			crc_en <= 1'b0;
			crc_out <= 16'd0;
		end
	else
		begin
			crc_en <= data_en;
			crc_out <= data_out;
		end	
end
	
	
endmodule
