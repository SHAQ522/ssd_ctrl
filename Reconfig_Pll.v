module   Reconfig_Pll(
					input   clk,
					input	pRST,
					input	busy,
					input   [8:0]dataout,
					input	start,
					
					input 	[11:0] l_delay_set,//tap
					input	[8:0] M_set,
					input	[7:0] C0_High_set,
					input   [7:0] C0_Low_set,
					input   [3:0] charge_pump,
					input   [5:0] lowpass_filter_R,
					input   [1:0] lowpass_filter_C,
					input   [8:0] N,
					input   N_bypass,
					input   Phase_posedge,
					
					output  reg  Reconfig,
					output  reg  Rd_param,
					output  reg  Wr_param,
					output  reg  reset_powerup,
					output  reg  [8:0]Data_in,
					output  reg  [3:0]Count_type,
					output  reg  [2:0] Count_param,
					output  reg  [8:0]rddata,
					output  reg   reset_everytime
					);

reg  [7:0]state;
reg  [11:0]l_delay;
reg  [3:0]delay;
reg  FF;
reg  [3:0]state1;
reg  [9:0]count;
reg  start_s0,start_s1;
reg  odd;

always @(posedge clk)
begin
	start_s0<=start;
	start_s1<=start_s0;
end

always @(posedge clk)
begin
	if(C0_High_set==C0_Low_set)
		odd<=1'd0;
	else
		odd<=1'd1;
end
/*********************任务：改变参数*******************************
入口参数：	count_param_reg
			count_type_reg
			data_reg为要植入的数据，9位。*/
			
task  chang_param;
input [2:0]count_param_reg;
input [3:0]count_type_reg;
input [8:0]data_reg;
begin
			case(state1)
				4'd0:
					begin
								Count_param <= count_param_reg;
								Count_type <= count_type_reg;
								Data_in <= data_reg;
								state1 <= 4'd1;
					end
				4'd1:
					begin	
								if(delay < 4'd6) delay <= delay + 1'b1;///
								else
								begin
										delay <= 4'd0; 
										state1 <= 4'd2;
								end
					end
				4'd2:
					begin
								Wr_param <= 1'b1;
								state1 <= 4'd3;
					end
				4'd3:
					begin
								Wr_param <= 1'b0;
								state1 <= 4'd4;
					end
				4'd4:
					begin
								if(!busy) state1 <= 4'd5;
					end
				4'd5:
					begin
								if(count < 10'd400) count <= count + 1'b1;
								else
								begin
											count <= 10'd0;
											state1 <= 4'd0;
											Data_in <= 9'd0;
											Count_param <= 3'd0;
											Count_type <= 4'd0;
											FF <= 1'b1;
								end
					end
				default:state1 <= 4'd0;
			endcase
end
endtask



parameter   Idle=8'd0,reset=8'd1,set1=8'd2,set2=8'd3,set3=8'd4,set4=8'd5,
set5=8'd6,Reconfigure=8'd7,set6=8'd8,judge_delay=8'd9,wait_busy2=8'd10,
set7=8'd11,set8=8'd12,set9=8'd13,set10=8'd14,set11=8'd15,set12=8'd16,set13=8'd17,
set14=8'd18,set15=8'd19,set16=8'd20,set17=8'd21,set18=8'd22,set19=8'd23,set20=8'd24,
set21=8'd25,set22=8'd26,set23=8'd27,set24=8'd28,set25=8'd29,set26=8'd30,set27=8'd31,set28=8'd32,
set29=8'd33,set30=8'd34,set31=8'd35,set32=8'd36,set33=8'd37;
always @(posedge clk or posedge pRST)
if(pRST)
begin
	reset_powerup <= 1'b0;
	Reconfig <= 1'b0;
	FF <= 1'b0;
	Rd_param <= 1'b0;
	rddata <= 9'd0;
	Count_type <= 4'd0;
	Count_param <= 3'd0;
	Data_in <= 9'd0;
	state1 <= 4'd0;
	Wr_param <= 1'b0;
	delay <= 4'd0;
	count<=0;
	reset_everytime<=0;
	state <= Idle;	
end
else
begin
			case(state)
				Idle:
					begin
								reset_powerup <= 1'b0;
								Reconfig <= 1'b0;
								FF <= 1'b0;
								Rd_param <= 1'b0;
								rddata <= 9'd0;
								Count_type <= 4'd0;
								Count_param <= 3'd0;
								Data_in <= 9'd0;
								state1 <= 4'd0;
								Wr_param <= 1'b0;
								delay <= 4'd0;
								count<=0;
								reset_everytime<=0;
								state <= reset;
					end
				reset://---复位锁相环
					begin
								reset_powerup <= 1'b1;
								reset_everytime<=1'b1;
								state <= set1;
					end
				set1:
					begin
								reset_powerup <= 1'b0;
								reset_everytime<=1'b0;
								state <= set2;
					end
				set2:
					begin
								if(!busy) state <= set6;
					end
				set6:
					begin
								if(count<10'd1000)  count <= count + 1'b1;
								else
								begin
											count <= 10'd0;
											state <= set15;
								end
					end
				set15://--初始化
					begin
								count<=0;
								reset_powerup <= 1'b0;
								Reconfig <= 1'b0;
								FF <= 1'b0;
								Rd_param <= 1'b0;
								rddata <= 9'd0;
								Count_type <= 4'd0;
								Count_param <= 3'd0;
								Data_in <= 9'd0;
								state1 <= 4'd0;
								Wr_param <= 1'b0;
								delay <= 4'd0;
								reset_everytime<=0;
								l_delay<=l_delay_set;
								if((start_s0==0) && (start_s1==1))//negedge of start
										state <= set16;
					end
				set16:
					begin
								reset_everytime <= 1'b1;
								state <= set17;
					end
				set17:
					begin
								reset_everytime <= 1'b0;
								state <= set18;
					end
				set18:
					begin
								if(!busy) state <= set4;
					end
				set4:
					begin
								if(count < 10'd1000) count <= count + 1'b1;
								else
								begin
										count <= 10'd0;
										state <= set19;
								end
					end
				set19://------改变M值
					begin	
								if(!FF) chang_param(3'd0,4'd1,M_set[8:0]);
								else 
								begin
											FF <= 1'b0;
											state <= set20;
								end
					end
				set20://-----改变C0的高位
					begin	
								if(!FF) chang_param(3'd0,4'd4,{1'd0,C0_High_set[7:0]});
								else 
								begin
											FF <= 1'b0;
											state <= set21;
								end
					end
					
				set21://-----改变C0的低位
					begin	
								if(!FF) chang_param(3'd1,4'd4,{1'b0,C0_Low_set[7:0]});
								else 
								begin
											FF <= 1'b0;
											state <= set22;
											
								end
					end
				set22://-----改变odd division
					begin
								if(!FF) chang_param(3'd5,4'd4,{8'd0,odd});
								else 
								begin
											FF <= 1'b0;
											state <= set23;
								end
					end
					
				set23://------改变CP
					begin
								if(!FF) chang_param(3'd0,4'd2,{5'd0,charge_pump});
								else 
								begin
											FF <= 1'b0;
											state <= set24;
								end
					end
					
				set24://------改变LF的电阻
					begin
								if(!FF) chang_param(3'd1,4'd2,{3'd0,lowpass_filter_R});
								else 
								begin
											FF <= 1'b0;
											state <= set25;
								end
					end
				
				set25://------改变LF的电容
					begin
								if(!FF) chang_param(3'd2,4'd2,{7'd0,lowpass_filter_C});
								else 
								begin
											FF <= 1'b0;
											state <= set26;
								end
					end
					
				set26://----改变N值
					begin
								if(!FF) chang_param(3'd0,4'd0,N);
								else 
								begin
											FF <= 1'b0;
											state <= set27;
								end
					end
					
				set27://----改变bypass N
					begin
								if(!FF) chang_param(3'd4,4'd0,{8'd0,N_bypass});
								else 
								begin
											FF <= 1'b0;
											state <= set28;
								end
					end
					
				set28:
					begin
								if(!FF) chang_param(3'd2,4'd4,(Phase_posedge?9'd3:9'd1));//3'd2,4'd1,9'd3
								else
								begin
											FF <= 1'b0;
											state <= set29;
								end
					end
					
				set29:
					begin
								if(count<10'd400) count <= count + 1'b1;
								else
								begin
										count <= 10'd0;
										state <= Reconfigure;
								end
					end
				Reconfigure:
					begin
								Reconfig <= 1'b1;
								state <= set30;
					end
				set30:
					begin
								Reconfig <= 1'b0;
								state <= wait_busy2;
					end
				wait_busy2:
					begin
								if(!busy) state <= set31;
					end
				set31:
					begin
								if(count<10'd400) count <= count + 1'b1;
								else
								begin
											count <= 10'd0;
											state <= judge_delay;
								end
					end
					
				judge_delay:
					begin
								if(l_delay > 12'd0)
								begin
										l_delay <= l_delay -12'b1;
										state <= Reconfigure;
								end
								else
								begin
										state <= set32;
										l_delay<=12'd0;
								end
					end
					
				set32:
					begin
								//flag <= flag + 1'b1;
								state <= set15;
					end
				default:state <= Idle;
			endcase
end

endmodule
