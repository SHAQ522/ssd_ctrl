module source_test_ctrl(
	input clk,//----------------系统时钟
	input nRST,//---------------系统复位，0 is active。
	
	input [11:0] fifo_usedw,//----------------------fifo_rdusedw，多于3000时启动发送数据
	
	output reg data_en//----------------------------数据使能输出
	);

//===================================
//寄存器定义
//===================================
reg [2:0] state;
reg [31:0] count;
reg [11:0] fifo_usedw_reg;

always @(posedge clk or negedge nRST)
begin
	fifo_usedw_reg <= fifo_usedw;
end
//=====================================================================================
//	系统状态机
//=====================================================================================	
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			data_en <= 1'b0;
			count <= 32'd0;
			state <= 3'd0;
		end	
	else
		case(state)
		3'd0:
			begin
			data_en <= 1'b0;
			count <= 32'd0;
			state <= 3'd1;
			end	
		3'd1:
			begin
				data_en <= 1'b0;
				count <= 32'd0;
				if(fifo_usedw_reg > 12'd1024)
					state <= 3'd2;
				else
					state <= 3'd1;
			end	
		3'd2:
			begin
				begin
				data_en <= 1'b1;
				if(count < 32'd1023)
					count <= count + 1'b1;
				else	
					begin
						count <= 32'd0;
						state <= 3'd3;
					end	
				end
			end	
		3'd3:
			begin
				data_en <= 1'b0;
				count <= 32'd0;
				state <= 3'd1;
			end		
		default:
				state <= 3'd0;
		endcase	
end		
	
endmodule
