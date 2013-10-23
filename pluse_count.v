module pluse_count(clk,door_in,nRST,flag,data_out);
input clk,door_in;
input nRST;
input flag;
output reg [31:0]data_out;
reg [31:0]count;
reg [31:0]count_reg;
reg door_reg;

reg [31:0]data_out_reg;

reg door_pluse;

reg   [31:0]count_p;

always@(posedge clk)  
begin              
  if(count_p>32'd266667) 
    begin
    door_pluse<=~door_pluse;  
    count_p<=32'd0;
    end
  else 
    count_p<=count_p+1'b1;   
end 

always@(posedge clk)  
begin              
    door_reg<=door_in;
end  

always@(posedge clk)  
begin              
  if((door_reg)&(door_pluse)) 
    count<=count+1'b1;  
  else if(!door_pluse)
  begin
    count<=32'd0;   
    count_reg<=count;
  end
  else
	count <= count;
end                     

always@(posedge clk or negedge nRST)  
begin
  if(!nRST)
    data_out_reg<=32'd0;
  else if((count==32'd0)&&(count_reg!=32'd0))
    data_out_reg<={count_reg[30:0],1'd0};  
  else 
    ;   
end   

always@(posedge clk)  
begin
  if(flag == 0)
    data_out <= data_out_reg;
  else
    data_out <= 1000000-data_out_reg; 
end                   


endmodule
