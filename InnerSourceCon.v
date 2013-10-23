module InnerSourceCon(
						input clk,
						input reset_n,
						
						input [7 : 0] init_dat,
						input [7 : 0] step_dat,
						input update_flag,
						
						
						input [15 : 0] dat_length,
						
						
						input fifo_full_h,
						input inner_oe,
						
						output reg [15 : 0] dat_out,
						
						output [7 : 0] dout0,
						output [7 : 0] dout1,
						
						output reg en_out
						
						);
	
//	reg [7 : 0] init_reg;
//	reg [7 : 0] step_reg;
	reg [15 : 0] length_cnt;
	reg fifo_full_h_reg;
	reg inner_oe_reg;
	
	reg flag_reg0;
	reg flag_reg1;
	
	assign dout0 = dat_out[7 : 0];
	assign dout1 = dat_out[15 : 8];
	
	reg [15 : 0] datreg_out;
	reg enreg_out;
	
	always @ (posedge clk)
	begin
		dat_out <= datreg_out;
		en_out <= enreg_out;
	end
	
///////////////////////////////////////////////////////////////////////////////////////////////////////////	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			flag_reg0 <= 1'b0;
			flag_reg1 <= 1'b0;
			fifo_full_h_reg <= 1'b0;
			inner_oe_reg <= 1'b0;
		end
		else
		begin
			flag_reg0 <= update_flag;
			flag_reg1 <= flag_reg0;
			fifo_full_h_reg <= fifo_full_h;
			inner_oe_reg <= inner_oe;
		end
	end 

//	always @ (posedge clk or negedge reset_n)
//	begin
//		if (!reset_n)
//		begin
//			init_reg <= 8'd0 ; 
//			step_reg <= 8'd1 ; 
//			length_cnt <= 16'd0;
//			
//		end 
//		else if (update_flag & !flag_reg0)
//		begin
//			init_reg <= init_dat;
//			step_reg <= step_dat;
//			length_cnt <= {1'b0,dat_length[15:1]};
//		end 
//	end 
///////////////////////////////////////////////////////////////////////////////////////////////////////////	
	
	reg [7 : 0] init0_reg1;
	reg [7 : 0] init1_reg1;
	reg [7 : 0] step2_reg1;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			init0_reg1 <= 8'd0 ; 
			init1_reg1 <= 8'd0 ;
			step2_reg1 <= 8'd2 ; 
			length_cnt <= 16'd0;
		end 
		else if (flag_reg0 & flag_reg1)
		begin
			init1_reg1 <= init_dat ; 
			init0_reg1 <= init_dat + step_dat; 
			step2_reg1 <= { step_dat[6:0] , 1'b0 }; 
			length_cnt <= {1'b0,dat_length[15:1]};
		end 
	end
///////////////////////////////////////////////////////////////////////////////////////////////////////////			
	reg [2 : 0] state;
	
	parameter idle = 3'd0;
	parameter calc0 = 3'd1;
	parameter calc1 = 3'd2;
	
	reg [15 : 0] counter;
	
	reg  [7 : 0] temp_reg0;
	reg  [7 : 0] temp_reg1;
	
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			state <= idle;
			enreg_out <= 1'b0;
			datreg_out <= 16'd0;
			counter <= 16'd0;
			temp_reg0 <= 8'd0;
			temp_reg1 <= 8'd0;
		end 
		else if (flag_reg0)
		begin
			state <= idle;
			enreg_out <= 1'b0;
			counter <= 16'd0;
		end
		else
		begin
			case (state) 
				idle:
				begin
				if (flag_reg1)
				begin
					state <= calc0;
					counter <= 16'd0;
					temp_reg0 <= init0_reg1;
					temp_reg1 <= init1_reg1;
				end
				end
				calc0:
				begin
					if (!fifo_full_h_reg & inner_oe_reg)
					begin
						state <= calc1;
						
						datreg_out[7  : 0] <= init0_reg1;//
						datreg_out[15 : 8] <= init1_reg1;//
						
						temp_reg0 <= temp_reg0 + step2_reg1;
						temp_reg1 <= temp_reg1 + step2_reg1;
						
						enreg_out <= 1'b1;
						counter <= counter + 1'b1;
					end
					else
					begin
						state <= calc0;
					end
				end
				calc1:
				begin
					if ( (counter < length_cnt)&&(!fifo_full_h_reg) )
					begin
						state <= calc1;
						
						
						datreg_out[7  : 0] <= temp_reg0;
						datreg_out[15 : 8] <= temp_reg1;
						
						
						temp_reg0 <= temp_reg0 + step2_reg1;
						temp_reg1 <= temp_reg1 + step2_reg1;
						
											
						enreg_out <= 1'b1;
						counter <= counter + 1'b1;
					end
					else if(counter >= length_cnt)
					begin
						state <= calc0;
						enreg_out <= 1'b0;
						temp_reg0 <= init0_reg1;
						temp_reg1 <= init1_reg1;
						counter <= 16'd0;
					end
					else
					begin
						state <= calc1;
						enreg_out <= 1'b0;
					end
				end
				default:; 
			endcase 
		end 
	end
endmodule 
	
	
	
	
	
	