module RdRamSourceCon(

					input clk,
					input reset_n,
					
					input [15 : 0] dat_length,
					input update_flag,
					
					input fifo_full_h,
					input ram_oe,
					
					input [15 : 0] ram_dbin,
					
					output reg [9 : 0] ramaddr,
					
					
					
					output reg [15 : 0] dat_out,
					output reg en_out
					
					);
	reg  [15 : 0] dat_length_reg;
	reg  fifo_full_h_reg;
	reg  ram_oe_reg;
	reg  flag_reg0;
	reg  flag_reg1;
	reg  enreg_out;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			flag_reg0 <= 1'b0;
			flag_reg1 <= 1'b0;
			fifo_full_h_reg <= 1'b0;
			ram_oe_reg <= 1'b0;
		end
		else
		begin
			flag_reg0 <= update_flag;
			flag_reg1 <= flag_reg0;
			fifo_full_h_reg <= fifo_full_h;
			ram_oe_reg <= ram_oe;
		end
	end 
	
	reg [15 : 0] counter;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin			
			dat_length_reg <= 16'd0;
		end
		else if (!flag_reg1&flag_reg0)
		begin
			dat_length_reg <= {1'b0,dat_length[15:1]};
		end
	end 
	
	reg [2:0] state;
	parameter idle = 3'd0;
	parameter judge_full = 3'd1;
	parameter calc = 3'd2;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			counter   <= 16'd0;
			state     <= idle;
			ramaddr   <= 10'd0;
			enreg_out <= 1'b0;
		end
		else if (flag_reg0)
		begin
			counter   <= 16'd0;
			state     <= idle;
			enreg_out <= 1'b0;
			ramaddr   <= 10'd0;
		end
		else
		begin
			case (state)
				idle:
				begin
					if (flag_reg1)
					begin
						state <= judge_full;
						enreg_out <= 1'b0;
						ramaddr   <= 10'd0;			
					end
				end
				judge_full:
				begin
					if ((!fifo_full_h_reg) && (ram_oe_reg))
					begin
						state <= calc;
						enreg_out <= 1'b1;
						counter <= 16'd1;
						ramaddr   <= 10'd1;
					end
					else
						state <= judge_full;
					
				end
				calc:
				begin
					if ((!fifo_full_h_reg) && (counter < dat_length_reg))
					begin
						state <= calc;
						enreg_out <= 1'b1;
						counter <= counter + 1'b1;
						ramaddr <= ramaddr + 1'b1;
					end
					else if (counter >= dat_length_reg)
					begin
						state <= judge_full;
						enreg_out <= 1'b0;
						counter   <= 16'd0;
						ramaddr   <= 10'd0;
					end
					else
					begin
						state <= calc;
						enreg_out <= 1'b0;
					end
				end
				default:; 
			endcase
		end 
		
	end
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			dat_out <= 16'd0;
			en_out <= 1'b0;
		end 
		else
		begin
			dat_out <= ram_dbin;
			en_out <= enreg_out;
		end 
	end 
	
endmodule 
	
	
	
					
					
	
					
	