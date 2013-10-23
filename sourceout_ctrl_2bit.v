module sourceout_ctrl_2bit(
	input clk,//----------------系统时钟
	input nRST,//---------------系统复位，0 is active。
	
	input [31:0] data_length,//-----------------------正程长度，4个字节
	input [31:0] blank_length,//----------------------逆程长度，4个字节	
	
	input [14:0] fifo_usedw,//----------------------fifo_rdusedw，多于3000时启动发送数据
	
	output reg data_en//----------------------------数据使能输出
	);

//===================================
//寄存器定义
//===================================
reg [2:0] state;
reg [31:0] pos_num;//-------------------------------正程发送数据长度,6个字节
reg [31:0] neg_num;//-------------------------------逆程发送数据长度,6个字节
reg [31:0] count;//---------------------------------包内有效数据计数,6个字节
reg [14:0] fifo_usedw_reg;
//=====================================================================================
//=====================================================================================
//	参数的设置以及状态机的状态值
//=====================================================================================	
parameter   idle = 3'd0,wait_send = 3'd1,start_send = 3'd2,
			send_pos = 3'd3,send_neg = 3'd4;
//=====================================================================================	

//=====================================================================================
//	系统状态机
//=====================================================================================	
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			data_en <= 1'b0;
			count <= 32'd0;
			pos_num <= {data_length[29:0],2'd0};
			neg_num <= {blank_length[29:0],2'd0};
			fifo_usedw_reg <= 15'd0;
			state <= idle;
		end	
	else
		case(state)
		idle:
			begin
			data_en <= 1'b0;
			count <= 32'd0;
			pos_num <= {data_length[29:0],2'd0};
			neg_num <= {blank_length[29:0],2'd0};
			fifo_usedw_reg <= 15'd0;
			state <= wait_send;
			end	
		wait_send://---------------------------------------------------------当FIFO_POST中的数fifo_usedw多于2000时开始发送，源源不断
			begin
				data_en <= 1'b0;
				count <= 32'd0;
				fifo_usedw_reg <= fifo_usedw;
				if(fifo_usedw_reg > 15'd5000)
					state <= start_send;
				else
					state <= wait_send;
			end	
		start_send:
			begin
				data_en <= 1'b0;
				count <= 32'd0;
				state <= send_pos;
			end	
		send_pos://---------------------------------------------------------发送正程数据，个数为pos_num，从FIFO中读出
			begin
				data_en <= 1'b1;
				if(count < pos_num-1)
					count <= count + 1'b1;
				else	
					begin
					count <= 32'd0;
					if(neg_num == 32'd0)//-----------------------------------neg_length = 0
						state <= send_pos;	
					else
						state <= send_neg;
					end	
			end
		send_neg://----------------------------------------------------------发送逆程数据，个数为neg_num，发送0
			begin
				data_en <= 1'b0;
				if(count < neg_num-1)
					count <= count + 1'b1;
				else	
				begin
					count <= 32'd0;
					state <= send_pos;
				end	
			end		
		default:
				state <= idle;
		endcase	
end		
	
endmodule
