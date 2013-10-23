module load_data_generator(
	input clk,
	input nRST,
	input fifo_ready,

	input [31:0] packet_head,
	input [15:0] flag_set,
	input [23:0] length_set,
	input scramble,	
	
	input [15:0] scr_in,//--------------------------���Ž��
	output reg scr_rst,
	output reg scr_en,
	output reg [15:0] scr_out,
	
	input [15:0] crc_in,//--------------------------CRCУ����
	output reg crc_init,
	output reg crc_en,
	output reg [15:0] crc_out,
	
	output reg [15:0] data_out,//-------------------�������
	output reg data_en//----------------------------����ʹ�����
	);

//===================================
//�Ĵ�������
//===================================
reg [15:0] data_out_reg;
reg data_en_reg;
reg data_en_reg0;
reg  [7:0]  state;
reg  [31:0] count;//---------------------------------������Ч���ݼ���,4���ֽ�
reg  [23:0] packet_count;//--------------------------������,23bit
wire [31:0] count_num;//-----------------------------������Ч���ݼ������ֵ,4���ֽڣ�Ϊpos_length-8
reg  [15:0] crc_reg;//-------------------------------CRCУ�����Ĵ���
reg  [7:0]  crc_wait_time;
reg  fifo_ready_reg0;

assign 	count_num = length_set-32'd14;
//=====================================================================================
//=====================================================================================
//	�����������Լ�״̬����״ֵ̬
//=====================================================================================	
parameter   idle = 8'd0,start_send = 8'd1,
			send_head_0 = 8'd2,send_head_1 = 8'd3,
			send_count_1 = 8'd6,
			send_count_2 = 8'd7,
			send_length_1 = 8'd20,
			send_length_2 = 8'd21,
			send_data = 8'd13,
			send_crc_0 = 8'd14,send_crc_1 = 8'd15,crc_wait = 8'd23,
			state_back = 8'd19;
//=====================================================================================	
always @(posedge clk)
begin
	fifo_ready_reg0 <= fifo_ready;
end	
//=====================================================================================
//	ϵͳ״̬��
//=====================================================================================	
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			data_out_reg <= 16'd0;
			data_en_reg <= 1'b0;
			scr_out <= 16'd0;
			scr_en <= 1'b0;
			count <= 32'd0;
			packet_count <= 24'd0;		
			scr_rst <= 1'b1;
			crc_init <= 1'b1;
			crc_wait_time <= 8'd0; 
			
			state <= idle;
		end	
	else
		case(state)
		idle:
			begin
			data_out_reg <= 16'd0;
			data_en_reg <= 1'b0;
			scr_out <= 16'd0;
			scr_en <= 1'b0;
			count <= 32'd0;
			packet_count <= 24'd0;
			scr_rst <= 1'b1;
			crc_init <= 1'b1;
			crc_wait_time <= 8'd0; 
			state <= start_send;
			end	
		start_send://-------------------------------------------------------ѭ������
			begin
				count <= 32'd0;
				scr_rst <= 1'b0;
				crc_init <= 1'b0;
				crc_wait_time <= 8'd0; 
				state <= send_head_0;
			end
		send_head_0://---------------------------------------------���Ͱ�ͷ��4���ֽڣ�5716EB90����2��ʱ�����ڷ���
			begin
				data_out_reg <= packet_head[31:16];
				data_en_reg <= 1'b1;
				scr_out <= packet_head[31:16];
				scr_en <= 1'b1;
				state <= send_head_1;
			end
		send_head_1:
			begin
				data_out_reg <= packet_head[15:0];
				data_en_reg <= 1'b1;
				scr_out <= packet_head[15:0];
				scr_en <= 1'b1;
				state <= send_count_1;
			end	
		send_count_1://--------------------------------------------���ͼ�������16bit
			begin
				data_out_reg <= packet_count[23:8];
				data_en_reg <= 1'b1;
				scr_out <= packet_count[23:8];
				scr_en <= 1'b1;
				state <= send_count_2;
			end	
		send_count_2://--------------------------------------------���ͼ�������8bit+�غɱ�ʶ��8bit
			begin
				data_out_reg <= {packet_count[7:0],flag_set[15:8]};
				data_en_reg <= 1'b1;
				scr_out <= {packet_count[7:0],flag_set[15:8]};
				scr_en <= 1'b1;
				packet_count <= packet_count + 1'b1;
				state <= send_length_1;
			end		
		send_length_1://--------------------------------------------�����غɱ�ʶ��8bit+������8bit
			begin
				data_out_reg <= {flag_set[7:0],length_set[23:16]};
				data_en_reg <= 1'b1;
				scr_out <= {flag_set[7:0],length_set[23:16]};
				scr_en <= 1'b1;
				state <= send_length_2;
			end	
		send_length_2://--------------------------------------------������16bit//���ͼ�����+0xff��2���ֽ�
			begin
				data_out_reg <= length_set[15:0];
				data_en_reg <= 1'b1;
				scr_out <= length_set[15:0];
				scr_en <= 1'b1;
				state <= send_data;
			end	
		send_data://---------------------------------------------------------�������ݣ���00��FFѭ�����ͣ������ֽ���Ϊcount_num=pos_length-32'd8
			begin
				if((fifo_ready_reg0) & (count<count_num))
					begin
						count <= count + 8'd2;
						data_out_reg[15:8] <= count[7:0];
						data_out_reg[7:0] <= count[7:0] + 8'd1;
						data_en_reg <= 1'b1;
						scr_out[15:8] <= count[7:0];
						scr_out[7:0] <= count[7:0] + 8'd1;
						scr_en <= 1'b1;
						state <= send_data;
					end
				else
					if(fifo_ready_reg0)
					begin
						count <= 32'd0;
						data_out_reg <= 16'd0;
						data_en_reg <= 1'b0;
						scr_out <= 16'd0;
						scr_en <= 1'b0;
						state <= crc_wait;
					end
				else	
					begin
						data_out_reg <= 16'd0;
						data_en_reg <= 1'b0;
						scr_out <= 16'd0;
						scr_en <= 1'b0;
						state <= send_data;
					end
			end	
		crc_wait://------------------------------------------------------------�ȴ�CRCУ�飬10��ʱ������
			begin
				crc_wait_time <= crc_wait_time + 1'b1; 
				if(crc_wait_time==8'd10)
					state <= send_crc_0;
				else
					state <= crc_wait;
			end		
		send_crc_0://----------------------------------------------------------����CRCУ������4���ֽڣ���4��ʱ�����ڷ���
			begin
				crc_reg <= crc_in;
				crc_wait_time <= 8'd0;
				state <= send_crc_1;
			end	
		send_crc_1:
			begin
			//	data_out_reg <= crc_reg;
			//	data_en_reg <= 1'b1;
				state <= state_back;
			end		
		state_back://-----------------------------------------------------------�ð����ͽ��������ط�����һ������
			begin
				data_out_reg <= 16'd0;
				data_en_reg <= 1'b0;
				scr_rst <= 1'b1;//---------------------------���Ÿ�λ
				crc_init <= 1'b1;//--------------------------CRC��λ
				state <= start_send;
			end	
		default:
				state <= idle;
		endcase	
end		
//=====================================================================================	
//=====================================================================================
//	����
//=====================================================================================	
always @(posedge clk)
begin
	data_en_reg0 <= data_en_reg;
	if(state == send_crc_1)
	begin
		data_out <= crc_reg;
		data_en <= 1'b1;
	end
	else if(!scramble)
		begin
		data_out <= data_out_reg;
		data_en <= data_en_reg;
		end
	else
		begin
		data_out <= scr_in;
		data_en <= data_en_reg0;
		end
end	
//=====================================================================================
//	CRCУ��
//=====================================================================================	
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			crc_en <= 1'b0;
			crc_out <= 16'd0;
		end		
	else
		if(crc_init)
		begin
			crc_en <= 1'b0;
			crc_out <= 16'd0;
		end
	else
		begin
			crc_en <= data_en;
			crc_out <= data_out;
		end	
end
	
	
endmodule
