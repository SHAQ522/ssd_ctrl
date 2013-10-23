module sata_datain_control(
	input clk,
	input nRST,
	input [15:0] data_in,
	input[12:0] usedw,
	input[11:0] ATA1_wrusedw,
	output [15:0]data_out_1,
	output reg rdreq,
	output reg [31:0]err_cnt
	);
//===================================	
assign data_out_1 = data_in[15:0];//此处如果在always中对data_out赋值，则可能出现0000变为0400的错误
//===================================	
wire fifo_ready, almost_empty;
assign almost_empty = (usedw<=13'd100);
assign fifo_ready = (usedw>=13'd600)&&(ATA1_wrusedw<=12'd1000);
//当读FIFO大于600个数且写FIFO小于1000时，一次性写入512个数
//======================================
reg state;
reg	[20:0]	count;
//================================
parameter s0 = 1'b0, s1 = 1'b1;
always@(posedge clk or negedge nRST)
if(!nRST)
	begin
		rdreq <= 1'b0;
		state <= s0;
		count<=21'd0;
	end
else case(state)
	s0:
		if(fifo_ready)
			begin
				rdreq <= 1'b1;
				state <= s1;
			end
		else
			begin
				rdreq <= 1'b0;
				state <= s0;
			end
	s1:
		if(count==21'd511)
			begin
				rdreq <= 1'b0;
				state <= s0;
				count<=21'd0;
			end
		else
			begin
				count<=count+1'b1;
				rdreq <= 1'b1;
				state <= s1;
			end
		default:
			begin
				rdreq <= 1'b0;
				state <= s0;
				count<=21'd0;
			end
	endcase

always@(posedge clk or negedge nRST)
begin
if(!nRST)
	err_cnt <= 32'd0;
else if(usedw > 13'd4092)
	err_cnt <= err_cnt + 1'b1;
else
	err_cnt <= err_cnt;
end

endmodule
