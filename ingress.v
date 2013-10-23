module ingress(
		input RFCLK,
		input RSX_in,			//Start of transfer
		input RSOP_in,			//Start of packet
		input REOP_in,			//End of packet
		input RERR,			//Receive error indicator, *unused*
		input [1:0] RMOD,	//Received word modulo
		input [31:0] RDAT,	//Received data
		input RPRTY,		//Receive parity, *unused*
		input RVAL_in,			//data valid on the channel
		
		output RENB,	//Receive read enable, "0"
//==============================
		output reg[31:0] dataout,
		output reg[9:0] wraddr,
		output reg wrreq,
//==============================
		output reg frame_sync,		//"frame" here is identical to one picture
		output reg Acq_on,		//indicate that the device has responsed, "1"
		
		input condition_SP,
		input condition_EH,
		input condition_PL,
		input condition_ST,
		input[1:0] condition_length,
		input[1:0] condition_length2,
		output reg[4:0] Header_count,
		
		output reg[31:0] packet_cnt,
		output reg[9:0] photo_cnt,
		
		output reg MODE_SET,
		output reg feedback,
		
		input cmd_end,
		input nRST_Pixel
		);
		

//==================== register ====================
reg RSX,RSOP,REOP,RVAL;
always@(posedge RFCLK)
begin
	RSX <= RSX_in;
	RSOP <= RSOP_in;
	REOP <= REOP_in;
	RVAL <= RVAL_in;
end

//reg[10:0] packet_cnt = 11'd0;			//adopted to count the packet recieved
reg[13:0] delay_cnt;
//reg[4:0] Header_count;

reg channel;
reg [11:0] length;

parameter	Height	= 12'd1024;
parameter	Width	= 12'd1392;			

//============Big_Endian to Little_Endian	=============
always@(posedge RFCLK)
begin
		dataout <= {						
					RDAT[0],RDAT[1],RDAT[2],RDAT[3],RDAT[4],RDAT[5],RDAT[6],RDAT[7],
					RDAT[8],RDAT[9],RDAT[10],RDAT[11],RDAT[12],RDAT[13],RDAT[14],RDAT[15],
					RDAT[16],RDAT[17],RDAT[18],RDAT[19],RDAT[20],RDAT[21],RDAT[22],RDAT[23],
					RDAT[24],RDAT[25],RDAT[26],RDAT[27],RDAT[28],RDAT[29],RDAT[30],RDAT[31]
				};
end
//=======================================================			
				
assign RENB = 1'b0;

parameter	MAC_addressHOST = 48'h000B6ADE36F2,		//MAC address of the HOST
			MAC_addressDEVICE = 48'h000F3100FDEE,	//MAC address of the DEVICE
			MAC_addressPC = 48'h0019E075BFFD,		//MAC address of my PC
			IP_HOST = 32'hA9FE0101,					//IP address of the HOST
			IP_DEVICE = 32'hA9FE010A;				//IP address of the DEVICE
			


//===============	state machine	==========================
parameter	Idle = 5'd0, Start_transfer = 5'd1, Start_packet = 5'd2, Extract_Header = 5'd3, 
			Start_frame = 5'd4, Payload = 5'd5,	Storage = 5'd6, ExtractH_2 = 5'd7; 
			
reg[4:0] state = Idle;

always@(posedge RFCLK or negedge nRST_Pixel)
	if(!nRST_Pixel)
		begin
			wraddr <= 10'd0;
			wrreq <= 1'b0;
			frame_sync <= 1'b0;
			Header_count <= 5'd0;
			Acq_on <= 1'b0;
			length <= 12'd0;
			photo_cnt <= 10'd0;
			state <= Idle;
			
			feedback <= 0;
			MODE_SET <= 0;
		end
	else
		begin
			case(state)
				Idle:
					begin
						wraddr <= 10'd0;
						wrreq <= 1'b0;
						frame_sync <= 1'b0;
						Header_count <= 5'd0;
						Acq_on <= 1'b0;
						length <= 12'd0;
						MODE_SET <= 0;
						if(!cmd_end)
							state <= Start_transfer;
						else
							state <= Idle;
					end
				Start_transfer:
					begin
						if(RSX&&(!RVAL))	
							begin
								Header_count <= Header_count+1'b1;
								state <= Start_packet;
							end
						else 
							begin
								Header_count <= 5'd0;
								state <= Start_transfer;
							end
					end
				Start_packet:
					begin
					if(RVAL)
						if(RSOP)//&&condition_SP)//&&(dataout==MAC_addressHOST[47:16]))	//destination ahead of the FRAME conformed with the HOST	
							begin
								Header_count <= Header_count+1'b1;
								state <= Extract_Header;
							end
						else	state <= Start_packet;
					else	state <= Start_packet;
					end
				Extract_Header:
					begin
					if(RVAL)
						begin
							Header_count <= Header_count+1'b1;
							if(condition_EH)//(Header_count==5'd10)
								case(condition_length)//(dataout[11:0])							
									2'd2://12'h410:						//data length is 1024+8+8 Bytes(410), payload of frame (PacketSize is 1060)
										begin
											length <= dataout[11:0];
											state <= ExtractH_2;
											feedback <= 0;
										end
									default:	
										begin
											state <= Start_transfer;
										end								
								endcase
							else	state <= Extract_Header;
						end
					else	state <= Extract_Header;
					end
//====================== judge between command and data from PC =========================
				ExtractH_2:
					begin
						Header_count <= Header_count+1'b1;
						case(condition_length2)//(dataout[15:0])
							2'd1://16'h0100:						//stand for frame_start
								begin
									frame_sync <= 1'b1;
									Acq_on <= 1'b1;
									state <= Payload;						
									MODE_SET <= 0;		//data from PC
								end
							2'd2://16'h0300:						//stand for Payload
								begin
									length <= Width+12'd16;
									state <= Payload;				
									MODE_SET <= 1;		//command from PC
								end
							default:	
								begin
									Header_count <= 5'd0;
									state <= Start_transfer;
									MODE_SET <= 0;
								end								
						endcase
					end
//========================================================================

				Payload:
					begin
					if(RVAL)
						begin
							frame_sync <= 1'b0;
							Header_count <= Header_count+1'b1;
							if(condition_PL)//(Header_count==5'd12)
								begin
									wrreq <= 1'b1;			//write request for pixel data
									state <= Storage;
								end
							else	state <= Payload;
						end
					else	state <= Payload;
					end
				Storage:
					begin
					if(RVAL)
						begin
							Header_count <= 5'd0;
							wraddr <= wraddr+1'b1;			
							if(condition_ST)//(wraddr[8:0]==((length-14)>>2))		//PixelNum = (length-14)/4(DW)+1(W);
								begin
									wraddr[8:0] <= 9'd0;
									wraddr[9] <= ~wraddr[9];
									wrreq <= 1'b0;
									state <= Start_transfer;
									
//=========================== feedback to PC =================================									
									if(!MODE_SET)
										begin
											packet_cnt <= packet_cnt+1'b1;
											if(packet_cnt[9:0]==10'h3ff)
												begin
													feedback <= 1;
												end
										end
									
//==============================================================
								end
							else	state <= Storage;
						end
					else	state <= Storage;
					end
				default:	state <= Idle;
			endcase
		end
		
endmodule
						
						
							
	
	
	
	
	
	
	
	
	