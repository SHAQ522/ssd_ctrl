module udp_ctrl(
	input clk,//----------------系统时钟
	input nRST,//---------------系统复位，0 is active。
	
	input begin_work,//-----------------------------开始信号，NIOS设置
	input [15:0] length,//--------------------------一包数据长度，NIOS设置
	
	input packet_start,//---------------------------上升沿开始打包发送8MB数据
	input [31:0] cnt_init,//------------------------8M起始计数值
	
	input [13:0] rd_usedw,
	input [12:0] wr_usedw,	
	
	input [15:0] data_in,
	output reg rden,
	
    input [15:0] frame_length,
	
	output reg[15:0] data_out,
	output reg wren,
	
	output reg busy
	);

//===================================
//寄存器定义
//===================================
reg [7:0] state;
reg [15:0] countp;
reg [31:0] count;
reg [31:0] cnt;
reg begin_reg0,begin_reg1;//------------------------begin_work信号缓冲
reg packet_start0,packet_start1;//------------------packet_start信号缓冲
reg fifo_ready;
//=====================================================================================
//=====================================================================================	
always @(posedge clk)
begin
	begin_reg0 <= begin_work;
	begin_reg1 <= begin_reg0;
end	

always @(posedge clk)
begin
	packet_start0 <= packet_start;
	packet_start1 <= packet_start0;
end	

always @(posedge clk)
begin
	if((rd_usedw > 14'd511) && (wr_usedw < 13'd3000))
		fifo_ready <= 1'b1;
	else
		fifo_ready <= 1'b0;
end	
//=====================================================================================
//	系统状态机
//=====================================================================================	
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			rden <= 1'b0;
			data_out <= 16'd0;
			wren <= 1'b0;
			cnt <= 32'd0;
			count <= 32'd0;
			countp <= 16'd0;
			state <= 8'd0;
		end	
	else
		case(state)
		8'd0:
			begin
				rden <= 1'b0;
				data_out <= 16'd0;
				wren <= 1'b0;
				cnt <= 32'd0;
				count <= 32'd0;
				countp <= 16'd0;
				if(begin_reg1)
					state <= 8'd1;
			end	
		8'd1:
			begin
				if(packet_start0 && !packet_start1)
					begin
						rden <= 1'b0;
						data_out <= 16'd0;
						wren <= 1'b0;
						cnt <= cnt_init;
						count <= 32'd0;
						countp <= 16'd0;
//						state <= 8'd2;
						state <= 8'd4;
					end	
				else
					state <= 8'd1;
			end	
		8'd2:
			begin
//				data_out <= 16'h7da2;//--------------8M头
				data_out <= 16'ha27d;//--------------8M头
				wren <= 1'b1;
				countp <= countp + 1'b1;
				state <= 8'd3;
			end
		8'd3:
			begin
				if(countp  == 16'd516)
				begin
					wren <= 1'b0;
					countp <= 16'd0;
					state <= 8'd4;
				end
				else
				begin
					data_out <= 16'd0;
					wren <= 1'b1;
					countp <= countp + 1'b1;
				end		
			end
		8'd4:
			begin
				if(count == frame_length)
//				if(count == 32'd65536)
				begin
					countp <= 16'd0;
					count <= 32'd0;
//					state <= 8'd6;
					state <= 8'd8;
				end
				else if((count < frame_length) && (fifo_ready))	
				begin	
					countp <= 16'd0;
					state <= 8'd5;
				end
				else
					begin
						countp <= 16'd0;
						state <= 8'd4;
					end		
			end
		8'd5:
			begin	
				countp <= countp + 1'b1;
				if(countp  == 16'd0)
				begin
					rden <= 1'b0;
					wren <= 1'b1;
//					data_out <= 16'h7da3;
					data_out <= 16'ha37d;
				end
				else if(countp  == 16'd1)
				begin
					rden <= 1'b0;
					wren <= 1'b1;
//					data_out <= count;
					data_out <= {count[7:0],count[15:8]};
				end
				else if(countp  == 16'd2)
				begin
					rden <= 1'b0;
					wren <= 1'b1;
//					data_out <= cnt[31:16];
					data_out <= {cnt[23:16],cnt[31:24]};
				end
				else if(countp  == 16'd3)
				begin
					rden <= 1'b1;
					wren <= 1'b1;
//					data_out <= cnt[15:0];
					data_out <= {cnt[7:0],cnt[15:8]};
				end
				else if(countp  == 16'd515)
				begin
					rden <= 1'b0;
					wren <= 1'b1;
					data_out <= {data_in[7:0],data_in[15:8]};
				end
				else if(countp  == 16'd516)
				begin
					rden <= 1'b0;
					wren <= 1'b0;
					data_out <= 16'd0;
					cnt <= cnt + 1'b1;
					count <= count + 1'b1;
					state <= 8'd4;
				end
				else
				begin
					rden <= 1'b1;
					wren <= 1'b1;
					data_out <= {data_in[7:0],data_in[15:8]};
				end		
			end
		8'd6:
			begin
//				data_out <= 16'h7da4;//--------------8M尾
				data_out <= 16'ha47d;//--------------8M尾
				wren <= 1'b1;
				countp <= countp + 1'b1;
				state <= 8'd7;
			end	
		8'd7:
			begin
				if(countp  == 16'd516)
				begin
					wren <= 1'b0;
					countp <= 16'd0;
					state <= 8'd8;
				end
				else
				begin
					data_out <= 16'd0;
					wren <= 1'b1;
					countp <= countp + 1'b1;
				end		
			end	
		8'd8:
			begin
				state <= 8'd0;
			end	
		default:
				state <= 8'd0;
		endcase	
end		
//=====================================================================================	
always @(posedge clk)
begin
	if((state == 8'd0) || (state == 8'd1))
		busy <= 1'b0;
	else
		busy <= 1'b1;
end	
endmodule
