module door_2(clk,door_out);
input clk;
output reg door_out;

reg    [31:0]count;

always@(posedge clk)  
begin              
  if(count==32'd12500000) 
    begin
    door_out<=~door_out;  
    count<=32'd0;
    end
  else 
    count<=count+1'b1;   
end                     


endmodule
