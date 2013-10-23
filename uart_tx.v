module uart_tx(
				input pll_clk,
				input reset_n,
				input fifo_empty,
				input [7:0] par_rd_data,
				output ser_tx,
				output par_rd
			);


			
reg state; 
reg [4:0] cnt5;
reg [3:0] bit_cnt;
reg [7:0] par_rd_data_r;
reg par_rd_r;
reg ser_tx_r;

assign ser_tx = ser_tx_r;
assign par_rd = par_rd_r;


//----------------------------------------------------------------
always@(posedge pll_clk or negedge reset_n) 
begin
	if(!reset_n)
		state <= 1'd0;
	else
	begin
		case(state)
			1'd0:
				begin
					if(!fifo_empty)
						state <= 1'd1;
					else 
						state <= 1'd0;
				end
			1'd1:
				begin
					if(bit_cnt == 4'd10)
						state <= 1'd0;
					else 
						state <= 1'd1;
				end
			default:state <= 1'd0;
		endcase
	end
end
//======================================================================================================//
always@(posedge pll_clk or negedge reset_n)
begin
	if(!reset_n)
		cnt5 <= 5'd0;
	else if(cnt5 == 5'd15)
		cnt5 <= 5'd0;
	else if(state == 1'd0)
		cnt5 <= 5'd0;
	else
		cnt5 <= cnt5 + 1'b1;
end
//======================================================================================================//
always@(posedge pll_clk or negedge reset_n)
begin
	if(!reset_n)
		bit_cnt <= 4'd0;
	else if(state == 1'd0)
		bit_cnt <= 4'd0;
	else if((state == 1'd1) && (cnt5 == 5'd7))
		bit_cnt <= bit_cnt + 1'b1;
end
//======================================================================================================//
always@(posedge pll_clk or negedge reset_n)
begin
	if(!reset_n)
		ser_tx_r <= 1'd1;
	else if((state == 1'd1) && (cnt5 == 5'd7) && (bit_cnt == 4'd0))
		ser_tx_r <= 1'd0;
	else if((state == 1'd1) && (cnt5 == 5'd7) && (bit_cnt <= 4'd8))
		ser_tx_r <= par_rd_data_r[0];
	else if((state == 1'd1) && (cnt5 == 5'd7) && (bit_cnt == 4'd9))
		ser_tx_r <= 1'd1;
end
//======================================================================================================//
always@(posedge pll_clk or negedge reset_n)
begin
	if(!reset_n)
		par_rd_data_r <= 8'd0;
	else if((state == 1'd1) && (cnt5 == 5'd7) && (bit_cnt == 4'd0))
		par_rd_data_r <= par_rd_data;
	else if((state == 1'd1) && (cnt5 == 5'd7) && (bit_cnt <= 4'd8))
		par_rd_data_r <= (par_rd_data_r >> 1'b1);
end
//======================================================================================================//
always@(posedge pll_clk or negedge reset_n)
begin
	if(!reset_n)
		par_rd_r <= 1'd0;
	else if((state == 1'd1) && (cnt5 == 5'd7) && (bit_cnt == 4'd0))
		par_rd_r <= 1'd1;
	else
		par_rd_r <= 1'd0;
end
//======================================================================================================//
endmodule
