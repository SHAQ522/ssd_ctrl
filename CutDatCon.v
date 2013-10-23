module CutDatCon(
					input clk,
					input reset_n,
					
					input start_en,
					input stop_en,
					
					input [31 : 0] total_num,
					input [31 : 0] cut_num,
					
					input [13 : 0] fifo_rdnum,
					input [12 : 0] fifo_wrnum,
					
					output reg rdacq,
					input [15 : 0] dat_in,
					
					output reg en_out,
					output reg [15 : 0] dat_out
					
					);
					
					
	reg start_reg0;
	reg start_reg1;
	reg stop_reg0;
	reg stop_reg1;
	
	always @ (posedge clk)
	begin
		start_reg0 <= start_en;
		start_reg1 <= start_reg0;
		stop_reg0 <= stop_en;
		stop_reg1 <= stop_reg0;
	end 
	
	reg fifo_available;
	always @ (posedge clk or negedge reset_n)
	begin
		if(!reset_n)
			fifo_available <= 1'b0;
		else if(fifo_rdnum>=14'd4&&fifo_wrnum<=13'd4000)
			fifo_available <= 1'b1;
		else
			fifo_available <= 1'b0;
	end 
	
	reg state;
	reg [31 : 0] count;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if(!reset_n)
		begin
			state <= 1'b0;
			count <= 32'd0;
			rdacq <= 1'b0;
		end
		else if(!state&&start_reg0&&!start_reg1)
		begin
			state <= 1'b1;
			count <= 32'd0;
			rdacq <= 1'b0;
		end 
		else if(stop_reg0&&!stop_reg1)
		begin
			state <= 1'b0;
			count <= 32'd0;
			rdacq <= 1'b0;
		end
		else if (state && fifo_available)
		begin
			rdacq <= 1'b1;
			if(count <= total_num)
			begin
				count <= count + 1'b1;
			end
			else
			begin
				count <= 32'd1;
			end
		end
		else if (state && !fifo_available)
		begin
			rdacq <= 1'b0;
		end
	end 
	
	always @ (posedge clk or negedge reset_n)
	begin 
		if(!reset_n)
		begin
			en_out <= 1'b0;
			dat_out <= 16'd0;
		end 
		else if(rdacq&&count<=cut_num)
		begin
			en_out <= 1'b1;
			dat_out <= dat_in;
		end 
		else
		begin
			en_out <= 1'b0;
			dat_out <= 16'd0;
		end
	end 
	
	
	
endmodule 