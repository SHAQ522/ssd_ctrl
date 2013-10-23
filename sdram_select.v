module   sdram_select(
						input [7:0]channel,
						input [14:0]usedw_ch0,
						input [14:0]usedw_ch1,
						input [14:0]usedw_ch2,
						input [14:0]usedw_ch3,
						input [14:0]usedw_ch4,
						input [14:0]usedw_ch5,
						input [14:0]usedw_ch6,
						input [14:0]usedw_ch7,
						input [14:0]usedw_ch8,
						input [14:0]usedw_ch9,
						
						output reg[14:0]usedw_out
					);


always @(*)
begin
	case(channel)
		8'd0: usedw_out = usedw_ch0;
		8'd1: usedw_out = usedw_ch1;
		8'd2: usedw_out = usedw_ch2;
		8'd3: usedw_out = usedw_ch3;
		8'd4: usedw_out = usedw_ch4;
		8'd5: usedw_out = usedw_ch5;
		8'd6: usedw_out = usedw_ch6;
		8'd7: usedw_out = usedw_ch7;
		8'd8: usedw_out = usedw_ch8;
		8'd9: usedw_out = usedw_ch9;
		default:
				usedw_out <= 15'd0;
		endcase	
end	

endmodule

