module SourceChoose(
						input clk,
						input reset_n,
						
						input [2 : 0] channel_choose,
						
						input update_flag,
														
						
						
						input [15 : 0] fixed_db,
						input fixed_wren,
						
						input [15 : 0] ram_db,
						input ram_wren,
						
						input [15 : 0] ssd_db,
						input ssd_wren,
						
						output reg [15 : 0] dat_db,
						output reg dat_wren,
						
						output reg fixed_oe,
						output reg ram_oe,
						output reg ssd_oe
											
					);
					
	reg  flag_reg0;
	reg  flag_reg1;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			flag_reg0 <= 1'b0;
			flag_reg1 <= 1'b0;
		end
		else
		begin
			flag_reg0 <= update_flag;
			flag_reg1 <= flag_reg0;
		end
	end 
	
	reg [2 : 0] choose_reg;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			choose_reg <= 3'd0;
		end
		else if(!flag_reg0&flag_reg1)
		begin
			choose_reg <= channel_choose;
		end
	end 
	
	parameter [2 : 0] fixed_num = 3'd1;
	parameter [2 : 0] ram_num = 3'd2;
	parameter [2 : 0] ssd_num = 3'd3;
	parameter [2 : 0] stop_num = 3'd0;
	
	always @ (posedge clk or negedge reset_n)
	begin
		if (!reset_n)
		begin
			dat_db   <= 16'd0;
			dat_wren <= 1'b0;
			fixed_oe <= 1'b0;
			ram_oe <= 1'b0;
			ssd_oe <= 1'b0;
		end
		else
		begin
			case (choose_reg)
				fixed_num:
				begin
					dat_db <= fixed_db;
					dat_wren <= fixed_wren;
					fixed_oe <= 1'b1;
					ram_oe <= 1'b0;
					ssd_oe <= 1'b0;
				end
				ram_num:
				begin
					dat_db <= ram_db;
					dat_wren <= ram_wren;
					fixed_oe <= 1'b0;
					ram_oe <= 1'b1;
					ssd_oe <= 1'b0;
				end
				ssd_num:
				begin
					dat_db <= ssd_db;
					dat_wren <= ssd_wren;
					fixed_oe <= 1'b0;
					ram_oe <= 1'b0;
					ssd_oe <= 1'b1;
				end
				stop_num:
				begin
					dat_db   <= 16'd0;
					dat_wren <= 1'b0;
					fixed_oe <= 1'b0;
					ram_oe <= 1'b0;
					ssd_oe <= 1'b0;
				end
			endcase
		end
	end 
		
	endmodule

	
	