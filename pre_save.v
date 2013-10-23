module pre_save(
	input clk,//----------------ϵͳʱ��
	input nRST,//---------------ϵͳ��λ��0 is active��
	
	input RSOP,
	input REOP,
	input[31:0] RDAT,
	
	output[31:0] dout,
	output reg[9:0] wraddr,
	output wren,
	output reg pingpong
	);

//===================================
//�Ĵ�������
//===================================
reg [7:0] state;
reg [15:0] count;//---------------------------------���ݼ�����
reg RSOP_reg0;
reg REOP_reg0;
reg wren_reg0;
reg data_en;
reg udp_flag;

assign wren = data_en | RSOP | REOP;
assign dout = (wren)?RDAT:0;
//=====================================================================================
//	Ԥ����
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
//	ϵͳ״̬��
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
