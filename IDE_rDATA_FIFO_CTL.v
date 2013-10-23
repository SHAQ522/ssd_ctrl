module IDE_rDATA_FIFO_CTL(
	input clk,
	input nRST,
	input empty,
	input almost_empty,
	input [12:0] rData_fifo_usedw,
	input full,
	output reg ack
	);
		
reg [2:0] state;
parameter idle=3'd0,step_2=3'd1,step_3=3'd2,step_4=3'd3,high_speed_mode=3'd4;
always @(posedge clk or negedge nRST)
if(!nRST)
begin
	ack<=0;
	state<=idle;
end
else
	case(state)
	idle:
	begin
		if(almost_empty==1'h0 && rData_fifo_usedw<13'd3000)
		begin
			ack<=1;
			state<=high_speed_mode;
		end
		else
		begin
			ack<=0;
			if(empty ==1'h0)
			begin
				state<=step_2;
			end
			else
				state<=idle;
		end
	end
	high_speed_mode:
	begin
		if(almost_empty==1'h0 && rData_fifo_usedw<13'd3000)
		begin
			ack<=1;
			state<=high_speed_mode;
		end
		else
		begin
			ack<=0;
			state<=step_2;
		end
	end
	step_2:
	begin
		state<=step_3;
	end
	step_3:
	begin
		state<=step_4;
	end
	step_4:
	begin
		state<=idle;
		if((empty ==1'h0) && (rData_fifo_usedw<13'd3000))
		begin
			ack<=1;
		end
	end
	endcase
	
endmodule
