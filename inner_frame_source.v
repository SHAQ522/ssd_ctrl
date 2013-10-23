module   inner_frame_source(
							input clk,pRST,
							input [7:0]channel,
							input [7:0]channel_constant,
							input [7:0]version,
							input [7:0]type_,
							input [7:0]assi_packet,
							input [15:0]app_proc,
							input [7:0]group,
							input [7:0]packet_count_incr,
							input [15:0]packet_length,
							input [7:0]time_0,
							input [7:0]time_1,
							input [7:0]time_2,
							input [7:0]time_3,
							input [7:0]time_4,
							input [7:0]time_5,
							input [7:0]app_data_start_point,
							input [7:0]app_data_incr,
							input fifo_ready,
							
							output reg [15:0]app_data,
							output reg wren
							);
reg [2:0]version_reg=3'b000;
reg      tpye_reg = 1'b0;
reg      assi_packet_reg = 1'b1;
reg [10:0]app_proc_reg = 11'd0;
reg [1:0] group_reg = 2'b01;
reg [7:0]packet_count_incr_reg = 8'd1;
reg [15:0]packet_length_reg = 16'd1024;
reg [7:0]time_0_reg;
reg [7:0]time_1_reg;
reg [7:0]time_2_reg;
reg [7:0]time_3_reg;
reg [7:0]time_4_reg;
reg [7:0]time_5_reg;
reg [7:0]app_data_start_point_reg = 8'd0;
reg [7:0]app_data_incr_reg = 8'd1;

always @(posedge clk)
begin
	if(channel == channel_constant)
		begin
			version_reg <= version[2:0];
			tpye_reg    <= type_[0];
			assi_packet_reg <= assi_packet[0];
			app_proc_reg <= app_proc[10:0];
			group_reg <= group[1:0];
			packet_count_incr_reg <= packet_count_incr;
			packet_length_reg <= packet_length;
			time_0_reg <= time_0;
			time_1_reg <= time_1;
			time_2_reg <= time_2;
			time_3_reg <= time_3;
			time_4_reg <= time_4;
			time_5_reg <= time_5;
			app_data_start_point_reg <= app_data_start_point;
			app_data_incr_reg <= app_data_incr;
		end
end
reg [23:0]count;
always @(posedge clk or posedge pRST)
begin
	if(pRST)
		begin
			count <= 0;
		end
	else if(fifo_ready)
		begin
		
			if(count < {1'b0,packet_length_reg[15:1]} + 3)
				count <= count + 1'b1;
			else
				count <= 0;
		end
end
reg [13:0]packet_count;
always @(posedge clk or posedge pRST)
begin
	if(pRST)
		begin
			packet_count <= 0;
		end
	else if(count == 24'd6 && fifo_ready == 1)
		packet_count <= packet_count + packet_count_incr;
end
reg [7:0]inner_data;
always @(posedge clk or posedge pRST)
begin
	if(pRST)
		begin
			inner_data <= 0;
		end
	else if(count == 24'd3)
		inner_data <= app_data_start_point_reg;
	else if(count > 24'd5 && fifo_ready == 1)
		inner_data <= inner_data + app_data_incr_reg + app_data_incr_reg;
end

always @(posedge clk or posedge pRST)
begin
	if(pRST)
		begin
			app_data <= 0;
			wren <= 0;
		end
	else 
		begin
			wren <= fifo_ready;
			case(count)
				24'd0:app_data <= {app_proc_reg[7:0],{version_reg,tpye_reg,assi_packet_reg,app_proc_reg[10:8]}};
				24'd1:app_data <= {packet_count[7:0],{group_reg[1:0],packet_count[13:8]}};
				24'd2:app_data <= {packet_length_reg[7:0],packet_length_reg[15:8]};
				24'd3:app_data <= {time_1_reg,time_0_reg};
				24'd4:app_data <= {time_3_reg,time_2_reg};
				24'd5:app_data <= {time_5_reg,time_4_reg};
/*				24'd0:app_data <= {version_reg,tpye_reg,assi_packet_reg,app_proc_reg[10:8]};
				24'd1:app_data <= app_proc_reg[7:0];
				24'd2:app_data <= {group_reg[1:0],packet_count[13:8]};
				24'd3:app_data <= packet_count[7:0];
				24'd4:app_data <= packet_length_reg[15:8];
				24'd5:app_data <= packet_length_reg[7:0];
				24'd6:app_data <= time_0_reg;
				24'd7:app_data <= time_1_reg;
				24'd8:app_data <= time_2_reg;
				24'd9:app_data <= time_3_reg;
				24'd10:app_data <= time_4_reg;
				24'd11:app_data <= time_5_reg;*/
				default:app_data <= {inner_data+app_data_incr_reg,inner_data};
			endcase
		end
end
	
		
endmodule



			
			
			
			
			
			
			
			
			
			
			
			