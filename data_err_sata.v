module data_err_sata(
	input clk,
	input nRST,
	input [7:0] data_in,
	input ack,
	output reg err	
	);

reg [7:0] data_reg0,data_reg1;	

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
else if((data_reg0 != data_reg1+8'h01) & (data_reg0 != 8'd0) & (data_reg1 != 8'd0))
	err <= 1'b1;
else 
	err <= 1'b0;		
end


endmodule
