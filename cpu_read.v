module cpu_read(
	input clk,
	input cpu_rd_n,
	input [8:0] cpu_addr,
	
	input [10:0] command_fifo_usedw,
	input [15:0] command_fifo_data,
	
	input  ATA1_busy,
	input  ATA1_err,	
	
	input [31:0] gbit_packer_count,
	
	input  sdram_wr_done,

	input [15 : 0]  signal_tele_ch,
	
	input  [31:0]freq_tele_ch0,
	input  [31:0]freq_tele_ch1,
	input  [31:0]freq_tele_ch2,
	input  [31:0]freq_tele_ch3,
	input  [31:0]freq_tele_ch4,
	input  [31:0]freq_tele_ch5,
	input  [31:0]freq_tele_ch6,
	input  [31:0]freq_tele_ch7,
	input  [31:0]freq_tele_ch8,
	input  [31:0]freq_tele_ch9,
	input  [31:0]freq_tele_ch10,
	input  [31:0]freq_tele_ch11,
	
	input [15 : 0]  ram_tele_flag,
	input [8 : 0]  uart_fifo_num,
	
	output reg command_fifo_ack,	
	output reg [31:0] cpu_rdata,
	
	output reg update_fifo_ack,
	input [31 : 0] update_db,
	input [11 : 0] update_num,
	
	input [10:0] updatecommand_fifo_usedw,
	input [15:0] updatecommand_fifo_data,
	output reg updatecmd_fifo_ack
);

reg [15 : 0] signal_tele_ch_reg;

reg [15 : 0] signal_tele_ch_reg0;

reg [15 : 0] ram_tele_flag_reg;

reg [15 : 0] ram_tele_flag_reg0;

reg [15 : 0] uart_fifo_num_reg;

reg [15 : 0] uart_fifo_num_reg0;


always @(posedge clk)
begin
	signal_tele_ch_reg<=signal_tele_ch;
	ram_tele_flag_reg<=ram_tele_flag;
	uart_fifo_num_reg<=uart_fifo_num;
end

always @(posedge clk)
begin
	signal_tele_ch_reg0<=signal_tele_ch_reg;
	ram_tele_flag_reg0<=ram_tele_flag_reg;
	uart_fifo_num_reg0<=uart_fifo_num_reg;
end

reg [31:0] freq_tele_ch0_reg;
reg [31:0] freq_tele_ch1_reg;
reg [31:0] freq_tele_ch2_reg;
reg [31:0] freq_tele_ch3_reg;
reg [31:0] freq_tele_ch4_reg;
reg [31:0] freq_tele_ch5_reg;
reg [31:0] freq_tele_ch6_reg;
reg [31:0] freq_tele_ch7_reg;
reg [31:0] freq_tele_ch8_reg;
reg [31:0] freq_tele_ch9_reg;
reg [31:0] freq_tele_ch10_reg;
reg [31:0] freq_tele_ch11_reg;

reg [31:0] freq_tele_ch0_reg0;
reg [31:0] freq_tele_ch1_reg0;
reg [31:0] freq_tele_ch2_reg0;
reg [31:0] freq_tele_ch3_reg0;
reg [31:0] freq_tele_ch4_reg0;
reg [31:0] freq_tele_ch5_reg0;
reg [31:0] freq_tele_ch6_reg0;
reg [31:0] freq_tele_ch7_reg0;
reg [31:0] freq_tele_ch8_reg0;
reg [31:0] freq_tele_ch9_reg0;
reg [31:0] freq_tele_ch10_reg0;
reg [31:0] freq_tele_ch11_reg0;

always @(posedge clk)
begin
	freq_tele_ch0_reg<=freq_tele_ch0;
	freq_tele_ch1_reg<=freq_tele_ch1;
	freq_tele_ch2_reg<=freq_tele_ch2;
	freq_tele_ch3_reg<=freq_tele_ch3;
	freq_tele_ch4_reg<=freq_tele_ch4;
	freq_tele_ch5_reg<=freq_tele_ch5;
	freq_tele_ch6_reg<=freq_tele_ch6;
	freq_tele_ch7_reg<=freq_tele_ch7;
	freq_tele_ch8_reg<=freq_tele_ch8;
	freq_tele_ch9_reg<=freq_tele_ch9;
	freq_tele_ch10_reg<=freq_tele_ch10;
	freq_tele_ch11_reg<=freq_tele_ch11;
end

always @(posedge clk)
begin
	freq_tele_ch0_reg0<=freq_tele_ch0_reg;
	freq_tele_ch1_reg0<=freq_tele_ch1_reg;
	freq_tele_ch2_reg0<=freq_tele_ch2_reg;
	freq_tele_ch3_reg0<=freq_tele_ch3_reg;
	freq_tele_ch4_reg0<=freq_tele_ch4_reg;
	freq_tele_ch5_reg0<=freq_tele_ch5_reg;
	freq_tele_ch6_reg0<=freq_tele_ch6_reg;
	freq_tele_ch7_reg0<=freq_tele_ch7_reg;
	freq_tele_ch8_reg0<=freq_tele_ch8_reg;
	freq_tele_ch9_reg0<=freq_tele_ch9_reg;
	freq_tele_ch10_reg0<=freq_tele_ch10_reg;
	freq_tele_ch11_reg0<=freq_tele_ch11_reg;
end


always @(posedge clk)
begin
	case(cpu_addr[8:0])
	0:cpu_rdata<={21'd0,command_fifo_usedw};//-------------------命令FIFO个数
	1:cpu_rdata<={16'd0,command_fifo_data};//--------------------命令FIFO数据
	2:cpu_rdata<={30'd0,ATA1_err,ATA1_busy};//-------------------系统状态
	3:cpu_rdata<= gbit_packer_count;//---------------------------数据FIFO个数
	4:cpu_rdata<= {31'd0,sdram_wr_done};//-----------------------sdram写结束信号
	
	10:cpu_rdata<= {16'd0,signal_tele_ch_reg0};
	11:cpu_rdata<= {16'd0,ram_tele_flag_reg0};
	12:cpu_rdata<= {27'd0,uart_fifo_num_reg0};
	
	50:cpu_rdata<= freq_tele_ch0_reg0;
	51:cpu_rdata<= freq_tele_ch1_reg0;
	52:cpu_rdata<= freq_tele_ch2_reg0;
	53:cpu_rdata<= freq_tele_ch3_reg0;
	54:cpu_rdata<= freq_tele_ch4_reg0;
	55:cpu_rdata<= freq_tele_ch5_reg0;
	56:cpu_rdata<= freq_tele_ch6_reg0;
	57:cpu_rdata<= freq_tele_ch7_reg0;
	58:cpu_rdata<= freq_tele_ch8_reg0;
	59:cpu_rdata<= freq_tele_ch9_reg0;
	60:cpu_rdata<= freq_tele_ch10_reg0;
	61:cpu_rdata<= freq_tele_ch11_reg0;
	
	26:cpu_rdata <= {update_db[23:16],update_db[31:24],update_db[7:0],update_db[15:8]};//11
	25:cpu_rdata<={19'd0,update_num};//12
	23:cpu_rdata<={21'd0,updatecommand_fifo_usedw};//-------------------命令FIFO个数
	24:cpu_rdata<={16'd0,updatecommand_fifo_data};//--------------------命令FIFO数据
	
	default:cpu_rdata<=32'd0;
	endcase
end

always @(posedge clk)
	if((cpu_rd_n==0) && (cpu_addr==9'd1))
		command_fifo_ack<=1;
	else
		command_fifo_ack<=0;
		
always @(negedge clk)
	if((cpu_rd_n==0) && (cpu_addr==9'd24))
		updatecmd_fifo_ack<=1;
	else
		updatecmd_fifo_ack<=0;
		
always @(negedge clk)
	if((cpu_rd_n==0) && (cpu_addr==9'd26))
		update_fifo_ack<=1;
	else
		update_fifo_ack<=0;
		
endmodule
