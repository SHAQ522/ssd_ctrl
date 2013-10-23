module ingress_out(
			input CLK,
			input nRST,
			input[31:0]	DATA_in,
			input packet_sync,		//oriented from "wrreq" of module "ingress.v"
			input MODE_SET,			// command or data from PC
			
			output reg rdreq,
			output reg[9:0] rdaddr,
			
			output reg DATA_en,
			output reg[31:0] DATA_out		
			);
//========================	inspecting "packet_sync"	=========
reg q1, q2, packet_end;

always@(posedge CLK)
begin
	q1 <= packet_sync;
	q2 <= q1;
	if(q1 && !q2)
		begin
			packet_end <= 1'b1;
		end
	else	packet_end <= 1'b0;
end	

wire[11:0]	Width;			
assign Width = MODE_SET?12'd128:12'd1024;//------老信源为命令长度为32个字节，新信源为128个字节，崔勇强改，2010/3/14
			
//========================	state machine ======================
reg[7:0] state;

always@(posedge CLK or negedge nRST)
if(!nRST)
begin
	DATA_en <= 1'b0;
	DATA_out <= 32'd0;
	rdreq <= 1'b0;
	rdaddr <= 10'd0;
	state <= 8'd0;
end
else
begin
	case(state)
		8'd0:
			begin
				DATA_en <= 1'b0;
				DATA_out <= 32'd0;
				rdreq <= 1'b0;
				rdaddr <= 10'd0;
				state <= 8'd1;
			end
		8'd1:
			begin
				if(packet_end)
					begin
						rdreq <= 1'b1;
						state <= 8'd2;
					end
				else 
					state <= 8'd1;
			end
		8'd2:
			begin
				rdaddr <= rdaddr+1'b1;
				state <= 8'd3;
			end
		8'd3:
			begin
				rdaddr <= rdaddr+1'b1;
				DATA_out <= DATA_in;
				DATA_en <= 1'b1;
				state <= 8'd4;
			end
		8'd4:
			begin
				DATA_out <= DATA_in;
				DATA_en <= 1'b1;
				DATA_en <= 1'b1;
				if(rdaddr[8:0]==Width[10:2])	
					state <= 8'd5;
				else	
					state <= 8'd3;
			end
		8'd5:
			begin
				rdreq <= 1'b0;
				DATA_en <= 1'b0;
				rdaddr[8:0] <= 9'd0;
				rdaddr[9] <= ~rdaddr[9];
				state <= 8'd1;
			end
		default:	state <= 8'd0;
	endcase
end			


endmodule
