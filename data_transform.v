module data_transform(
	input [3:0] data_form,//----------------------------���ݷ��͸�ʽ��1/2/4/8/16
							//----------------------------data_lengthΪ 1/2/3/4/5 
	input [6:0] fifo_wrusedw_16,//------------------------fifo_8to16��wrusedw
	input [6:0] fifo_wrusedw_8,//-------------------------fifo_8to8��wrusedw
	input [6:0] fifo_wrusedw_4,//-------------------------fifo_8to4��wrusedw
	input [6:0] fifo_wrusedw_2,//-------------------------fifo_8to2��wrusedw
	input [6:0] fifo_wrusedw_1,//-------------------------fifo_8to1��wrusedw
	output reg [6:0] fifo_wrusedw,//---------------------�����wrusedw
	
	input [15:0] data_in_16,//----------------------------fifo_8to16��data_out
	input [7:0] data_in_8,//------------------------------fifo_8to8��data_out
	input [3:0] data_in_4,//------------------------------fifo_8to4��data_out
	input [1:0] data_in_2,//------------------------------fifo_8to2��data_out
	input  data_in_1,//-----------------------------------fifo_8to1��data_out
	output reg [15:0] data_out//-------------------------�������
	);

always @(*)
begin
	if(data_form==4'd1)
		fifo_wrusedw = fifo_wrusedw_1;
	else
		if(data_form==4'd2)
		fifo_wrusedw = fifo_wrusedw_2;
	else
		if(data_form==4'd3)
		fifo_wrusedw = fifo_wrusedw_4;
	else
		if(data_form==4'd4)
		fifo_wrusedw = fifo_wrusedw_8;
	else
		if(data_form==4'd5)
		fifo_wrusedw = fifo_wrusedw_16;
	else
		fifo_wrusedw = fifo_wrusedw_8;
end
	
always @(*)
begin
	if(data_form==4'd1)
		data_out = {15'd0,data_in_1};
	else
		if(data_form==4'd2)
		data_out = {14'd0,data_in_2};
	else
		if(data_form==4'd3)
		data_out = {12'd0,data_in_4};
	else
		if(data_form==4'd4)
		data_out = {18'd0,data_in_8};//?
	else
		if(data_form==4'd5)
		data_out = {data_in_16[7:0],data_in_16[15:8]};
	else
		data_out = {18'd0,data_in_8};
end
	
endmodule
