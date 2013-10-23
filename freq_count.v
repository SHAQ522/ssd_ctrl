module freq_count(clk,door_in,nRST,data_out);
input clk,door_in;
input nRST;
output reg [31:0]data_out;
reg [31:0]count;
reg [31:0]count_reg;
reg door_reg;

always@(posedge clk)  
begin              
    door_reg<=door_in;
end  

always@(posedge clk)  
begin              
  if(door_reg) 
    count<=count+1'b1;  
  else 
    count<=32'd0;   
    count_reg<=count;
end                     

always@(posedge clk or negedge nRST)  
begin
  if(!nRST)
    data_out<=32'd0;
  else if((count==32'd0)&&(count_reg!=32'd0))
    data_out<=count_reg;  
  else 
    ;   
end                     


endmodule
