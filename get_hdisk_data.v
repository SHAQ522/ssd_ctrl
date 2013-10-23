module get_hdisk_data(
	input clk,
	input pRST,
	input IORDY,
	input [15:0] DD,
	input IDE_r_en,
	
	output reg [15:0] Data_out,
	output reg Data_out_en,
	output reg [4:0] Addr_watch,
	output reg [4:0] RAM_WADDR
	);
	
reg IORDY_s1,IORDY_s2,IORDY_s3;
reg [15:0] DD_s1,DD_s2;
reg IDE_r_en_s1,IDE_r_en_s2;
reg get_data_en;
always @(posedge clk)
begin
	IORDY_s1<=IORDY;
	IORDY_s2<=IORDY_s1;
	IORDY_s3<=IORDY_s2;
	
	DD_s1<=DD;
	DD_s2<=DD_s1;
	
	IDE_r_en_s1<=IDE_r_en;
	IDE_r_en_s2<=IDE_r_en_s1;
	
	Data_out<=DD_s2;
	
	RAM_WADDR<=Addr_watch[4:0];
end

always @(posedge clk or posedge pRST)
if(pRST)
begin
	Data_out_en<=0;
end
else
begin
	if((IORDY_s2!=IORDY_s3) && (IDE_r_en_s2==1))
	begin
		Data_out_en<=1;
	end
	else
	begin
		Data_out_en<=0;
	end
end

always @(posedge clk or posedge pRST)
if(pRST)
	Addr_watch<=0;
else
	if(Data_out_en)
		Addr_watch<=Addr_watch+5'd1;

endmodule
