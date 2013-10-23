module sourceout_ctrl_uart(
	input clk,//----------------ϵͳʱ��
	input nRST,//---------------ϵͳ��λ��0 is active��
	
	input [31:0] data_length,//-----------------------���̳��ȣ�4���ֽ�
	input [31:0] blank_length,//----------------------��̳��ȣ�4���ֽ�	
	
	input [17:0] fifo_usedw,//----------------------fifo_rdusedw������3000ʱ������������
	
	input data_in,
	
	output reg rden,
	
	output reg data_out,
	output reg data_en//----------------------------����ʹ�����
	);

//===================================
//�Ĵ�������
//===================================
reg [2:0] state;
reg [31:0] pos_num;//-------------------------------���̷������ݳ���,6���ֽ�
reg [31:0] neg_num;//-------------------------------��̷������ݳ���,6���ֽ�
reg [31:0] count;//---------------------------------������Ч���ݼ���,6���ֽ�
reg [17:0] fifo_usedw_reg;
reg [7:0] cnt;
reg data_check;
//reg rden;
//=====================================================================================
//=====================================================================================
//	�����������Լ�״̬����״ֵ̬
//=====================================================================================	
parameter   idle = 3'd0,wait_send = 3'd1,start_send = 3'd2,
			send_pos0 = 3'd3,send_pos1 = 3'd4,send_pos2 = 3'd5,send_pos3 = 3'd6,send_neg = 3'd7;
//=====================================================================================	
/*
always @(posedge clk)
begin
	rden_out <= rden;
end
*/
//=====================================================================================
//	ϵͳ״̬��
//=====================================================================================	
always @(posedge clk or negedge nRST)
begin
	if(!nRST)
		begin
			data_en <= 1'b0;
			data_out <= 1'b1;
			rden <= 1'b0;
			count <= 32'd0;
			cnt <= 8'd0; 
			data_check <= 1'b0;
			pos_num <= {data_length[28:0],3'd0};
			neg_num <= {blank_length[28:0],3'd0};
			fifo_usedw_reg <= 18'd0;
			state <= idle;
		end	
	else
		case(state)
		idle:
			begin
			data_en <= 1'b0;
			data_out <= 1'b1;
			rden <= 1'b0;
			count <= 32'd0;
			cnt <= 8'd0;
			data_check <= 1'b0;
//			pos_num <= {data_length[28:0],3'd0}+{data_length[30:0],1'b0}+data_length[31:0];
			pos_num <= data_length;
			neg_num <= {blank_length[28:0],3'd0};
			fifo_usedw_reg <= 18'd0;
			state <= wait_send;
			end	
		wait_send://---------------------------------------------------------��FIFO_POST�е���fifo_usedw����2000ʱ��ʼ���ͣ�ԴԴ����
			begin
				data_en <= 1'b0;
				data_out <= 1'b1;
				rden <= 1'b0;
				count <= 32'd0;
				cnt <= 8'd0;
				data_check <= 1'b0;
				fifo_usedw_reg <= fifo_usedw;
				if(fifo_usedw_reg > 18'd4000)
					state <= start_send;
				else
					state <= wait_send;
			end	
		start_send:
			begin
				data_en <= 1'b0;
				data_out <= 1'b1;
				rden <= 1'b0;
				count <= 32'd0;
				cnt <= 8'd0;
				data_check <= 1'b0;
				state <= send_pos0;
			end	
		send_pos0://---------------------------------------------------------�����������ݣ�����Ϊpos_num����FIFO�ж���
			begin			
		//		rden <= 1'b0;
				cnt <= 8'd0;
				data_check <= 1'b0;			
				if(count < pos_num)
				begin
					count <= count + 1'b1;
					state <= send_pos1;
					data_out <= 1'b0;//---start bit
					data_en <= 1'b1;
					rden <= 1'b1;
				end
				else	
				begin
					count <= 32'd0;
					if(neg_num == 32'd0)//-----------------------------------neg_length = 0
					begin
						state <= send_pos1;	
						data_out <= 1'b0;//---start bit
						data_en <= 1'b1;
						rden <= 1'b1;
					end					
					else
					begin
						state <= send_neg;
						data_out <= 1'b1;
						data_en <= 1'b0;
						rden <= 1'b0;
					end	
				end	
			end
		send_pos1:
			begin
				data_en <= 1'b1;
				data_out <= data_in;//---data bit
				rden <= 1'b1;
				cnt <= cnt + 1'b1;
				data_check <= data_check + data_in;
				if(cnt == 8'd7)
					rden <= 1'b0;
				if(cnt == 8'd7)
					state <= send_pos2;
			end
		send_pos2:
			begin
				data_en <= 1'b1;
				data_out <= data_check;//---check bit
				rden <= 1'b0;
				cnt <= 8'd0;
				state <= send_pos3;
			end	
		send_pos3:
			begin
				data_en <= 1'b1;
				data_out <= 1'b1;//---end bit
				rden <= 1'b0;
				cnt <= 8'd0;
				state <= send_pos0;
			end		
		send_neg://----------------------------------------------------------����������ݣ�����Ϊneg_num������0
			begin
				data_en <= 1'b0;
				data_out <= 1'b1;
				if(count < neg_num-1)
					count <= count + 1'b1;
				else	
				begin
					count <= 32'd0;
					state <= send_pos0;
				end	
			end		
		default:
				state <= idle;
		endcase	
end		
	
endmodule
