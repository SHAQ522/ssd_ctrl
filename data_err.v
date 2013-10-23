module data_err(
	input clk,
	input nRST,
	input [12:0] fifo_usedw,
	input [15:0] data_in,
	output reg ack,
	output reg err
	);

reg [15:0] data_reg0,data_reg1;	

always@(posedge clk)
begin
if(fifo_usedw > 13'd20)
	ack <= 1'b1;
else 
	ack <= 1'b0;	
end

always@(posedge clk)
begin
if(ack)
	begin
	  data_reg0 <= data_in;
	  data_reg1 <= data_reg0;
	end
else 
	;	
end

always@(posedge clk or negedge nRST)
begin
if(!nRST)
	err <= 1'b0;
else if((data_reg0[15:0] != data_reg1[15:0]+16'h0202) & (data_reg0 != 16'd0) & (data_reg1 != 16'd0))
	err <= 1'b1;
else 
	err <= 1'b0;		
end


endmodule
