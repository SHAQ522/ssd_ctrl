module IDE_IO_interface(
	input clk,
	input pRST,
	//=============================
	//模块输入/输出控制接口
	//=============================
	input command,//为高时是输入命令
	input [16:0] Sector_Count_i,//扇区数
	input [47:0] LBA_i,//逻辑地址
	input IDE_nWR_i,//低电平为写,高电平为读
	
	input [15:0] IDE_write_data,//写入数据
	input IDE_w_empty,//写入的fifo为空
	input IDE_w_almost_empty,////写入的fifo快空了(这时候读慢一些)
	output reg IDE_w_ack,//模块每读一个数据给出一个ack
	
	output reg IDE_r_en,//开始UDMA读了以后为高,其它时间为低
	input IDE_r_almost_full,//读fifo快满(此时暂停UDMA读,还可能有5个数据过来)
	input IDE_r_go_on,
	
	output IDE_busy,
	
	//=============================
	//外部读写接口
	//=============================
	input INTRQ,//中断请求 不用
	input IORDY,//IO就绪/UDMA读时钟
	input DMARQ,//DMA请求
	output reg nDIOR_reg,//IO读 /UDMA输出时钟
	output reg nDIOW,//IO写 /UDMA触发结束
	output [2:0] DA,//地址位
	output [1:0] CS,//片选
	output reg nRESET,//复位
	output reg nDMACK,//dma应答
	inout  reg [15:0] Data_to_from_HD,//双向数据
	
	//=============================
	//内部使用接口
	//=============================
	output reg crc_init,//开始一次 读crc 初始化
	input [24:0] IDE_r_num,////读数据个数
	input [15:0] CRC_result,
	output reg [7:0] test,
	output reg add_a_clk,
	output reg ide_error
	);
	
//===================================
//寄存器定义
//===================================
reg [23:0] delay_cnt;
reg [3:0] Num;
reg [7:0] present_state,breakpoint,next_state;
reg [4:0] RegAddr;
reg [15:0] Write_Buffer,Read_Buffer;
reg Flag;
reg [4:0] udma_delay_cnt;
reg[7:0]		cnt;		
reg [47:0] IDE_w_num;

//===================================
//接口同步处理
//===================================
reg IORDY_i,DMARQ_i;
reg IORDY_buf,DMARQ_buf;

always @(posedge clk)
begin
	IORDY_i<=IORDY;
	DMARQ_i<=DMARQ;
	IORDY_buf<=IORDY_i;
	DMARQ_buf<=DMARQ_i;
end

reg [16:0] Sector_Count;
reg [47:0] LBA;
reg IDE_nWR;

reg nDIOR;
always @(posedge clk)
begin
	Data_to_from_HD <= (Flag)? Write_Buffer : 16'hzzzz;
	nDIOR_reg<=nDIOR;
end

//=====================================================================================
//	参数的设置以及状态机的状态值
//=====================================================================================	
	parameter   high = 1'b1,low = 1'b0;
	parameter   idle = 8'd0,Reset_HD = 8'd1,Reset_HD1 = 8'd2,Soft_Reset = 8'd3,
				Set_Device_LBA = 8'd4,Wait = 8'd5;
	parameter   Set_UDMA = 8'd6,Set_UDMA1 = 8'd7,Set_UDMA2 = 8'd8,Set_UDMA3 = 8'd9,
				Command_Delay = 8'd10;
	parameter   Write_Reg = 8'd11,Write_Reg2 = 8'd12,
				Write_Reg3 = 8'd13,Write_Reg5 = 8'd14,
				Write_Reg6 = 8'd15,Write_Reg7 = 8'd16,Write_Reg8 = 8'd17;
	parameter   Read_Reg = 8'd18,Read_Reg2 = 8'd19,
				Read_Reg3 = 8'd20,Read_Reg5 = 8'd21,
				Read_Reg6 = 8'd22,Read_Reg7 = 8'd23,Read_Reg8 = 8'd24;
	parameter   Read_Data = 8'd25,Read_Data1 = 8'd26,Read_Data2 = 8'd27,
				Read_Data3 = 8'd28,Read_Data4 = 8'd29,Read_Data5 = 8'd30;
	parameter   Read_State = 8'd31,Check_State = 8'd32,Read_State2 = 8'd33,
				Delay = 8'd34,Read_State3 = 8'd35,
				Check_State3 = 8'd36,Read_State4 = 8'd37,Check_State4 = 8'd38;
	parameter	UDMA_para=8'd40,UDMA_para1=8'd41,UDMA_para2=8'd43,
				RUDMA_Initiate=8'd44,RUDMA_Initiate2=8'd45,RUDMA_Sustain=8'd46,
				RUDMA_Terminate=8'd47,RUDMA_Terminate1=8'd48,RUDMA_Terminate2=8'd49;
	parameter	Read_CRC=8'd50,Check_CRC=8'd51;
	parameter   UDMA_WAIT_DMARQ=8'd60,WUDMA_Initiate1=8'd61,WUDMA_Initiate2=8'd62,
				WUDMA_Initiate3=8'd63,WUDMA_Sustain=8'd64,WUDMA_Sustain1=8'd65,
				WUDMA_Sustain2=8'd66,WUDMA_Sustain3=8'd67,WUDMA_Terminate=8'd68,
				WUDMA_Terminate1=8'd69,ALL_UDMA_has_Terminate=8'd70,WUDMA_Terminate2=8'd71;
	parameter	WUDMA_Sustain_delay=8'd80,delay_after_crc=8'd81,RUDMA_ADD_CLK=8'd82;
//=====================================================================================
//	IDE接口中的寄存器地址
//=====================================================================================	
	parameter   rData = 5'h10,rErr_Feature = 5'h11,rSecCount = 5'h12,rSecNum = 5'h13,
				rCylinderL = 5'h14,rCylinderH = 5'h15,rDevice_Head = 5'h16,
				rStatus_Command = 5'h17,rDevice_Control = 5'b01110;
//=====================================================================================
//	持续赋值语句
//=====================================================================================	
	assign 	DA = RegAddr[2:0];
	assign 	CS = RegAddr[4:3];
//	assign 	Data_to_from_HD = (Flag)? Write_Buffer : 16'hzzzz;
	assign  IDE_busy=(present_state==idle)?1'b0:1'b1;
//=====================================================================================
//	UDMA传输中的CRC校验
//=====================================================================================	
	reg [15:0]   	CRCOUT;
	wire [15:0]   	CRCIN;
	reg [15:0]   	DD;
	wire [16:1]   	FDBK;
	

	assign	FDBK[1] = DD[0]^CRCOUT[15];
	assign	FDBK[2] = DD[1]^CRCOUT[14];
	assign	FDBK[3] = DD[2]^CRCOUT[13];
	assign	FDBK[4] = DD[3]^CRCOUT[12];
	assign	FDBK[5] = DD[4]^CRCOUT[11]^FDBK[1];
	assign	FDBK[6] = DD[5]^CRCOUT[10]^FDBK[2];
	assign	FDBK[7] = DD[6]^CRCOUT[9]^FDBK[3];
	assign	FDBK[8] = DD[7]^CRCOUT[8]^FDBK[4];
	assign	FDBK[9] = DD[8]^CRCOUT[7]^FDBK[5];
	assign	FDBK[10] = DD[9]^CRCOUT[6]^FDBK[6];
	assign	FDBK[11] = DD[10]^CRCOUT[5]^FDBK[7];
	assign	FDBK[12] = DD[11]^CRCOUT[4]^FDBK[1]^FDBK[8];
	assign	FDBK[13] = DD[12]^CRCOUT[3]^FDBK[2]^FDBK[9];
	assign	FDBK[14] = DD[13]^CRCOUT[2]^FDBK[3]^FDBK[10];
	assign	FDBK[15] = DD[14]^CRCOUT[1]^FDBK[4]^FDBK[11];
	assign	FDBK[16] = DD[15]^CRCOUT[0]^FDBK[5]^FDBK[12];

	assign	CRCIN[0] = FDBK[16];
	assign	CRCIN[1] = FDBK[15];
	assign	CRCIN[2] = FDBK[14];
	assign	CRCIN[3] = FDBK[13];
	assign	CRCIN[4] = FDBK[12];
	assign	CRCIN[5] = FDBK[11]^FDBK[16];
	assign	CRCIN[6] = FDBK[10]^FDBK[15];
	assign	CRCIN[7] = FDBK[9]^FDBK[14];
	assign	CRCIN[8] = FDBK[8]^FDBK[13];
	assign	CRCIN[9] = FDBK[7]^FDBK[12];
	assign	CRCIN[10] = FDBK[6]^FDBK[11];
	assign	CRCIN[11] = FDBK[5]^FDBK[10];
	assign	CRCIN[12] = FDBK[4]^FDBK[9]^FDBK[16];
	assign	CRCIN[13] = FDBK[3]^FDBK[8]^FDBK[15];
	assign	CRCIN[14] = FDBK[2]^FDBK[7]^FDBK[14];
	assign	CRCIN[15] = FDBK[1]^FDBK[6]^FDBK[13];

	
//=============================================
//核心状态机
//=============================================
	always @(posedge clk or posedge pRST)    //asynchronous reset
	begin
		if(pRST)
			begin
					nDMACK <= 1'b1;
					nDIOR <= high;
					nDIOW <= high;
					nRESET <= 1'b1;
					
					Flag <= 1'd0;
					Num <= 4'd0;
					RegAddr <= 5'h0;
					delay_cnt <= 24'h0;
					Write_Buffer <= 16'h0;
					Read_Buffer <= 16'h0;
					test<=0;
					
					IDE_w_ack<=0;
					crc_init<=1'd1;
					IDE_r_en<=0;
					
					CRCOUT <= 16'h4ABA;
					
					present_state <= Reset_HD;
					breakpoint <= idle;
					next_state <= idle;
					IDE_w_num<=48'd0;
					udma_delay_cnt<=0;
					ide_error<=0;
			end
		else
			case(present_state)
			Reset_HD:              
						begin
								nRESET <= 1'b0;
								if(delay_cnt[12]==1'b1)  //delay>25us;
									begin
										delay_cnt <= 24'h0;
										present_state <= Reset_HD1;
									end
								else
									delay_cnt <= delay_cnt + 1'b1;
						end
			Reset_HD1:
						begin
								nRESET <= 1'b1;
								if(delay_cnt[18]==1'b1) //delay>2ms
									begin
										delay_cnt <= 24'h0;
										present_state <= Soft_Reset;
									end
								else
									delay_cnt <= delay_cnt + 1'b1;
						end

//=====================================================================================//
			Soft_Reset:                                       //Software Reset
						begin
								test<=60;
								RegAddr <= rDevice_Control;
								Write_Buffer <= 16'h0002;     //nIEN = 1,SRST = 0 中断不允许
								present_state <= Write_Reg;	//是否需要检查状态???
								breakpoint <= Set_Device_LBA;//Soft_Reset3;
						end
			Set_Device_LBA:               
						begin
								test<=61;
								RegAddr <= rDevice_Head;
								Write_Buffer <= 16'h00E0;		//device 0 && LBA 方式
								present_state <= Write_Reg;
								breakpoint <= Read_State;
//								next_state <= Set_UDMA;//Set_MaxSector;
								next_state <= idle;
						end
//*************************************************************************************//
/*					//set UDMA Mode,select UMDA100
			Set_UDMA:
						begin	
								test<=62;
								RegAddr <= rErr_Feature;
								Write_Buffer <= 16'h0003;
								present_state <= Write_Reg;
								breakpoint <= Read_State3;
								next_state <= Set_UDMA1;
						end
		    Set_UDMA1:
						begin	
								RegAddr <= rSecCount;
								Write_Buffer <= 16'h0047;			// Select UDMA Mode 5
								present_state <= Write_Reg;
								breakpoint <= Read_State3;
								next_state <= Set_UDMA2;
						end
			Set_UDMA2:	
						begin	
								RegAddr <= rStatus_Command;
								Write_Buffer <= 16'h00EF;
								present_state <= Write_Reg;
								breakpoint <= Read_State3;
								next_state <= Set_UDMA3;
						end
			Set_UDMA3:
						begin	
								present_state <= idle;
						end*/
//=====================================================================================//
			Read_State:                            
						begin
							RegAddr <= rStatus_Command;
							present_state <= Read_Reg;
							breakpoint <= Check_State;
						end 
			Check_State:                                       
						begin
							if((!Read_Buffer[7])&&Read_Buffer[6])    
								present_state <= next_state;
							else
								present_state <= Set_Device_LBA;
						end 
//=====================================================================================//
			Read_State2:                 //read error register;
						begin
							test<=50;
							RegAddr <= rErr_Feature;
							present_state <= Read_Reg;
							breakpoint <= Read_State2;//Soft_Reset;
							//breakpoint<=Reset_HD;
							ide_error<=1;
						end 
			Read_State3:                                           
						begin
							test<=51;
							RegAddr <= rStatus_Command;
							present_state <= Read_Reg;
							breakpoint <= Check_State3;
						end 
			Check_State3:                                       
						begin
							test<=52;
							if((!Read_Buffer[7])&&(Read_Buffer[6])&&(!Read_Buffer[0]))    
								present_state <= next_state;
							else if(Read_Buffer[0])
								present_state <= Read_State2;
							else
								present_state <= Read_Reg;
						end 
//*************************************************************************************//
//=====================================================================================//
			idle :
						begin  
							nDMACK <= 1'b1;
							nDIOR <= high;
							nDIOW <= high;
							nRESET <= 1'b1;
					
							Flag <= 0;
							Num <= 0;
							RegAddr <= 5'h0;
							delay_cnt <= 24'h0;
							Write_Buffer <= 16'h0;
							Read_Buffer <= 16'h0;
							test <= 1;
					
							IDE_w_ack<=0;
							crc_init<=1'd1;
							IDE_r_en<=0;
							IDE_w_num<=0;
							
							
							CRCOUT <= 16'h4ABA;
							
							if(command)
							begin
								present_state<=UDMA_para;
								Sector_Count<=Sector_Count_i;
								LBA<=LBA_i;
								IDE_nWR<=IDE_nWR_i;
								//Sector_Count<=2;
								//LBA<=0;
							end
						end
//*************************************************************************************//
		UDMA_para :		
						begin	
						     
							test<=3;
							case(Num)                         
							4'd0:   begin 
										RegAddr <= rSecCount;
										Write_Buffer <= {8'h0,Sector_Count[15:8]};
									end
							4'd1:   begin 
										RegAddr <= rSecNum;
										Write_Buffer<={8'h0,LBA[31:24]};
									end
							4'd2:   begin 
										RegAddr <= rCylinderL;
										Write_Buffer<={8'h0,LBA[39:32]};
									end
							4'd3:   begin 
										RegAddr <= rCylinderH;
										Write_Buffer<={8'h0,LBA[47:40]};
									end
							4'd4:   begin 
										RegAddr <= rSecCount;
										Write_Buffer <= {8'h0,Sector_Count[7:0]};
									end
							4'd5:   begin 
										RegAddr <= rSecNum;
										Write_Buffer<={8'h0,LBA[7:0]};
									end
							4'd6:   begin 
										RegAddr <= rCylinderL;
										Write_Buffer<={8'h0,LBA[15:8]};
									end
							4'd7:   begin 
										RegAddr <= rCylinderH;
										Write_Buffer<={8'h0,LBA[23:16]};
									end
							4'd8:   begin 
										RegAddr <= rDevice_Head;
										Write_Buffer<=16'h00E0;
									end
									
							default:   begin RegAddr <= RegAddr;Write_Buffer <= Write_Buffer;end
							endcase
							if(Num==4'd9)
								begin
									present_state <= Read_State3;
									next_state <= UDMA_para1;
								end
							else
								begin
									Num <= Num + 4'd1;
									present_state <= Write_Reg;
									breakpoint <= UDMA_para;
								end
						end							
			UDMA_para1:                    
						begin
						    test<=4;	
							RegAddr <= rStatus_Command;
							if(IDE_nWR)
								Write_Buffer <= 16'h0025;//read dma ext
							else
								Write_Buffer <= 16'h0035;//write dma ext
							present_state <= Write_Reg;
							breakpoint <= Command_Delay;
							next_state <= UDMA_WAIT_DMARQ;
						end
			Command_Delay:
						begin	
							if(cnt==8'd100)	//Send command,then wait for about 400ns
								begin
									cnt <= 8'd0;
									present_state <= Read_State4;
								end
							else
								cnt <= cnt + 1'b1;
						end		
			UDMA_WAIT_DMARQ:
						begin
							udma_delay_cnt<=0;
							if(DMARQ_buf)
								begin
									nDIOR <= 1'b1;
									nDIOW <= 1'b1;
									RegAddr <= 5'b11000;
									if(IDE_nWR==1)
									begin
										test<=70;
										present_state <= RUDMA_Initiate2;
									end
									else
									begin
										test<=99;
										present_state <= WUDMA_Initiate2;
									end
								end
							else
								test<=8;
						end
			WUDMA_Initiate2:
						begin
							Flag<=1'd1;
							udma_delay_cnt<=udma_delay_cnt+5'd1;
							if(udma_delay_cnt==5'd3)
							begin
								nDMACK<=0;//posedge DIOW to negedge DMACK>=20ns
							end	
							else if(udma_delay_cnt>=5'd6)
							begin
								nDIOW<=0;//posedge DMACK to negedge DIOW >=20ns <=50ns
								present_state<=WUDMA_Initiate3;
							end
						end
			WUDMA_Initiate3:
						begin
							test<=10;
							udma_delay_cnt<=5'd0;
							IDE_w_num<=0;
							if(!IORDY_buf)					//wait negedge IORDY 
								present_state <= WUDMA_Sustain;
						end
			WUDMA_Sustain:
						begin
							IDE_w_ack<=1'd0;
							test<=71;
							if((IDE_w_empty==1'b0) && (IORDY_i ==0))//has data
							begin
								present_state<=WUDMA_Sustain1;
							end
						end
			WUDMA_Sustain1:
						begin
							test<=72;
					//		if(IORDY==0 && IDE_w_empty==1'b0)//IORDY=1表示设备请求暂停
					//		begin
								IDE_w_ack<=1'd1;
								IDE_w_num<=IDE_w_num+25'd1;
								Write_Buffer<=IDE_write_data;
								DD<=IDE_write_data;
								present_state<=WUDMA_Sustain3;
					//		end
						end
			/*WUDMA_Sustain2:
						begin
							test<=73;
							IDE_w_ack<=1'd0;
							present_state<=WUDMA_Sustain3;
						end*/
			WUDMA_Sustain3:
						begin
							test<=74;
							IDE_w_ack<=1'd0;
							nDIOR <= !nDIOR;
							CRCOUT <= CRCIN;
							if(IDE_w_num[32:8]==Sector_Count)
								present_state<=WUDMA_Terminate;
							else
							begin
								if(IDE_w_almost_empty==1'b0 && IORDY_i ==0)//has data
									present_state<=WUDMA_Sustain1;
								else
									present_state<=WUDMA_Sustain;
							end
								
						end
			WUDMA_Terminate:
						begin
							test<=11;
							udma_delay_cnt<=udma_delay_cnt+5'd1;
							if(udma_delay_cnt>=5'd7)
							begin
								nDIOW<=1'd1;
								present_state<=WUDMA_Terminate1;//write end to posedge DIOW >=50ns
							end
						end
			WUDMA_Terminate1:
						begin
							delay_cnt<=0;
							test<=12;
							Write_Buffer <= CRCOUT;
							//Write_Buffer <= 16'h4bd9;
							if((!DMARQ_buf) && IORDY_buf)
							begin
								udma_delay_cnt<=udma_delay_cnt+5'd1;
								if(udma_delay_cnt>=15)//>=20ns
								begin
									nDMACK<=1'd1;
									present_state<=WUDMA_Terminate2;
								end
							end
							
						end
			WUDMA_Terminate2:
						begin
							if(delay_cnt==100)
							begin
								delay_cnt<=0;
								present_state<=ALL_UDMA_has_Terminate;
							end
							else
								delay_cnt<=delay_cnt+24'd1;
						end
						
			RUDMA_Initiate2:
						begin
							test<=13;
							if(IDE_r_go_on==1)
								udma_delay_cnt<=udma_delay_cnt+5'd1;
							crc_init<=1'd0;
							
							if(udma_delay_cnt==3)
							begin
								IDE_r_en<=1;
								nDMACK<=1'd0;//posedge DIOW to negedge DMACK>=20ns
							end
							
							if(udma_delay_cnt>=6)
							begin
								nDIOW<=1'd0;//posedge DMACK to negedge DIOW >=20ns <=50ns
								present_state<=RUDMA_Sustain;
							end
							
							if(udma_delay_cnt==5)
								nDIOR<=1'd0;
						end
			RUDMA_Sustain:
						begin
							udma_delay_cnt<=5'd0;
							//if(IDE_r_num+2=={Sector_Count,8'd0} && IORDY_buf==1)//在读完最后一个数后加1个上升沿,使得FIFO正常
							if(IDE_r_num=={Sector_Count,8'd0})
							begin
								present_state<=RUDMA_Terminate;
								IDE_r_en<=1'd0;
							end
							if(IDE_r_almost_full)//almost_full
							begin
								nDIOR<=1'd1;//pause the read udma
							end
							else if(IDE_r_go_on==1)//half empty
							begin
								nDIOR<=1'd0;//go on the read udma
							end
						end
	/*		RUDMA_ADD_CLK:
						begin
							
							if(IDE_r_num=={Sector_Count,8'd0})
								present_state<=RUDMA_Terminate;
						end*/
			RUDMA_Terminate:
						begin
							nDIOR<=1'd1;
							test<=14;
							Flag<=1'd1;
							Write_Buffer<=CRC_result;
							
							if(udma_delay_cnt>=5'd20)
							begin
								nDIOW<=1'd1;//negedge DIOR to posedge DIOW>=85ns
								present_state<=RUDMA_Terminate1;
								udma_delay_cnt<=5'd0;
							end
							else
								udma_delay_cnt<=udma_delay_cnt+5'd1;
						end
			RUDMA_Terminate1:
						begin
							test<=15;
							if(DMARQ_buf==1'd0)
							begin
								udma_delay_cnt<=udma_delay_cnt+5'd1;
								if(udma_delay_cnt>=5'd10)
								begin
									present_state<=ALL_UDMA_has_Terminate;
									nDMACK<=1;//negedge DMARQ to posedge DMACK >=20 ns
								end
							end
						end
			ALL_UDMA_has_Terminate:
						begin
							delay_cnt<=0;
							present_state <= Read_CRC;
							next_state <= delay_after_crc;
						end
			Read_CRC:        
						begin
								test<=20;
								RegAddr <= rStatus_Command;
								present_state <= Read_Reg;
								breakpoint <= Check_CRC;
						end 
			Check_CRC:                                       
						begin	
							if((!Read_Buffer[7])&&(Read_Buffer[6])&&(!Read_Buffer[3])&&(!Read_Buffer[0]))	//BSY=0,DRDY=1,ERR=0
								begin
									test<=21;
									present_state <= next_state;
								end
							else if((!Read_Buffer[7])&&(Read_Buffer[0]))
								begin
									test<=22;
									present_state <= Read_State2;
								end	
							else
								begin
								    test<=23;
									present_state <= Read_Reg;
								end
						end 
			delay_after_crc:
						begin
							delay_cnt<=delay_cnt+24'd1;
							if(delay_cnt>=30)
								present_state <=idle;
							
						end
//=====================================================================================//
			Read_State4:                                       
							begin
								test<=24;
								RegAddr <= rStatus_Command;
								present_state <= Read_Reg;
								breakpoint <= Check_State4;
							end 
			Check_State4:                                       
							begin
								test<=25;
								if((!Read_Buffer[7])&&(Read_Buffer[3])) //BSY==0&&DRQ==1??
									present_state <= next_state;
								else
									present_state <= Read_Reg;
							end 
//=====================================================================================//
//Register transfer to device;
                     Write_Reg:      
                                    begin
                                           nDIOW <= high;
                                           present_state <= Write_Reg2;
                                    end
                     Write_Reg2:
                                    begin
                                           nDIOW <= low;
                                           present_state <= Write_Reg3;       
                                    end
                     Write_Reg3:
                                    begin
										   Flag <= 1'b1;
                                           if(delay_cnt[1]==1'b1)        
                                                  begin
                                                         delay_cnt <= 24'h0;
                                                         present_state <= Write_Reg5;
                                                  end
                                           else
                                                    delay_cnt <= delay_cnt + 1'b1;      
                                    end
                     Write_Reg5:                                                
                                    begin
                                           present_state <= Write_Reg6;       
                                    end
                     Write_Reg6:
                                    begin
                                           if(delay_cnt[1]==1'b1)        
                                                  begin
                                                         delay_cnt <= 24'h0;
                                                         present_state <= Write_Reg7;
                                                  end
                                           else
                                                    delay_cnt <= delay_cnt + 1'b1;      
                                    end
                     Write_Reg7:
                                    begin
                                           nDIOW <= high;
                                           if(delay_cnt[1]==1'b1)        
                                                  begin
                                                         delay_cnt <= 24'h0;
													//	rdreq <= 1;
                                                         present_state <= Write_Reg8;
                                                  end
                                           else
                                                    delay_cnt <= delay_cnt + 1'b1;        
                                    end
                     Write_Reg8:
                                    begin
                                           Flag <= 1'b0;
										//	rdreq <= 1;
                                           nDIOW <= high;
                                           present_state <= breakpoint;         //return;
                                    end
//=====================================================================================//
//Register transfer from device;
                     Read_Reg:                                         
                                    begin
                                           Flag <= 1'b0;
                                           nDIOR <= high;
                                           present_state <= Read_Reg2;
                                    end
                     Read_Reg2:
                                    begin
                                           nDIOR <= low;
                                           present_state <= Read_Reg3;       
                                    end
                     Read_Reg3:
                                    begin
                                           if(delay_cnt[2:0]==3'b101)        
                                                  begin
                                                         delay_cnt <= 24'h0;
                                                         present_state <= Read_Reg6;
                                                  end   
											else
												delay_cnt <= delay_cnt + 1'b1;
                                    end
                     Read_Reg6:                                                                         
                                    begin
                                          // nDIOR <= high;
                                           Read_Buffer <= Data_to_from_HD;
                                           present_state <= Read_Reg7;
                                    end
                     Read_Reg7:
                                    begin
                                           //Read_Buffer <= Data_to_from_HD;
                                           nDIOR <= high;
                                           present_state <= Read_Reg5;  
                                    end
                     Read_Reg5:
                                    begin
                                           if(delay_cnt[2]==1'b1)        
                                                  begin
                                                         delay_cnt <= 24'h0;
                                                         present_state <= Read_Reg8;
                                                  end 
											else
												delay_cnt <= delay_cnt + 1'b1;
                                    end
                     Read_Reg8:
                                    begin
                                           nDIOR <= high;
                                           present_state <= breakpoint;   //return;
                                    end
                     default:
                                           present_state <= idle;
                     endcase
              end
//=====================================================================================//
endmodule
	