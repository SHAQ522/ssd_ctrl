module dsp_engress(
		input TFCLK,
		input nRST,
		input reg_end,				//registers configuration concluded
		input[31:0] datain,			//data to be transmited 
		input tx_rdy,
		input start_send,
			
		output reg[9:0] rdaddr,		//data read address
		output reg TENB,			//transmit write enable 0 is valid.when TSX is asserted,TENB is 1.
		output reg TSX,
		output reg TSOP,
		output reg TEOP,
		output reg TERR,
		output reg [1:0]  TMOD,
		output [31:0] TDAT,
		output TPRTY,

		output reg ff_tx_wren,
		output reg ff_crc_fwd,

		output reg[15:0] length,
		output reg[15:0] Header_cnt
		);

reg[4:0] state;	

//====================syncronization for reg_end=============
reg q1,reg_end_syn;
reg [2:0] command_sync;
reg q4,reg_start_send;


always@(posedge TFCLK)
begin
	q1 <= reg_end;
	reg_end_syn <= q1;
end

always@(posedge TFCLK)
begin
	q4 <= start_send;
	reg_start_send <= q4;
end



assign TDAT = TSX?32'd0:({datain[7:0],datain[15:8],datain[23:16],datain[31:24]});

assign	TPRTY = datain[31]+datain[30]+datain[29]+datain[28]+datain[27]+datain[26]+datain[25]+datain[24]+
				datain[23]+datain[22]+datain[21]+datain[20]+datain[19]+datain[18]+datain[17]+datain[16]+
				datain[15]+datain[14]+datain[13]+datain[12]+datain[11]+datain[10]+datain[9]+datain[8]+
				datain[7]+datain[6]+datain[5]+datain[4]+datain[3]+datain[2]+datain[1]+datain[0];

parameter	Idle = 5'd0, Channel_Sel = 5'd1, StartFrame = 5'd2, Transfering = 5'd3, EndFrame = 5'd4, 
			Judge = 5'd5;

reg [24:0] count;
always@(posedge TFCLK or negedge nRST)
	if(!nRST)
		begin
			state <= Idle;
			length <= 16'd55;
			rdaddr <= 0;
			Header_cnt <= 16'd0;
			TENB <= 1'b1;
			TSX <= 1'b0;
			TSOP <= 1'b0;
			TEOP <= 1'b0;
			TERR <= 1'b0;
			TMOD <= 2'b00;
			ff_tx_wren <= 1'b0;
			ff_crc_fwd <= 1'b1;
			count<=0;
		end
	else 
		begin
			case(state)
				Idle:	                    //0
					begin
						ff_tx_wren <= 1'b0;
						rdaddr <= 0;
						Header_cnt <= 16'd0;
						length <= 16'd55;
						TENB <= 1'b1;
						TSX <= 1'b0;
						TSOP <= 1'b0;
						TEOP <= 1'b0;
						TERR <= 1'b0;
						TMOD <= 2'b00;		
						if(reg_end_syn==1 && q1==0)					//&&(command_sync==Open_cmd))//||opend)		
							begin
								state <= Channel_Sel;
							end
						else	
							begin
								state <= Idle;
							end
					end
				Channel_Sel:                //1
					begin		
						rdaddr <= 0;
						TENB <= 1'b1;
						TSX <= 1'b1;
						length <= 16'd55;
						Header_cnt <= 16'd0;
						if(tx_rdy & !reg_start_send & q4)
							state <= StartFrame;	//posedge
					end
				StartFrame:                 //2
					begin
						if(tx_rdy)
						begin
							ff_tx_wren <= 1'b1;
							TENB <= 1'b0;
							TSX <= 1'b0;
							TSOP <= 1'b1;
							TEOP <= 1'b0;
							rdaddr <= rdaddr+1'b1;
							Header_cnt <= Header_cnt+1'b1;
							state <= Transfering;
						end

					end
				Transfering:                 //3
					begin
						if(tx_rdy)
							begin
								ff_tx_wren <= 1'b1;
								TSOP <= 1'b0;
								rdaddr <= rdaddr+1'b1;
								Header_cnt <= Header_cnt+1'b1;                  //Header_cnt¼ÆÊı
								//if(Header_cnt==16'd10)length <= {2'd0,TDAT[31:2]}+16'd6;
								if(Header_cnt==16'd10)length <= TDAT[17:2]+16'd6;
								if(Header_cnt<=length)	
									begin
										state <= Transfering;
									end
								else	
									begin
										state <= EndFrame;
									end
							end
						else ff_tx_wren <= 1'b0;
							
					end
				EndFrame:                    //4
					begin
						if(tx_rdy)
						begin
							ff_tx_wren <= 1'b1;
							TSOP <= 1'b0;
							TEOP <= 1'b1;
							ff_crc_fwd <= 1'b0;
							TMOD <= 2'b10;
							rdaddr <= rdaddr+1'b1;
							state <= Judge;
						end
						else
							ff_tx_wren <= 1'b0;
					end
				Judge:                       //5
					begin
						TEOP <= 1'b0;
						TMOD <= 2'b00;
						TENB <= 1'b1;
						ff_crc_fwd <= 1'b1;
						ff_tx_wren <= 1'b0;
						state <= Channel_Sel;					
					end
							
				default:	state <= Idle;
			endcase
		end
							
endmodule 
