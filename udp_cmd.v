module udp_cmd(
	input clk,//----------------系统时钟
	input nRST,//---------------系统复位，0 is active。
	
	input cmd_en,
	input[7:0]cmd_addr,
	input[15:0]cmd_data,
	
	output reg [7:0] flag,//-----------------------------00：无 01：下一帧 02：重发本帧 
	output reg [15:0] frame_step,
	output reg [15:0] frame_addr_now,
	output reg [15:0] frame_addr_begin,
	output reg [15:0] frame_addr_end,
	
	output reg err
	);	
//=====================================================================================	
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
	begin
		flag <= 2'b00;
		frame_step <= 16'd0;
		frame_addr_now <= 16'd0;
		frame_addr_begin <= 16'd0;
		frame_addr_end <= 16'd0;
	end	
	else if(cmd_en & (cmd_addr == 8'h01))
	begin
		flag <= 8'h01;
		frame_step <= cmd_data;
	end	
	else if(cmd_en & (cmd_addr == 8'h02))
	begin
		flag <= 8'h02;
		frame_step <= cmd_data;
	end	
	else if(cmd_en & (cmd_addr == 8'h03))
	begin
		flag <= 8'h03;
		frame_addr_now <= cmd_data;
	end
	else if(cmd_en & (cmd_addr == 8'h04))
	begin
		flag <= 8'h04;
		frame_addr_begin <= cmd_data;
	end
	else if(cmd_en & (cmd_addr == 8'h05))
	begin
		flag <= 8'h05;
		frame_addr_end <= cmd_data;
	end			
	else
		flag <= flag;
end
//=====================================================================================	
//=====================================================================================	

endmodule
