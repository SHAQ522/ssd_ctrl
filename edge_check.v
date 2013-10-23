module edge_check(clk1,clk2,check_out);

input clk1,clk2;
output reg check_out;

always@(posedge clk1)  
begin              
    check_out <= clk2;  
end                   


endmodule
