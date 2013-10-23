module   sdram_select_r(
						input [7:0]channel,
						
						input ready_ch0,
						input ready_ch1,
						input ready_ch2,
						input ready_ch3,
						input ready_ch4,
						input ready_ch5,
						input ready_ch6,
						input ready_ch7,
						input ready_ch8,
						input ready_ch9,
						input ready_ch10,
						input ready_ch11,
						input ready_ch12,
						input ready_ch13,
						input ready_ch14,
						input ready_ch15,
						input ready_ch16,
						input ready_ch17,
						input ready_ch18,
						input ready_ch19,
						
						output reg fifo_ready
					);


always @(*)
begin
	case(channel)
		8'd0: fifo_ready = ready_ch0;
		8'd1: fifo_ready = ready_ch1;
		8'd2: fifo_ready = ready_ch2;
		8'd3: fifo_ready = ready_ch3;
		8'd4: fifo_ready = ready_ch4;
		8'd5: fifo_ready = ready_ch5;
		8'd6: fifo_ready = ready_ch6;
		8'd7: fifo_ready = ready_ch7;
		8'd8: fifo_ready = ready_ch8;
		8'd9: fifo_ready = ready_ch9;
		8'd10: fifo_ready = ready_ch10;
		8'd11: fifo_ready = ready_ch11;
		8'd12: fifo_ready = ready_ch12;
		8'd13: fifo_ready = ready_ch13;
		8'd14: fifo_ready = ready_ch14;
		8'd15: fifo_ready = ready_ch15;
		8'd16: fifo_ready = ready_ch16;
		8'd17: fifo_ready = ready_ch17;
		8'd18: fifo_ready = ready_ch18;
		8'd19: fifo_ready = ready_ch19;
		default:
				fifo_ready = 1'b0;
		endcase	
end	

endmodule

