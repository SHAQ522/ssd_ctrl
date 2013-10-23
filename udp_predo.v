module udp_predo(
	input clk,//----------------ϵͳʱ��
	input nRST,//---------------ϵͳ��λ��0 is active��
	
	input begin_work,//-----------------------------��ʼ�źţ�NIOS����
	input [15:0] length,//--------------------------һ�����ݳ��ȣ�NIOS����

	input udp_busy,//-------------------------------udp���ģ��æ�źţ�1Ϊbusy
	
	input [15:0] data_in,//-------------------------fifo_data
	input [12:0] fifo_usedw,//----------------------fifo_rdusedw������һ������ʱ������������	
	output reg fifo_rden,//-------------------------fifo_rden
	
	output [15:0] ram_data,//-------------------ram_data
	output reg [10:0] ram_addr,//-------------------ram_addr
	output reg ram_wren,//--------------------------ram_wren
	
	output reg ping_pong,//-------------------------ping_pong�źţ�Ϊram_addr�����λ
	
	output reg udp_start,//-------------------------udp���ģ�������ź�
	
	output reg err//--------------------------------�����������udp_busyΪ��ʱping_pong��ת�����øߵ�ƽ
	);

//===================================
//�Ĵ�������
//===================================
reg [7:0] state;
reg [15:0] count;//---------------------------------���ݼ�����
reg begin_reg0,begin_reg1;//------------------------begin_work�źŻ���
reg busy_reg0,busy_reg1;//--------------------------udp_busy�źŻ���
reg ping_pong0,ping_pong1;//------------------------ping_pong�źŻ���

assign ram_data = data_in;
//=====================================================================================
//=====================================================================================
//	�����������Լ�״̬����״ֵ̬
//=====================================================================================	
parameter   idle = 8'd0,wait_send = 8'd1,start_send = 8'd2,
			wait_end = 8'd3,send_end = 8'd4,wait_busy = 8'd5;
//=====================================================================================	
always @(posedge clk)
begin
	begin_reg0 <= begin_work;
	begin_reg1 <= begin_reg0;
end	

always @(posedge clk)
begin
	busy_reg0 <= udp_busy;
	busy_reg1 <= busy_reg0;
end	
//=====================================================================================
//	ϵͳ״̬��
//=====================================================================================	
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			fifo_rden <= 1'b0;
			ram_addr <= 11'd0;
			ram_wren <= 1'b0;
			ping_pong <= 1'b0;
			udp_start <= 1'b0;
			count <= 16'd0;
			state <= idle;
		end	
	else
		case(state)
		idle:
			begin
				fifo_rden <= 1'b0;
				ram_addr <= {ping_pong,10'd0};
				ram_wren <= 1'b0;
				udp_start <= 1'b0;
				count <= 16'd0;
				if(begin_reg1)
					state <= wait_send;
			end	
		wait_send://---------------------------------------------------------��FIFO�е���fifo_usedw����lengthʱ��ʼ����
			begin
				if(fifo_usedw >= length)
					begin
						fifo_rden <= 1'b1;
						ram_wren <= 1'b1;
						count <= count + 1'b1;
						state <= start_send;
					end	
				else
					state <= wait_send;
			end	
		start_send://--------------------------------------------------------��FIFO�ж�ȡlength���ȵ����ݣ�д��RAM_PRE��
			begin
				fifo_rden <= 1'b1;
				ram_wren <= 1'b1;
				ram_addr <= ram_addr + 1'b1;
				if(count < length-1)
					count <= count + 1'b1;
				else	
					begin
						count <= 16'd0;
						state <= wait_end;
					end	
			end
		wait_end:
			begin
				fifo_rden <= 1'b0;
				ram_wren <= 1'b0;
				ping_pong <= ~ping_pong;//----ping_pong��ת
				state <= wait_busy;
			end
		wait_busy:
			begin
				if(busy_reg1 == 1'b0)
					state <= send_end;
			end
		send_end:
			begin
				udp_start <= 1'b1;
				if(count < 16'd10)
					count <= count + 1'b1;
				else
					state <= idle;
			end	
		default:
				state <= idle;
		endcase	
end		
//=====================================================================================	
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		err <= 1'b0;
	else
		begin
			ping_pong0 <= ping_pong;
			ping_pong1 <= ping_pong0;
			if((ping_pong0 != ping_pong1) & (busy_reg1 == 1'b1))
				err <= 1'b1;
		end		
end	


endmodule
