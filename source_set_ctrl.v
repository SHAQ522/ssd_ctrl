module source_set_ctrl(
	input clk,//----------------系统时钟
	input nRST,//---------------系统复位，0 is active。
	
	input begin_set,//------------------------------开始烧写
	
	input [10:0] fifo_usedw,
	output fifo_rden,
	input [15:0] fifo_data,
		
	output [15:0] ram_data,	
	output reg[9:0] ram_addr,
	output reg ram_en,
	
	output reg[3:0] err//---------------------------错误输出
	);

//===================================
//寄存器定义
//===================================
reg [7:0] state;
//=====================================================================================
//=====================================================================================
//	参数的设置以及状态机的状态值
//=====================================================================================	
parameter   idle = 8'd0,wait_set = 8'd1,start_set = 8'd2,
			set_process = 8'd3,wait_stop = 8'd4;
//=====================================================================================	
assign ram_data = {fifo_data[7:0],fifo_data[15:8]};
assign fifo_rden = ram_en;
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
				if(begin_set == 1'b1)
					state <= wait_set;
			end	
		wait_set:
			begin
				ram_en <= 1'b0;
				ram_addr <= 10'd0;
				err <= 4'd1;
				if(fifo_usedw >= 11'd256)
					state <= start_set;
				else
					state <= wait_set;
			end	
		start_set:
			begin
				ram_en <= 1'b1;
				ram_addr <= 10'd0;
				state <= set_process;
			end	
		set_process:
			begin
				err <= 4'd2;
				if(ram_addr == 10'd511)
				begin
					ram_en <= 1'b0;
					ram_addr <= 10'd0;
					state <= wait_stop;
				end	
				else				
				begin
					ram_en <= 1'b1;
					ram_addr <= ram_addr + 1'b1;
				end
			end
		wait_stop:
			begin
				ram_en <= 1'b0;
				ram_addr <= 10'd0;
				if(fifo_usedw != 11'd0)
					err <= 4'd3;
				else
					err <= 4'd4;
				if(begin_set == 1'b0)
					state <= idle;
			end		
		default:
				state <= idle;
		endcase	
end		
	
endmodule
