module data_format_422(
	input clk,//----------------ϵͳʱ��
	input nRST,//---------------ϵͳ��λ��0 is active��
	
	input CLK_IN,
	input EN_IN,
	input DATA_IN,
	
	output reg data_out,
	output reg data_en
	);

//===================================
//�Ĵ�������
//===================================
reg clk_reg0,clk_reg1;

always @(posedge clk)
begin
	clk_reg0 <= CLK_IN;
	clk_reg1 <= clk_reg0;
end

always @(posedge clk)
begin
	data_out <= DATA_IN;
end

always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		data_en <= 1'b0;
	else if(clk_reg0 & (!clk_reg1))
		data_en <= 1'b1;
	else
		data_en <= 1'b0;	
end		
	
endmodule
