module IDE_IO_controller(
			input pRST,
			input clk,
			
			input  IDE_busy,
			input  begin_save,		
			input  nWR_in,	
			output reg IDE_command,
			output reg [16:0] IDE_Sec_Count,
			output reg [47:0] IDE_LBA,
			output reg IDE_nWR,
			
			input [12:0] wfifo_usedw,
			output reg IDE_w_almost_empty,
			
			input [12:0] rfifo_usedw,
			output reg IDE_r_almost_full,
			output reg IDE_r_go_on,
			
			input [47:0] begin_lba,
			input [47:0] end_lba
			);

always @(posedge clk)
begin
	if(wfifo_usedw<=12'd4)
		IDE_w_almost_empty<=1'd1;
	else
		IDE_w_almost_empty<=1'd0;
end

always @(posedge clk)
begin
	if(rfifo_usedw>=13'd8182)
		IDE_r_almost_full<=1'd1;
	else
		IDE_r_almost_full<=1'd0;
end

always @(posedge clk)
	if(rfifo_usedw<=13'd7680)
		IDE_r_go_on<=1;
	else
		IDE_r_go_on<=0;
		
reg [4:0] state;
reg first_begin;
reg begin_save_s1;
reg begin_save_s2;
reg begin_save_s3;
reg IDE_busy_reg;
reg nWR_in_reg;

reg [47:0]begin_lba_reg;
reg [47:0]end_lba_reg;

always @(posedge clk)
begin
	begin_save_s1<=begin_save;
	begin_save_s2<=begin_save_s1;
	begin_save_s3<=begin_save_s2;
	begin_lba_reg<=begin_lba;
	end_lba_reg<=end_lba;
	IDE_busy_reg<=IDE_busy;
	nWR_in_reg<=nWR_in;
end

reg [47:0] now_lba;
parameter idle=5'd0,send_a_command=5'd1,wait_ide_work=5'd3;
always @(posedge clk or posedge pRST)
if(pRST)
begin
	IDE_command<=1'd0;
	state<=idle;
	first_begin<=0;
	
end
else
	case(state)
	idle:
	begin
		IDE_command<=1'd0;
		if(begin_save_s3==0)
		begin
			now_lba<=begin_lba_reg;
		end
		if((IDE_busy_reg==1'd0) && (begin_save_s3==1) && (now_lba<end_lba_reg))
		begin
			state<=send_a_command;
		end
	end
	send_a_command:
	begin
		first_begin<=1;
		IDE_command<=1'd1;
		IDE_nWR<=nWR_in;
		IDE_LBA<=now_lba;
		
		if(end_lba_reg>now_lba+48'h10000)// no use
		begin
			now_lba<=now_lba+48'h10000;
			IDE_Sec_Count<=17'h10000;
		end
		else
		begin
			if(nWR_in_reg==0)
				now_lba<=end_lba_reg;
			else
				now_lba<=begin_lba_reg;//if read we do again				
			IDE_Sec_Count<=end_lba_reg-now_lba;
		end
		
		state<=wait_ide_work;
	end
	wait_ide_work:
	begin
		if(IDE_busy_reg==1'd1)
			state<=idle;
	end
	endcase
	
endmodule


