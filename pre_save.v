module pre_save(
	input clk,//----------------系统时钟
	input nRST,//---------------系统复位，0 is active。
	
	input RSOP,
	input REOP,
	input[31:0] RDAT,
	
	output[31:0] dout,
	output reg[9:0] wraddr,
	output wren,
	output reg pingpong
	);

//===================================
//寄存器定义
//===================================
reg [7:0] state;
reg [15:0] count;//---------------------------------数据计数器
reg RSOP_reg0;
reg REOP_reg0;
reg wren_reg0;
reg data_en;
reg udp_flag;

assign wren = data_en | RSOP | REOP;
assign dout = (wren)?RDAT:0;
//=====================================================================================
//	预处理
//=====================================================================================
always @(posedge clk)
begin
	RSOP_reg0 <= RSOP;
	REOP_reg0 <= REOP;
	if((!RSOP_reg0) & RSOP)
		data_en <= 1'b1;
	else if((!REOP_reg0) & REOP) 
		data_en <= 1'b0;
	else
		data_en <= data_en;
end	

always @(posedge clk)
begin
	wren_reg0 <= wren;
end	

always @(posedge clk)
begin
	if(wren & (wraddr[8:0] == 9'h00b) & (RDAT == 32'h3a87c5d7))
		udp_flag <= 1'b1;
	else if(wren & (wraddr[8:0] == 9'h00b) & (RDAT != 32'h3a87c5d7))
		udp_flag <= 1'b0;
	else
		udp_flag <= udp_flag;
end
//=====================================================================================
//	系统状态机
//=====================================================================================	
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		wraddr[8:0] <= 9'd0;
	else if(wren)
		wraddr[8:0] <= wraddr[8:0] + 1'b1;
	else 
		wraddr[8:0] <= 9'd0;
end		

always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		wraddr[9] <= 1'b0;
	else if((!wren) & wren_reg0 & (udp_flag == 1'b1))
		wraddr[9] <= ~wraddr[9];
	else 
		wraddr[9] <= wraddr[9];
end	

always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		pingpong <= 1'b0;
	else if((!wren) & wren_reg0 & (udp_flag == 1'b1))
		pingpong <= ~pingpong;
	else 
		pingpong <= pingpong;
end	

endmodule
