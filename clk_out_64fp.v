module   clk_out_64fp(
						input clk,
						output clk_1,
						output clk_8,
						output clk_128,
						output clk_1024
					);

reg [15:0]count;

always@(posedge clk)  
begin              
    count<=count+1'b1;   
end  

assign clk_1 = clk;
assign clk_8 = count[2];
assign clk_128 = count[6];
assign clk_1024 = count[9];

endmodule

