module source_send_ctrl(
	input clk,//----------------系统时钟
	input nRST,//---------------系统复位，0 is active。
	
	input begin_send,//----------------------------开始发送
	
	input fifo_ready,
	output reg fifo_wren,
	output [15:0] fifo_data,
	
	input [15:0] ram_data,	
	output reg[9:0] ram_addr,
	output reg ram_en,
	
	input [31:0] data_length,
	
	output reg[3:0] err//---------------------------错误输出
	);

//===================================
//寄存器定义
//===================================
reg [7:0] state;
reg [9:0] addr_end;
//=====================================================================================
//=====================================================================================
//	参数的设置以及状态机的状态值
//=====================================================================================	
parameter   idle = 8'd0,wait_send = 8'd1,start_send = 8'd2,
			send_process = 8'd3,wait_stop = 8'd4;
//=====================================================================================	
assign fifo_data = ram_data;
always @(posedge clk)
begin
	fifo_wren <= ram_en;
end

always @(posedge clk)
begin
	addr_end <= data_length[10:1] - 1'b1;
end
//=====================================================================================
//	系统状态机
//=====================================================================================	
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			ram_en <= 1'b0;
			ram_addr <= 10'd0;
			err <= 4'd0;
			state <= idle;
		end	
	else
		case(state)
		idle:
			begin
				ram_en <= 1'b0;
				ram_addr <= 10'd0;
				err <= 4'd0;
				if(begin_send == 1'b1)
					state <= wait_send;
			end	
		wait_send:
			begin
				ram_en <= 1'b0;
				ram_addr <= 10'd0;
				err <= 4'd1;
				if(fifo_ready)
					state <= start_send;
			end	
		start_send:
			begin
				ram_en <= 1'b1;
				ram_addr <= 10'd0;
				state <= send_process;
			end	
		send_process:
			begin
				err <= 4'd2;
//				if(ram_addr == 10'd511)
				if(ram_addr == addr_end)
				begin
					ram_en <= 1'b0;
					ram_addr <= 10'd0;
					state <= wait_stop;
				end	
				else if(fifo_ready)				
				begin
					ram_en <= 1'b1;
					ram_addr <= ram_addr + 1'b1;
				end
				else
				begin
					ram_en <= 1'b0;
					ram_addr <= ram_addr;
				end
			end
		wait_stop:
			begin
				ram_en <= 1'b0;
				ram_addr <= 10'd0;
				if(begin_send == 1'b0)
					state <= idle;
				else
					state <= wait_send;
			end		
		default:
				state <= idle;
		endcase	
end		
	
endmodule
