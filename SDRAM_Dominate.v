module SDRAM_Dominate
				(   
//=============================================================================
					input	sys_clk,        				//全局时钟，100MHz
					input	nRST,							//系统复位 
//=============================================================================				
					input	[31:0]	PreFifoData,			//前置fifo的数据
					input	[12:0]	PreFifoNum,
					input	[12:0]	PostFifoNum,				//后置fifo的满信号     		
//================================================================================
					output	reg		PreFifoRdEn,   			//前置fifo的读操作使能
					output	reg	[31:0]	PostFifoWrData,		//后置RAM 的数据 16bits
                    output	reg	PostFifoWrEn,  				//后置RAM 的写操作使能
//===================================================================================
    /**********************SDRAM1的控制线号，地址信号，数据信号********************/
					output 	Sd1_clk,
					output  Sd1_cke,
					output  Sd1_cs,					
					output  Sd1_ras,
					output  Sd1_cas,
					output  Sd1_we,
					output  [1:0] Sd1_ba,
					output  [12:0] Sd1_addr,		
					output  [1:0] Sd1_dqm,
					inout  	[31:0] Sd1_dq,
//==========================================================================================
		/**********************SDRAM的地址控制信号**************************************/	
					input   PingPong,			            //乒乓操作的标志信号 1为写 0为读		
					input	start_wr,						//开始写
					input	[15:0]	wraddr_begin,			//写开始地址
					input	[15:0]	wraddr_end,			    //写结束地址
					input	start_rd,						//开始读
					input	[15:0]	rdaddr_begin,			//读开始地址
					input	[15:0]	rdaddr_end,			    //读结束地址
					output	reg		flag_wr,
					output	reg		flag_rd,		
		/**********************测试信号**************************************************/			
					output	reg		SysInitDone,
					output	reg		stp
				);

//=====================================================================================
reg	FifoEmpty;
always @ (posedge sys_clk or negedge nRST)
	begin
	if(!nRST)
		FifoEmpty<=1'b0;
	else
		if(PreFifoNum<13'd1200)
			FifoEmpty<=1'b1;
		else
			FifoEmpty<=1'b0;
	end
//========================================================================================
//=====================================================================================
reg	FifoFull;
always @ (posedge sys_clk or negedge nRST)
	begin
	if(!nRST)
		FifoFull<=1'b0;
	else
		if(PostFifoNum>13'd3000)
			FifoFull<=1'b1;
		else
			FifoFull<=1'b0;
	end
/***************************************************************************************
							sdram进行初始化
--Steps needed by SDRAM to intitialize

--#1. Power up initialization time taken 100 us, one, either Nop or Inhibit
--    Command is MUST within this period -- as per specs

--#2. PRECHARGE Command MUST be issued

--#3. 8 AUTO REFRESH cycles MUST be performed

--#4. Mode Register may be programmed now.

--Steps needed by SDRAM to initialize Ends
****************************************************************************************/
/*******************************************************************************************/
parameter 	Inhibit  		= 6'b111111,
			Nop     		= 6'b011111,
			Active  		= 6'b001100,
			Read    		= 6'b010100, 
			Write   		= 6'b010000, 
			Precharge  		= 6'b001011,
			AutoRef    		= 6'b000111,
			LoadModeReg  	= 6'b000011;
			
/***********************************************/
reg	[5:0] InitCmdBus;
/***********************************************
  --bit 5 = cs
  --bit 4 = ras
  --bit 3 = cas
  --bit 2 = we
  --bit 1 = dqm(1)
  --bit 0 = dqm(0)
**************************************************/
/*******************************************************************************************/
reg	[3:0]	InitCounter4;
reg	[4:0]	InitCounter5;
reg	[15:0]	InitCounter16;
reg	[1:0]	InitSdBa;
reg	[12:0]	InitSdAddr;

//=====================================================================================
reg	[4:0]	InitSdState;
parameter	 Wait100us=5'b00001,PrechargeAllBank=5'b00010,
			  Refresh8times=5'b00100,SetModeRregister=5'b01000,InitFnish=5'b10000;
//======================================================================================
always @ (posedge sys_clk or negedge nRST)
	begin
	if(!nRST)
		begin	
		InitCounter4<=4'd0;
		InitCounter5<=5'd0;
		InitCounter16<=0;
		InitCmdBus[5]<=1'b1;
		SysInitDone<=1'b0;
		InitSdState<=Wait100us;
		end
	else
		begin
		case (InitSdState)
		Wait100us:
			begin
			SysInitDone<=1'b0;	
			if(InitCounter16==16'd14000) 
				begin
				InitCounter16<=0;
				InitSdState<=PrechargeAllBank;
				end
			else
				begin
				InitCmdBus[5]<=1'b1;
				InitCounter16<=InitCounter16+1'b1;
				end
			end
		PrechargeAllBank:
			begin
			if(InitCounter4==4'd0)
				begin
				InitCmdBus<=6'b001011;
				InitSdAddr[10]<=1'b1;
				InitCounter4<=InitCounter4+4'd1;
				end
			else if(InitCounter4<=4'd3)
				begin
				InitCmdBus[5]<=1'b1;
				InitCmdBus<=Inhibit;
				InitCounter4<=InitCounter4+4'd1;
				end
			else
				begin					
				InitCounter4<=4'd0;
				InitSdState<= Refresh8times;
				end				
			end
		Refresh8times:
			begin
			if(InitCounter5<=5'd7)
				begin
				if(InitCounter4==4'd0)
					begin
					InitCmdBus<=6'b000111;
					InitCounter4<=InitCounter4+4'd1;
					end
				else if(InitCounter4<=4'd10)
					begin
					InitCmdBus[5]<=1'b1;
					InitCmdBus<=Inhibit;
					InitCounter4<=InitCounter4+4'd1;
					end
				else
					begin					
					InitCounter4<=4'd0;
					InitCounter5<=InitCounter5+5'd1;
					end
				end		
			else
				begin
				InitCounter4<=4'd0;
				InitCounter5<=5'd0;
				InitSdState<=SetModeRregister;					
				end		
			end				
/*******************************************************************************************
SetModeRregister:
-- ll,10 = reserved, 
-- 9 = '0' programmed burst length, Burst len applicable for rd and wr both 
-- 8,7 = Op mode = 00
-- 6,5,4 = CAS latency = 010 = cas latency of 2 
-- 3 = Burst Type = '0' = Sequential
-- 2,1,0 = Brust Length = 111 = Full Page Brust
*********************************************************************************************/							
		SetModeRregister:
			begin
			if(InitCounter4==4'd0)
				begin
				InitSdBa<=2'b00;
				InitCmdBus<=6'b000011;
				InitSdAddr<=13'b0_0000_0011_0111;//CL=3;BL=Full Page
				InitCounter4<=InitCounter4+4'd1;
				end
			else if(InitCounter4<=4'd3)
				begin
				InitCmdBus[5]<=1'b1;
				InitCmdBus<=Inhibit;
				InitCounter4<=InitCounter4+4'd1;
				end
			else
				begin	
				SysInitDone<=1'b0;
				InitCmdBus[1:0]<=2'b00;		
				InitCounter4<=4'd0;
				InitSdState<=InitFnish;
				end				
			end
		InitFnish:
				begin
				SysInitDone<=1'b1;
				InitCmdBus[5]<=1'b1;
				InitCmdBus<=Inhibit;
				InitSdState<=InitFnish;	
				end
		endcase
		end
	end
//=====================================================================================
 /***************************************************************************************
							sdram进行写操作
--Steps needed by SDRAM to write data

--#1). Get the address from up, store the address, Activate the corresponding
--     Row. by providing A0 to A12(which will select the ROW) and BA0, BA1
--     which will select the Coloumn
--
--#2). Wait for trcd = 15 ns  while putting Nop on the command bus
--     provide  A0 through A9, A11 in case of (x4), A0 through A9 in case of
--     (x8) , A0 through A8 in case of (x16). We will use (x8)
--#3). Issue the Coloumn address with the choice of A10 = 0 for Disable Auto
--     Precharge, A10 = 1 for Enable Auto Precharge.We will use Auto Precharge
--     DISABLED But here in case of Burst length = full page we do not need
--     A10 functiionality since it is not used in this cycle.
****************************************************************************************/
 //--------------------------------------------------------------------------------------
reg	[3:0]  	WrState;
parameter IdleWr=4'b0001,Data2Write=4'b0010,SdramWrite=4'b0100,WrSdramRefresh=4'b1000;
//================================================================================
reg	[15:0] SysWrAddr;		//sdram的写地址，位数=bank位数+行宽位数
reg	[1:0]	WrSdBa;
reg	[12:0]	WrSdAddr;
reg [31:0] WrSdData;

reg			WrRefAck;			//写刷新请求的应答信号
reg	[3:0]	WrCounter4;
reg	[4:0]	WrCounter5;
reg	[15:0]	WrCounter16;
/*********************************************************************/
reg	[5:0] 	WrCmdBus;
/*********************************************************************/
//===============================================================================
always @(posedge sys_clk or negedge  nRST )
begin
	if(!nRST)
		begin
		WrState <= IdleWr;
		WrSdData  <= 32'd0;
		WrCmdBus[5]<=1'b1;
		SysWrAddr <= 16'd0; 
		WrRefAck<=1'b1;
		WrCounter16<=0;
		WrCounter5<=0;
		WrCounter4<=0;
		PreFifoRdEn<=1'b0;
		flag_wr <= 1'b0;//----------------------------处于写等待状态
		end
	else if(!SysInitDone)
		begin
		WrState <= IdleWr;
		WrSdData  <= 32'd0;
		WrCmdBus[5]<=1'b1;//
		SysWrAddr <= 16'd0;  // 
		WrRefAck<=1'b1;
		WrCounter16<=0;
		WrCounter5<=0;
		WrCounter4<=0;
		PreFifoRdEn<=1'b0;
		flag_wr <= 1'b0;//----------------------------处于写等待状态
		end
	else
		begin
		case(WrState)
			IdleWr: 
			begin
			if(WrRefEn)		//如果有写刷新请求就进行刷新动作
				begin
				WrState<=WrSdramRefresh;
				WrRefAck<=1'b0;
				end
			else 
				begin
				if((start_wr) & (SysWrAddr < wraddr_end))
					begin
					flag_wr <= 1'b1;//----------------------------写状态
					PreFifoRdEn<=1'b0;
					WrState <= Data2Write;
					end
				else if((start_wr) & (SysWrAddr >= wraddr_end))
					begin
					flag_wr <= 1'b0;//----------------------------写完等待状态
					PreFifoRdEn<=1'b0;
					WrState <= IdleWr;
					end
				else 
					begin
					SysWrAddr <= wraddr_begin; 
					flag_wr <= 1'b0;//----------------------------处于写等待状态
					WrState<=IdleWr;
					end
				end
			end
		Data2Write:
				begin
					if(!FifoEmpty)
					begin
					 flag_wr <= 1'b1;//------------------------处于写状态
					 WrState <= SdramWrite;
					end
				 end
		SdramWrite:
				begin				
				if(WrCounter16==16'd0)//Active Command
					begin
					WrCmdBus<=6'b001100;		
					WrSdBa<=SysWrAddr[14:13]; 	//bank
					WrSdAddr<=SysWrAddr[12:0];	//row address
					WrCounter16<=WrCounter16+4'd1;
					end
				else if(WrCounter16<16'd2)
					begin
					WrCmdBus[5]<=1'b1;
					WrCounter16<=WrCounter16+1'b1;
					end
				else if(WrCounter16==16'd2)
					begin
					WrCounter16<=WrCounter16+1'b1;
					PreFifoRdEn <= 1'b1;
					end
				else if(WrCounter16==16'd3)//Write Command 写入一行的第一个数据
					begin
					PreFifoRdEn <= 1'b1;
					WrSdData  <= PreFifoData;
					WrCmdBus<=6'b010000;//
					WrSdBa<=SysWrAddr[14:13];					
					WrSdAddr[10]<=1'b0;
					WrSdAddr[9:0]<=10'd0;
					WrCounter16<=WrCounter16+1'b1;
					end
				else if(WrCounter16<16'd1026)//the next 1022 datas
					begin
					WrCmdBus[5]<=1'b1;
					/*************************************************/
					PreFifoRdEn <= 1'b1;
					WrSdData  <= PreFifoData;
					/*************************************************/
					WrCounter16<=WrCounter16+1'b1;
					end
				else if(WrCounter16==16'd1026)//the last data
					begin
					WrCmdBus[5]<=1'b1;
					WrCounter16<=WrCounter16+1'b1;
					/*************************************************/
					PreFifoRdEn <= 1'b0;
					WrSdData  <= PreFifoData;
					/*************************************************/
					end
				else if(WrCounter16==16'd1027)//precharge  因为全页的突发写和读都无自动预充电的操作，所以在读或写完之后必须进行预充电。
					begin
					WrCmdBus<=6'b001011;//
					WrSdBa<=SysWrAddr[14:13];
					WrSdAddr[10]<=1'b0;	
					WrCounter16<=WrCounter16+1'b1;
					end		
				else if(WrCounter16<1031) //263
					begin
					WrCmdBus[5]<=1'b1;//
					WrCounter16<=WrCounter16+1'b1;
					end	
				else if(WrCounter16==1031) //263
					begin
					WrCmdBus[5]<=1'b1;
					WrCounter16<=WrCounter16+1'b1;
					SysWrAddr<=SysWrAddr+1'b1;
					end		
				else
					begin
					if(WrCounter5<=5'd2)					//进行一次写操作后刷性两次
						begin
						if(WrCounter4==4'd0)
							begin
							WrCmdBus<=6'b000111;//
							WrCounter4<=WrCounter4+4'd1;
							end
						else if(WrCounter4<=4'd10)
							begin
							WrCmdBus[5]<=1'b1;//
							WrCounter4<=WrCounter4+4'd1;
							end
						else
							begin					
							WrCounter4<=4'd0;
							WrCounter5<=WrCounter5+5'd1;
							end
						end		
					else
						begin
						WrCounter4<=4'd0;
						WrCounter5<=5'd0;
						WrCmdBus[5]<=1'b1;
						WrCounter16<=0;
						WrState <= IdleWr;					
						end		
					end
				end
		WrSdramRefresh:
				begin
				if(WrCounter4 == 4'd0)
					begin
					WrCmdBus<=6'b000111;
					WrCounter4<=WrCounter4+4'd1;
					WrRefAck<=1'b0;
					end
				else if(WrCounter4<=4'd10)
					begin
					WrCmdBus[5]<=1'b1;//
					WrCounter4<=WrCounter4+4'd1;
					WrRefAck<=1'b1;
					end
				else
					begin					
					WrCounter4<=4'd0;
					WrState <= IdleWr;	
					end
				end	
		default:
				begin                             
				WrState <= IdleWr;
				end
	endcase          
		
	  end 
end
//-------------------------------------------------------------------------------------
  /***************************************************************************************
							sdram进行读操作
****************************************************************************************/ 	
reg	PingLock;
/************************************************************************************/
always@(posedge	sys_clk	or negedge nRST)
begin
	if(!nRST)
		PingLock<=1'b0;
	else
		begin
		if(!SysInitDone)
			PingLock<=1'b0;
		else
			PingLock <= PingPong;
		end
end
//=============================================================================================== 
	reg		ClearFlag;				//读使能的清零信号
	reg		RdRefAck;
	reg		[15:0]		SysRdAddr;		//sdram读地址
	reg		[1:0]		RdSdBa;
	reg		[12:0]		RdSdAddr;
	wire	[31:0] 	RdSdData;   
	reg		[5:0] 		RdCmdBus; 
//-------------------------------------------------------------------------------------
	reg		[3:0]		RdCounter4;
	reg		[4:0]		RdCounter5;
	reg		[15:0]		RdCounter16;
//------------------------------------------------------------------------------------- 
	reg		RdIdleFlag;				//上一状态处于IdleRd状态的标志信号
	reg		[2:0]		RdDelay;
//-------------------------------------------------------------------------------------
	reg	[3:0] 	RdState;
    parameter IdleRd=4'b0001,Data2Read=4'b0010,SdramRead=4'b0100,RdSdramRefresh=4'b1000;
//-------------------------------------------------------------------------------------
    always @(posedge sys_clk or negedge nRST )
     begin
		if(!nRST)		
			begin
            RdState <= IdleRd;
            PostFifoWrEn <= 1'd0;
			RdCounter4<=4'd0;
			RdCounter5<=5'd0;
			RdCmdBus[5]<=1'b1;
			RdCounter16<=0;
			ClearFlag<=0;
			SysRdAddr<=0;
			RdRefAck<=1'b1;
			RdIdleFlag<=0;
			RdDelay<=0;
			flag_rd <= 1'b0;
			end
       else	if(!SysInitDone)		
			begin
            RdState <= IdleRd;
            PostFifoWrEn <= 1'd0;
			RdCounter4<=4'd0;
			RdCounter5<=5'd0;
			RdCmdBus[5]<=1'b1;//
			RdCounter16<=0;
			ClearFlag<=0;
			SysRdAddr<=0;
			RdRefAck<=1'b1;
			RdIdleFlag<=0;
			RdDelay<=0;
			flag_rd <= 1'b0;
			end
       else
			begin
			case(RdState)
				IdleRd:
					begin
					if(start_rd)
						begin
						SysRdAddr<=rdaddr_begin;
						RdState <= Data2Read;
						ClearFlag<=1'b1;
						RdIdleFlag<=0;
						end	
					 else if(!start_rd)
						begin
						SysRdAddr<=rdaddr_begin;
						PostFifoWrEn <= 1'd0; 
						flag_rd <= 1'b0;
						if(RdRefEn)
							begin
							RdState<=RdSdramRefresh;
							RdRefAck<=1'b0;
							RdIdleFlag<=1;
							end
						else
							begin
							RdState <= IdleRd;
							RdIdleFlag<=0;
							end
						end
					 end 
				Data2Read:                           
                    begin
					PostFifoWrEn <= 1'd0;
					ClearFlag<=1'b0;
					flag_rd <= 1'b1;
					if(RdRefEn)
						begin
						RdState<=RdSdramRefresh;
						RdRefAck<=1'b0;
						end
					else
						begin
						if(!FifoFull)
							begin
							if(SysRdAddr==rdaddr_end)
								begin
								RdState <= IdleRd;
								end
							else
								begin
								RdState <= SdramRead;
								end
							end
						else
							begin
							RdState <= Data2Read;
							end
						end
                     end  
				SdramRead:
					begin
					PostFifoWrData <= RdSdData;
					if(RdCounter16==0)//Active Command
						begin
						RdCmdBus<=6'b001100;
						RdSdBa<=SysRdAddr[14:13]; //bank
						RdSdAddr<=SysRdAddr[12:0];//row address
						RdCounter16<=RdCounter16+4'd1;
						end
					else if(RdCounter16<3)
						begin
						RdCmdBus[5]<=1'b1;//
						RdCounter16<=RdCounter16+1'b1;
						end
					else if(RdCounter16==3)//Read Command
						begin
						RdCmdBus<=6'b010100;//
						RdSdBa<=SysRdAddr[14:13];					
						RdSdAddr[10]<=1'b0;
						RdSdAddr[9:0]<=10'd0;
						RdCounter16<=RdCounter16+1'b1;
						end
					else if(RdCounter16==4)
						begin
						RdCmdBus[5]<=1'b1;//
						if(RdDelay<=3'd2)
							begin
							RdDelay<=RdDelay+1'b1;
							end
						else
							begin
							RdCounter16<=RdCounter16+1'b1;
							RdDelay<=3'd0;
							end
						end
					else if(RdCounter16<1027)//the 1~1022 datas 
						begin
						RdCmdBus[5]<=1'b1;
						RdCounter16<=RdCounter16+1'b1;
						PostFifoWrData <= RdSdData;
						PostFifoWrEn <=1'b1;
						end
					else if(RdCounter16==16'd1027)//precharge  the 1023 data
						begin
						RdCmdBus<=6'b001000;
						RdSdBa<=SysRdAddr[14:13];
						RdSdAddr[10]<=1'b0;
						RdCounter16<=RdCounter16+1'b1;
						PostFifoWrData <= RdSdData;
						PostFifoWrEn <= 1'd1;
						end		
					else if(RdCounter16==16'd1028) //the 1024 data
						begin
						RdCmdBus[5]<=1'b1;//
						RdCounter16<=RdCounter16+1'b1;
						PostFifoWrData <= RdSdData;
						end
					else if(RdCounter16==16'd1029)  
						begin
						RdCounter16<=RdCounter16+1'b1;
						SysRdAddr<=SysRdAddr+1'b1;
						PostFifoWrData <= RdSdData;
						PostFifoWrEn <= 1'd0;
						end
					else if(RdCounter16<1033)  
						begin
						RdCmdBus[5]<=1'b1;
						RdCounter16<=RdCounter16+1'b1;
						end
					else
						begin
						if(RdCounter5<=5'd2)
							begin
							if(RdCounter4==4'd0)
								begin
								RdCmdBus<=6'b000111;
								RdCounter4<=RdCounter4+4'd1;
								end
							else if(RdCounter4<=4'd10)
								begin
								RdCmdBus[5]<=1'b1;
								RdCounter4<=RdCounter4+4'd1;
								end
							else
								begin					
								RdCounter4<=4'd0;
								RdCounter5<=RdCounter5+5'd1;
								end
							end		
						else
							begin
							RdCounter4<=4'd0;
							RdCounter5<=5'd0;
							RdCmdBus[5]<=1'b1;
							RdCounter16<=16'd0;
							RdState <= Data2Read;						
							end		
						end								
					end
			RdSdramRefresh:
					begin
					if(RdCounter4==4'd0)
						begin
						RdCmdBus<=6'b000111;//
						RdCounter4<=RdCounter4+4'd1;
						RdRefAck<=1'b0;
						end
					else if(RdCounter4<=4'd10)
						begin
						RdCmdBus[5]<=1'b1;//
						RdCounter4<=RdCounter4+4'd1;
						RdRefAck<=1'b1;
						end
					else
						begin					
						RdCounter4<=4'd0;
						if(RdIdleFlag)
							begin
							RdState <= IdleRd;
							RdIdleFlag<=0;
							end
						else
							begin
							RdState <= Data2Read;
							end	
						end
					end
                default:
                          begin
                          RdState <= IdleRd;
                          end 
				
           endcase
			end
      end 
/***************************************************************************************
							sdram进行写操作刷新请求
****************************************************************************************/ 
reg	[10:0]	WrCountReg;
reg	WrRefEn;
//===========================================
always@(posedge	sys_clk or	negedge	nRST)
	begin
	if(!nRST)
		begin
		WrRefEn<=1'b0;
		WrCountReg<=0;
		end
	else if(!SysInitDone)
		begin
		WrRefEn<=1'b0;
		WrCountReg<=0;
		end
	else if(!WrRefAck)
		begin
		WrRefEn<=1'b0;
		WrCountReg<=0;
		end
	else
		begin
		if(WrCountReg<=780)//8192行时就为7.8125μs
			begin
			WrCountReg<=WrCountReg+1'b1;
			WrRefEn<=1'b0;
			end
		else
			begin
			WrRefEn<=1'b1;
			end
		end
	end
/***************************************************************************************
							sdram进行读操作刷新请求
The SDRAM MUST be AUTO REFERESHED every 7.81 us or 7810 ns
if f is the clock freq, then T = 1/f, so n * 1/F = 7810,so n=7.81*f in MHz
Here f = 100 MHz, so n = 781. Every 781 clocks, an Auto Ref is needed.
It may be possible, to apply 8192 Auto refs Once in 64 ms or Once in
64000 * f in HHz clock cycles, we take f  100 MHz, so every 6400000 clock 
cycles, we need a burst of 8192 Auto refereshs
对每个bank的同一行地址的行进行刷新							
****************************************************************************************/ 
reg	[10:0]	RdCountReg;
reg	RdRefEn;
//===========================================
always@(posedge	sys_clk or	negedge	nRST)
	begin
	if(!nRST)
		begin
		RdRefEn<=1'b0;
		RdCountReg<=0;
		end
	else if(!SysInitDone)
		begin
		RdRefEn<=1'b0;
		RdCountReg<=0;
		end
	else if(!RdRefAck)
		begin
		RdRefEn<=1'b0;
		RdCountReg<=0;
		end
	else
		begin
		if(RdCountReg<=780)//8192行时就为7.8125μs
			begin
			RdCountReg<=RdCountReg+1'b1;
			RdRefEn<=1'b0;
			end
		else
			begin
			RdRefEn<=1'b1;
			end
		end
	end
//==========================================================================================
assign Sd1_cke = 1'b1;
//=====================================================================================================================
assign	  {Sd1_cs,Sd1_ras,Sd1_cas,Sd1_we,Sd1_dqm} = (!SysInitDone)?{InitCmdBus}:((PingPong)?WrCmdBus:RdCmdBus);
assign		{Sd1_ba,Sd1_addr} = (!SysInitDone)?{InitSdBa,InitSdAddr}:((PingPong)?{WrSdBa,WrSdAddr}:{RdSdBa,RdSdAddr});
assign	 Sd1_dq=(PingPong)? WrSdData: 32'hzzzzzzzz;
assign 		RdSdData = Sd1_dq;
//===================================================================================== 
//===========================
//reg stp;                                             //作为测试SDRAM数据的测试代码
always @(posedge sys_clk or negedge nRST)      
begin
  if(!nRST)
	stp <= 1'b0;
  else if((PingPong != PingLock) && (RdState != IdleRd))
	stp <= 1'b1;
  else 
	stp <= 1'b0;
end
   
//=======================================================================================
endmodule  
  