module udp_monitor(
	input clk,//----------------ϵͳʱ��
	input nRST,//---------------ϵͳ��λ��0 is active��
	
	input begin_work,//-----------------------------��ʼ�źţ�NIOS����
	input [7:0] flag,//-----------------------------00���� 01����һ֡ 02���ط���֡ 
	input [15:0] frame_step,
	input [15:0] frame_addr_now,
	input [15:0] frame_addr_begin,
	input [15:0] frame_addr_end,
	
	input busy,
	
	output reg	sdram_wr,
	output reg	sdram_rd,
	output reg[15:0]	wraddr_begin,			//д��ʼ��ַ
	output reg[15:0]	wraddr_end,			    //д������ַ
	output reg[15:0]	rdaddr_begin,			//д��ʼ��ַ
	output reg[15:0]	rdaddr_end,			    //д������ַ
	input sdram_wr_done,
	
	output reg packet_start,//----------------------�����ؿ�ʼ�������8MB����
	output reg [31:0] cnt_init,//-------------------8M��ʼ����ֵ
	
	output reg[15:0]	frame_length,	
	output reg err
	);

//===================================
//�Ĵ�������
//===================================
reg [7:0] state;
reg [15:0] count;
reg begin_reg0,begin_reg1;//---------------------begin_work�źŻ���
reg [7:0]flag0,flag1;//--------------------------flag�źŻ���
reg sdram_wr_done0,sdram_wr_done1;
//=====================================================================================	
always @(posedge clk)
begin
	begin_reg0 <= begin_work;
	begin_reg1 <= begin_reg0;
end	

always @(posedge clk)
begin
	flag0 <= flag;
	flag1 <= flag0;
end	

always @(posedge clk)
begin
	sdram_wr_done0 <= sdram_wr_done;
	sdram_wr_done1 <= sdram_wr_done0;
end	
//=====================================================================================
//	ϵͳ״̬��
//=====================================================================================	
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			packet_start <= 1'b0;
			cnt_init <=32'd0;
			sdram_wr <= 1'b0;
			sdram_rd <= 1'b0;
			count <= 16'd0;
			wraddr_begin <= 16'd0;
			wraddr_end <= 16'd0;
			rdaddr_begin <= 16'd0;
			rdaddr_end <= 16'd0;
			frame_length <= 16'd0;
			state <= 8'd0;
		end	
	else
		case(state)
		8'd0:
			begin
				packet_start <= 1'b0;
				sdram_wr <= 1'b0;
				sdram_rd <= 1'b0;
				count <= 16'd0;
				wraddr_begin <= 16'd0;
				wraddr_end <= 16'd0;
				rdaddr_begin <= 16'd0;
				rdaddr_end <= 16'd0;
				frame_length <= 16'd0;
				frame_length <= 16'd0;
				if(begin_reg1)
					state <= 8'd1;
			end	
		8'd1:
			begin
				if((flag0 != flag1) && (flag0 == 8'h01) && (!busy))
					begin
						cnt_init <= 32'd0;
						wraddr_begin <= 16'd0;
						wraddr_end <= {2'b00,frame_step[15:2]};
						rdaddr_begin <= 16'd0;
						rdaddr_end <= {2'b00,frame_step[15:2]};
						frame_length <= frame_step;
						state <= 8'd2;//------------------��һ֡
					end	
				else if((flag0 != flag1) && (flag0 == 8'h02) && (!busy))
					begin
						cnt_init <= 32'd0;
						rdaddr_begin <= 16'd0;
						rdaddr_end <= {2'b00,frame_step[15:2]};
						frame_length <= frame_step;
						state <= 8'd4;//------------------�ط�ȫ��֡
					end	
				else if((flag0 != flag1) && (flag0 == 8'h03) && (!busy))
					begin
						cnt_init <= frame_addr_now;
						rdaddr_begin <= {2'b00,frame_addr_now[15:2]};
						rdaddr_end <= {2'b00,frame_addr_now[15:2]} + 1'b1;
						frame_length <= 16'd4;
						state <= 8'd4;//------------------�ط�һ֡
					end	
				else if((flag0 != flag1) && (flag0 == 8'h05) && (!busy))
					begin
						cnt_init <= {2'b00,frame_addr_begin[15:2]};
						rdaddr_begin <= {2'b00,frame_addr_begin[15:2]};
						rdaddr_end <= {2'b00,frame_addr_end[15:2]};
						frame_length <= frame_addr_end - frame_addr_begin;
						state <= 8'd4;//------------------�ط�����֡
					end	
				else
					state <= 8'd1;
			end	
//----------------------------------------------------------------------------------------------------------------------//			
		8'd2:
			begin
				sdram_wr <= 1'b1;
				count <= 16'd0;
				if(sdram_wr_done1)
					state <= 8'd3;
				else	
					state <= 8'd2;
			end
		8'd3:
			begin
				sdram_wr <= 1'b0;
				if(count == 16'd10)
				begin
					count <= 16'd0;
					state <= 8'd4;
				end	
					count <= count + 1'b1;	
			end
//----------------------------------------------------------------------------------------------------------------------//			
		8'd4:
			begin
				sdram_rd <= 1'b1;
				packet_start <= 1'b1;
				state <= 8'd5;
			end
		8'd5:
			begin
				if(count == 16'd10)
				begin
					count <= 16'd0;
					state <= 8'd0;
				end	
					count <= count + 1'b1;	
			end	
//----------------------------------------------------------------------------------------------------------------------//			
		default:
				state <= 8'd0;
		endcase	
end		
//=====================================================================================	
always @(posedge clk)
begin
	if((flag0 != flag1) && (busy))
		err <= ~err;
end	
endmodule
