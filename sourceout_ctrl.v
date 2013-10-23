module sourceout_ctrl(
	input clk,//----------------ϵͳʱ��
	input nRST,//---------------ϵͳ��λ��0 is active��
	
	input [31:0] pos_length,//-----------------------���̳��ȣ�4���ֽ�
	input [31:0] neg_length,//----------------------��̳��ȣ�4���ֽ�	
	
	input [3:0] data_form,
	
	input [12:0] fifo_usedw,//----------------------fifo_rdusedw������3000ʱ������������
	
	output reg data_en//----------------------------����ʹ�����
	);

//===================================
//�Ĵ�������
//===================================
reg [2:0] state;
reg [47:0] pos_num;//-------------------------------���̷������ݳ���,6���ֽ�
reg [47:0] neg_num;//-------------------------------��̷������ݳ���,6���ֽ�
reg [47:0] count;//---------------------------------������Ч���ݼ���,6���ֽ�
reg [12:0] fifo_usedw_reg;
//=====================================================================================
//=====================================================================================
//	�����������Լ�״̬����״ֵ̬
//=====================================================================================	
parameter   idle = 3'd0,wait_send = 3'd1,start_send = 3'd2,
			send_pos = 3'd3,send_neg = 3'd4;
//=====================================================================================	

//=====================================================================================
//	ϵͳ״̬��
//=====================================================================================	
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			data_en <= 1'b0;
			count <= 48'd0;
			fifo_usedw_reg <= 13'd0;
			state <= idle;
		end	
	else
		case(state)
		idle:
			begin
			data_en <= 1'b0;
			count <= 48'd0;
			fifo_usedw_reg <= 13'd0;
			state <= wait_send;
			end	
		wait_send://---------------------------------------------------------��FIFO_POST�е���fifo_usedw����2000ʱ��ʼ���ͣ�ԴԴ����
			begin
				data_en <= 1'b0;
				count <= 48'd0;
				fifo_usedw_reg <= fifo_usedw;
				if(fifo_usedw_reg > 13'd2000)
					state <= start_send;
				else
					state <= wait_send;
			end	
		start_send:
			begin
				data_en <= 1'b0;
				count <= 32'd0;
				state <= send_pos;
			end	
		send_pos://---------------------------------------------------------�����������ݣ�����Ϊpos_num����FIFO�ж���
			begin
				data_en <= 1'b1;
				if(count < pos_num-1)
					count <= count + 1'b1;
				else	
					begin
					count <= 48'd0;
					if(neg_num == 48'd0)//-----------------------------------neg_length = 0
						state <= send_pos;	
					else
						state <= send_neg;
					end	
			end
		send_neg://----------------------------------------------------------����������ݣ�����Ϊneg_num������0
			begin
				data_en <= 1'b0;
				if(count < neg_num-1)
					count <= count + 1'b1;
				else	
				begin
					count <= 48'd0;
					state <= send_pos;
				end	
			end		
		default:
				state <= idle;
		endcase	
end		

//=====================================================================================	

always @(*)
begin
	if(data_form==4'd1)
		begin
			pos_num <= {13'd0,pos_length,3'd0};
			neg_num <= {13'd0,neg_length,3'd0};
		end
	else
		if(data_form==4'd2)
		begin
			pos_num <= {14'd0,pos_length,2'd0};
			neg_num <= {14'd0,neg_length,2'd0};
		end
	else
		if(data_form==4'd3)
		begin
			pos_num <= {15'd0,pos_length,1'b0};
			neg_num <= {15'd0,neg_length,1'b0};
		end
	else
		if(data_form==4'd4)
		begin
			pos_num <= {16'd0,pos_length};
			neg_num <= {16'd0,neg_length};
		end
	else
		if(data_form==4'd5)
		begin
			pos_num <= {17'd0,pos_length[31:1]};
			neg_num <= {17'd0,neg_length[31:1]};
		end
	else
		begin
			pos_num <= {16'd0,pos_length};
			neg_num <= {16'd0,neg_length};
		end	
end

endmodule
