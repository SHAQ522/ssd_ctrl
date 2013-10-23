module MAC_init(input clk,
				input nRST,
				input waitrequest,
				input[31:0] readdata,
				output reg MAC_pRST,
				output reg read,
				output reg write,
				output reg start,
				output reg[7:0] addr,
				output reg[31:0] writedata);
				
parameter 
			//state machine
			idle=4'd0,RST_over=4'd1,Soft_reset=4'd2,waiting=4'd3, Write_Config=4'd4, complete=4'd5, 
			write_begin=4'd6, write_end=4'd7, read_begin=4'd8,
			
			Command_Config_Reg = 8'd2,
			tx_ena = 1, rx_ena = 2, eth_speed = 8, promis_en = 16,
			pad_ena = 'h20, CRC_FWD = 'h40, TX_ADDR_INS = 'h200, OMIT_CRC = 'h20000,
			sw_reset = 'h2000,
			
			regnum_tx_cmd_stat = 8'd58,regnum_rx_cmd_stat = 8'd59,
			regnum_phy_reg_1_status = 8'd129;

			
				
reg[3:0] state;
reg[3:0] breakpoint;
reg[10:0] delay_cnt;
reg[31:0] read_data;
reg flag;

always@(posedge clk)
if(!nRST)
	begin
		state<=idle;
		MAC_pRST<=1;						//MAC²ãÓ²¼þ¸´Î»								
		read<=0;
		write<=0;
		delay_cnt<=0;
		flag<=0;
	end
else
	begin
		case(state)
				idle:
					begin
						read<=0;
						write<=0;
						MAC_pRST<=0;						//MAC²ãÓ²¼þ¸´Î»	
						start<=0;
						if(flag==0)state<=RST_over;
					end
				RST_over:
					begin
						if(delay_cnt==100)
							begin
								delay_cnt<=0;
								state<=Soft_reset;
							end
						else delay_cnt<=delay_cnt+1'b1;
					end
				Soft_reset:
					begin
						addr<=Command_Config_Reg;			//Èí¸´Î»
						//writedata<=32'h2000;
						writedata<=(tx_ena|rx_ena|eth_speed|promis_en);
						state<=write_begin;
						breakpoint<=waiting;
					end
				waiting:
					begin
						if(delay_cnt==100)
							begin
								state<=read_begin;
								breakpoint<=Write_Config;
								//addr<=regnum_phy_reg_1_status;
								addr<=Command_Config_Reg;
								delay_cnt<=0;
							end
						else delay_cnt<=delay_cnt+1'b1;
					end
					
				Write_Config:
					begin
						/*
						addr<=Command_Config_Reg;
						writedata<=(tx_ena|rx_ena|eth_speed|promis_en);
						state<=write_begin;
						breakpoint<=complete;*/
						if(delay_cnt==500)
							begin
								state<=complete;
								delay_cnt<=0;
							end
						else delay_cnt<=delay_cnt+1'b1;
					end
				complete:
					begin
						if(delay_cnt==100)
							begin
								delay_cnt=0;
								start<=1;//----------posedge edge
								state<=idle;
								flag<=1;
							end
						else delay_cnt<=delay_cnt+1'b1;
					end
					
				write_begin:
					begin
						write<=1;
						if(!waitrequest)
							begin
								write<=0;
								state<=write_end;
							end
					end
				write_end:
					begin
						if(delay_cnt==10)
							begin
								delay_cnt<=0;
								state<=breakpoint;
							end
						else delay_cnt<=delay_cnt+1'b1;
					end
				
				read_begin:
					begin
						read<=1;
						if(!waitrequest)
							begin
								read<=0;
								state<=breakpoint;
								read_data<=readdata;
							end
					end
				default: state<=idle;
			endcase
		end
			
	endmodule
						
								
				
				
		