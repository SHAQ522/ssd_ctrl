module cpu_write(
	input clk,
	input pRST,
	input cpu_wr_n,
	input [8:0] cpu_addr,
	input [31:0] cpu_wdata,
/****MAC����*************************/	
	output reg  mac_reset,//--------------------MAC��ģ�鸴λ��NIOS��ַΪ1
	output reg  [31:0]packet_size,//------------UDP����һ���ĳ��ȣ�NIOS��ַΪ2
	output reg  start_send,//-------------------UDP���ݷ����źţ�NIOS��ַΪ3
/****ͨ������*************************/	
	output reg  [7:0]channel_mode0,//-----------ͨ��ѡ�� NIOS��ַΪ4
	output reg  [7:0]channel_mode1,//-----------ͨ��ѡ�� NIOS��ַΪ5
	output reg  [7:0]channel_mode2,//-----------ͨ��ѡ�� NIOS��ַΪ6
	
	output reg  [7:0]channel_para,//------------ͨ��ѡ�� NIOS��ַΪ7
	
	output reg  begin_send,//-------------------��ʼ/ֹͣ���ͣ�NIOS��ַΪ10
	output reg  send_reset,//-------------------��λ/��λ����ģ�飬NIOS��ַΪ11
	
	output reg [31:0] data_length,//------------������̳��ȣ�NIOS��ַΪ12
	
	output reg [31:0] blank_length,//-----------�����̳��ȣ�NIOS��ַΪ13
	
	output reg out_en,//------------------------���ʹ�ܼ��ԣ�NIOS��ַΪ14
	
	output reg [7:0]mode,//---------------------�����ʽ��NIOS��ַΪ15
	
	output reg [7:0] data_mode,//---------------NIOS��ַΪ16
	
	output reg [7:0] flag_mode,//---------------NIOS��ַΪ17	
	
	output reg syn_mode,//----------------------NIOS��ַΪ18
	
	output reg  begin_set,//--------------------��ʼ/ֹͣ�������ݣ�NIOS��ַΪ20
	
	output reg [31:0] syn_key,//---------------NIOS��ַΪ21
/*************************************/	
	output reg [31:0] lba_begin,//--------------Ӳ����ʼ������NIOS��ַΪ250
	output reg [31:0] lba_end,//----------------Ӳ����ֹ������NIOS��ַΪ251
	output reg  ide_wr,//-----------------------Ӳ�̿�ʼд/ֹͣд��NIOS��ַΪ252
	output reg  ide_rd,//-----------------------Ӳ�̿�ʼ��/ֹͣ����NIOS��ַΪ253
	output reg  ide_open,//---------------------Ӳ�̿�ʼ/�ر�����Դ��NIOS��ַΪ254
	output reg  ide_reset,//--------------------Ӳ�̸�λ/��λ��NIOS��ַΪ255
	output reg  sdram_reset,//-------------------��λ/��λ����ģ�飬NIOS��ַΪ257
/*************************************/		
	output reg [15:0] wraddr_begin,//-----------SDRAMд��ʼ��ַ��NIOS��ַΪ260
	output reg [15:0] wraddr_end,//-------------SDRAMд��ֹ��ַ��NIOS��ַΪ261
	output reg [15:0] rdaddr_begin,//-----------SDRAM����ʼ��ַ��NIOS��ַΪ262
	output reg [15:0] rdaddr_end,//-------------SDRAM����ֹ��ַ��NIOS��ַΪ263
	output reg  sdram_wr,//---------------------SDRAM��ʼд��NIOS��ַΪ264 
	output reg  sdram_rd,//---------------------SDRAM��ʼ����NIOS��ַΪ265
	output reg [31:0] frame_length,//-----------һ֡ͼ���С��NIOS��ַΪ266
	output reg [31:0] sdram_length,//-----------SDRAM���ݴ�С��NIOS��ַΪ267
/*************************************/		
	output reg [31:0] clk_sel_ch0,
	output reg [31:0] clk_sel_ch1,
	output reg [31:0] clk_sel_ch2,
	output reg [31:0] clk_sel_ch3,
	output reg [31:0] clk_sel_ch4,
	output reg [31:0] clk_sel_ch5,
	output reg [31:0] clk_sel_ch6,
	output reg [31:0] clk_sel_ch7,
/*************************************/	
	output reg PLL_config_start1,
	output reg PLL_config_start2,
	output reg PLL_config_start3,
	output reg PLL_config_start4,
	output reg PLL_config_start5,
	output reg PLL_config_start6,
	output reg PLL_config_start7,
	output reg PLL_config_start8,
	output reg [11:0] PLL_config_phasetap,
	output reg [8:0]  PLL_config_M_set,
	output reg [7:0]  PLL_config_C0_High_set,
	output reg [7:0]  PLL_config_C0_Low_set,
	output reg [3:0]  PLL_config_charge_pump,
	output reg [5:0]  PLL_config_lowpass_filter_R,
	output reg [1:0]  PLL_config_lowpass_filter_C,
	output reg [8:0]  PLL_config_N,
	output reg PLL_config_N_bypass,
	output reg PLL_config_Phase_posedge,
	output reg [31:0] packet_head,
	output reg [15:0] flag_set,
	output reg [23:0] length_set,
	output reg scramble,
/*************************************/	
	//output reg 
	
	output reg error
	);
//***MAC����***************************************************************************************************************************************************************//	
always @(posedge clk or posedge pRST)
if(pRST)
	mac_reset<=1'b0;
else
	if((cpu_wr_n==0) && (cpu_addr==1))
		mac_reset<=cpu_wdata[0];
always @(posedge clk or posedge pRST)
if(pRST)
	packet_size<=32'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==2))
		packet_size<=cpu_wdata[31:0];	
always @(posedge clk or posedge pRST)
if(pRST)
	start_send<=1'b0;
else
	if((cpu_wr_n==0) && (cpu_addr==3))
		start_send<=cpu_wdata[0];	
//***ͨ������***************************************************************************************************************************************************************//	
always @(posedge clk or posedge pRST)
if(pRST)
	channel_mode0<=8'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==4))
		channel_mode0<=cpu_wdata[7:0];	

always @(posedge clk or posedge pRST)
if(pRST)
	channel_mode1<=8'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==5))
		channel_mode1<=cpu_wdata[7:0];
		
always @(posedge clk or posedge pRST)
if(pRST)
	channel_mode2<=8'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==6))
		channel_mode2<=cpu_wdata[7:0];		
				
always @(posedge clk or posedge pRST)
if(pRST)
	channel_para<=8'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==7))
		channel_para<=cpu_wdata[7:0];			
/**************************************************************************/			
always @(posedge clk or posedge pRST)
if(pRST)
	begin_send<=1'b0;
else
	if((cpu_wr_n==0) && (cpu_addr==10))
		begin_send<=cpu_wdata[0];		
always @(posedge clk or posedge pRST)
if(pRST)
	send_reset<=1'b0;
else
	if((cpu_wr_n==0) && (cpu_addr==11))
		send_reset<=cpu_wdata[0];
/**************************************************************************/	
always @(posedge clk or posedge pRST)
if(pRST)
	data_length<=32'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==12))
		data_length<=cpu_wdata[31:0];	
/**************************************************************************/	
always @(posedge clk or posedge pRST)
if(pRST)
	blank_length<=32'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==13))
		blank_length<=cpu_wdata[31:0];
/**************************************************************************/
always @(posedge clk or posedge pRST)
if(pRST)
	out_en<=0;
else
	if((cpu_wr_n==0) && (cpu_addr==14))
		out_en<=cpu_wdata[0];	
/**************************************************************************/	
always @(posedge clk or posedge pRST)
if(pRST)
	mode<=8'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==15))
		mode<=cpu_wdata[7:0];	
/**************************************************************************/
always @(posedge clk or posedge pRST)
if(pRST)
	data_mode<=32'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==16))
		data_mode<=cpu_wdata[7:0];
/**************************************************************************/		
always @(posedge clk or posedge pRST)
if(pRST)
	flag_mode<=0;
else
	if((cpu_wr_n==0) && (cpu_addr==17))
		flag_mode<=cpu_wdata[7:0];
/**************************************************************************/
always @(posedge clk or posedge pRST)
if(pRST)
	syn_mode<=1'b0;
else
	if((cpu_wr_n==0) && (cpu_addr==18))
		syn_mode<=cpu_wdata[0];		
/**************************************************************************/
always @(posedge clk or posedge pRST)
if(pRST)
	begin_set<=1'b0;
else
	if((cpu_wr_n==0) && (cpu_addr==20))
		begin_set<=cpu_wdata[0];
/**************************************************************************/
always @(posedge clk or posedge pRST)
if(pRST)
	syn_key<=32'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==21))
		syn_key<=cpu_wdata;	
//***Ӳ������***************************************************************************************************************************************************************//	
//******************************************************************************************************************************************************//	
always @(posedge clk or posedge pRST)
if(pRST)
	lba_begin<=32'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==250))
		lba_begin<=cpu_wdata[31:0];
		
always @(posedge clk or posedge pRST)
if(pRST)
	lba_end<=32'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==251))
		lba_end<=cpu_wdata[31:0];

always @(posedge clk or posedge pRST)
if(pRST)
	ide_wr<=1'b0;
else
	if((cpu_wr_n==0) && (cpu_addr==252))
		ide_wr<=cpu_wdata[0];

always @(posedge clk or posedge pRST)
if(pRST)
	ide_rd<=1'b0;
else
	if((cpu_wr_n==0) && (cpu_addr==253))
		ide_rd<=cpu_wdata[0];

always @(posedge clk or posedge pRST)
if(pRST)
	ide_open<=1'b0;
else
	if((cpu_wr_n==0) && (cpu_addr==254))
		ide_open<=cpu_wdata[0];
		
always @(posedge clk or posedge pRST)
if(pRST)
	ide_reset<=1'b0;
else
	if((cpu_wr_n==0) && (cpu_addr==255))
		ide_reset<=cpu_wdata[0];			
		
always @(posedge clk or posedge pRST)
if(pRST)
	sdram_reset<=1'b0;
else
	if((cpu_wr_n==0) && (cpu_addr==257))
		sdram_reset<=cpu_wdata[0];	
//******************************************************************************************************************************************************//	
always @(posedge clk or posedge pRST)
if(pRST)
	wraddr_begin<=16'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==260))
		wraddr_begin<=cpu_wdata[15:0];
		
always @(posedge clk or posedge pRST)
if(pRST)
	wraddr_end<=16'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==261))
		wraddr_end<=cpu_wdata[15:0];

always @(posedge clk or posedge pRST)
if(pRST)
	rdaddr_begin<=16'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==262))
		rdaddr_begin<=cpu_wdata[15:0];

always @(posedge clk or posedge pRST)
if(pRST)
	rdaddr_end<=16'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==263))
		rdaddr_end<=cpu_wdata[15:0];		

always @(posedge clk or posedge pRST)
if(pRST)
	sdram_wr<=1'b0;
else
	if((cpu_wr_n==0) && (cpu_addr==264))
		sdram_wr<=cpu_wdata[0];
		
always @(posedge clk or posedge pRST)
if(pRST)
	sdram_rd<=1'b0;
else
	if((cpu_wr_n==0) && (cpu_addr==265))
		sdram_rd<=cpu_wdata[0];		

always @(posedge clk or posedge pRST)
if(pRST)
	frame_length<=32'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==266))
		frame_length<=cpu_wdata[31:0];
		
always @(posedge clk or posedge pRST)
if(pRST)
	sdram_length<=32'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==267))
		sdram_length<=cpu_wdata[31:0];
//******************************************************************************************************************************************************//	
//***CLK����***************************************************************************************************************************************************************//	
always @(posedge clk or posedge pRST)
if(pRST)
	clk_sel_ch0<=32'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==280))
		clk_sel_ch0<=cpu_wdata[31:0];	

always @(posedge clk or posedge pRST)
if(pRST)
	clk_sel_ch1<=32'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==281))
		clk_sel_ch1<=cpu_wdata[31:0];
		
always @(posedge clk or posedge pRST)
if(pRST)
	clk_sel_ch2<=32'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==282))
		clk_sel_ch2<=cpu_wdata[31:0];	

always @(posedge clk or posedge pRST)
if(pRST)
	clk_sel_ch3<=32'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==283))
		clk_sel_ch3<=cpu_wdata[31:0];		
	
always @(posedge clk or posedge pRST)
if(pRST)
	clk_sel_ch4<=32'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==284))
		clk_sel_ch4<=cpu_wdata[31:0];	

always @(posedge clk or posedge pRST)
if(pRST)
	clk_sel_ch5<=32'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==285))
		clk_sel_ch5<=cpu_wdata[31:0];
		
always @(posedge clk or posedge pRST)
if(pRST)
	clk_sel_ch6<=32'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==286))
		clk_sel_ch6<=cpu_wdata[31:0];	

always @(posedge clk or posedge pRST)
if(pRST)
	clk_sel_ch7<=32'd0;
else
	if((cpu_wr_n==0) && (cpu_addr==287))
		clk_sel_ch7<=cpu_wdata[31:0];					
/**************************************************************************/
//******************************************************************************************************************************************************//	
//******************************************************//	
always @(posedge clk or posedge pRST)
if(pRST)
	PLL_config_start1<=0;
else
	if((cpu_wr_n==0) && (cpu_addr==30))
		PLL_config_start1<=cpu_wdata[0];
		
always @(posedge clk or posedge pRST)
if(pRST)
	PLL_config_start2<=0;
else
	if((cpu_wr_n==0) && (cpu_addr==31))
		PLL_config_start2<=cpu_wdata[0];		
		
always @(posedge clk or posedge pRST)
if(pRST)
	PLL_config_start3<=0;
else
	if((cpu_wr_n==0) && (cpu_addr==32))
		PLL_config_start3<=cpu_wdata[0];


always @(posedge clk or posedge pRST)
if(pRST)
	PLL_config_start4<=0;
else
	if((cpu_wr_n==0) && (cpu_addr==33))
		PLL_config_start4<=cpu_wdata[0];
		
always @(posedge clk or posedge pRST)
if(pRST)
	PLL_config_start5<=0;
else
	if((cpu_wr_n==0) && (cpu_addr==34))
		PLL_config_start5<=cpu_wdata[0];
		
always @(posedge clk or posedge pRST)
if(pRST)
	PLL_config_start6<=0;
else
	if((cpu_wr_n==0) && (cpu_addr==35))
		PLL_config_start6<=cpu_wdata[0];		
		
always @(posedge clk or posedge pRST)
if(pRST)
	PLL_config_start7<=0;
else
	if((cpu_wr_n==0) && (cpu_addr==36))
		PLL_config_start7<=cpu_wdata[0];


always @(posedge clk or posedge pRST)
if(pRST)
	PLL_config_start8<=0;
else
	if((cpu_wr_n==0) && (cpu_addr==37))
		PLL_config_start8<=cpu_wdata[0];		
//******************************************************//			
						
always @(posedge clk or posedge pRST)
if(pRST)
	PLL_config_phasetap<=0;
else
	if((cpu_wr_n==0) && (cpu_addr==40))
		PLL_config_phasetap<=cpu_wdata[11:0];
		
always @(posedge clk or posedge pRST)
if(pRST)
	PLL_config_M_set<=0;
else
	if((cpu_wr_n==0) && (cpu_addr==41))
		PLL_config_M_set<=cpu_wdata[8:0];
		
always @(posedge clk or posedge pRST)
if(pRST)
	PLL_config_C0_High_set<=0;
else
	if((cpu_wr_n==0) && (cpu_addr==42))
		PLL_config_C0_High_set<=cpu_wdata[7:0];	
		
always @(posedge clk or posedge pRST)
if(pRST)
	PLL_config_C0_Low_set<=0;
else
	if((cpu_wr_n==0) && (cpu_addr==43))
		PLL_config_C0_Low_set<=cpu_wdata[7:0];	
		
always @(posedge clk or posedge pRST)
if(pRST)
	PLL_config_charge_pump<=0;
else
	if((cpu_wr_n==0) && (cpu_addr==44))
		PLL_config_charge_pump<=cpu_wdata[3:0];	
		
always @(posedge clk or posedge pRST)
if(pRST)
	PLL_config_lowpass_filter_R<=0;
else
	if((cpu_wr_n==0) && (cpu_addr==45))
		PLL_config_lowpass_filter_R<=cpu_wdata[5:0];	
		
always @(posedge clk or posedge pRST)
if(pRST)
	PLL_config_lowpass_filter_C<=0;
else
	if((cpu_wr_n==0) && (cpu_addr==46))
		PLL_config_lowpass_filter_C<=cpu_wdata[1:0];	
		
always @(posedge clk or posedge pRST)
if(pRST)
	PLL_config_N<=0;
else
	if((cpu_wr_n==0) && (cpu_addr==47))
		PLL_config_N<=cpu_wdata[8:0];
		
always @(posedge clk)
if(PLL_config_N==1)
	PLL_config_N_bypass<=1;
else
	PLL_config_N_bypass<=0;
	
always @(posedge clk or posedge pRST)
if(pRST)
	PLL_config_Phase_posedge<=0;
else
	if((cpu_wr_n==0) && (cpu_addr==48))
		PLL_config_Phase_posedge<=cpu_wdata[0];	
//******************************************************//	
//************************************************************************************************************************************************************************//	
always @(posedge clk or posedge pRST)
if(pRST)
	error<=0;
else
	if((cpu_wr_n==0) && (cpu_addr==511))//low is low active,high is high active
		error<=cpu_wdata[0];
		
endmodule
