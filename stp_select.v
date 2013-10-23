module   stp_select(
						input [7:0]channel,
						
						input clk_0,input en_0,input [15:0]data_0,
						input clk_1,input en_1,input [15:0]data_1,
						input clk_2,input en_2,input [15:0]data_2,
						input clk_3,input en_3,input [15:0]data_3,
						input clk_4,input en_4,input [15:0]data_4,
						input clk_5,input en_5,input [15:0]data_5,
						input clk_6,input en_6,input [15:0]data_6,
						input clk_7,input en_7,input [15:0]data_7,
						input clk_8,input en_8,input [15:0]data_8,
						input clk_9,input en_9,input [15:0]data_9,
						input clk_10,input en_10,input [15:0]data_10,
						input clk_11,input en_11,input [15:0]data_11,
						input clk_12,input en_12,input [15:0]data_12,
						input clk_13,input en_13,input [15:0]data_13,
						input clk_14,input en_14,input [15:0]data_14,
						input clk_15,input en_15,input [15:0]data_15,
							
						output reg clk_out,
						output reg en_out,
						output reg [15:0]data_out
					);


always @(*)
begin
	case(channel)
		8'd0: begin clk_out = clk_0;en_out = en_0;data_out = data_0;end
		8'd1: begin clk_out = clk_1;en_out = en_1;data_out = data_1;end
		8'd2: begin clk_out = clk_2;en_out = en_2;data_out = data_2;end
		8'd3: begin clk_out = clk_3;en_out = en_3;data_out = data_3;end
		8'd4: begin clk_out = clk_4;en_out = en_4;data_out = data_4;end
		8'd5: begin clk_out = clk_5;en_out = en_5;data_out = data_5;end
		8'd6: begin clk_out = clk_6;en_out = en_6;data_out = data_6;end
		8'd7: begin clk_out = clk_7;en_out = en_7;data_out = data_7;end
		8'd8: begin clk_out = clk_8;en_out = en_8;data_out = data_8;end
		8'd9: begin clk_out = clk_9;en_out = en_9;data_out = data_9;end
		8'd10:begin clk_out = clk_10;en_out = en_10;data_out = data_10;end
		8'd11:begin clk_out = clk_11;en_out = en_11;data_out = data_11;end
		8'd12:begin clk_out = clk_12;en_out = en_12;data_out = data_12;end
		8'd13:begin clk_out = clk_13;en_out = en_13;data_out = data_13;end
		8'd14:begin clk_out = clk_14;en_out = en_14;data_out = data_14;end
		8'd15:begin clk_out = clk_15;en_out = en_15;data_out = data_15;end
		default:
			  begin clk_out = clk_0;en_out = en_0;data_out = data_0;end
		endcase	
end	

endmodule

