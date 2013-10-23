module crc_and_count(
			input clk,
			input crc_init,
			input [15:0] Data_in,
			input [4:0] RAM_IN_WADDR,
			
			output reg [15:0] CRCOUT,
			output reg [24:0] ide_read_num,
			output reg [4:0]  RAM_IN_RADDR,
			
			output reg [15:0] ide_r_data,
			output reg ide_r_data_active,
			output reg [9:0] rdata_mem_addr,
			output reg is_working
			);


reg [15:0] DD;
wire [16:1] FDBK;
wire [15:0] CRCIN;
		

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


reg [4:0] RAM_IN_WADDR_s1,RAM_IN_WADDR_s2;

always @(posedge clk)
begin
	RAM_IN_WADDR_s1<=RAM_IN_WADDR;
	RAM_IN_WADDR_s2<=RAM_IN_WADDR_s1;
	
	if((RAM_IN_WADDR_s2!=RAM_IN_RADDR) || (state==get_crc))
		is_working<=1;
	else
		is_working<=0;	
end

reg [3:0] state;
parameter idle=4'd0,get_crc=4'd1;
reg get_a_crc;
always @(posedge clk or posedge crc_init)
if(crc_init)
begin
	ide_read_num<=0;
	ide_r_data_active<=0;
	RAM_IN_RADDR<=0;
	state<=idle;
end
else
	case(state)
	idle:
	begin
		ide_r_data_active<=0;
		if(RAM_IN_WADDR_s2!=RAM_IN_RADDR)
		begin
			RAM_IN_RADDR<=RAM_IN_RADDR+5'd1;
			state<=get_crc;	
		end
	end
	get_crc:
	begin
		ide_r_data_active<=1;
		ide_r_data<=Data_in;
		ide_read_num<=ide_read_num+25'd1;
		state<=idle;		
	end
	endcase
	
always @(posedge clk or posedge crc_init)
if(crc_init)
begin
	CRCOUT<=16'h4ABA;
	get_a_crc<=0;
end
else
begin
	if(ide_r_data_active)
	begin
		DD<=ide_r_data;
		get_a_crc<=1;
	end
	else 
	begin
		DD<=DD;
		get_a_crc<=0;
	end
	
	if(get_a_crc)
		CRCOUT<=CRCIN;
end
		

	
always @(posedge clk or posedge crc_init)
if(crc_init)
	rdata_mem_addr<=0;
else
	if(ide_r_data_active)
		rdata_mem_addr<=rdata_mem_addr+10'd1;
	
endmodule
