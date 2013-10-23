module SsdFifoState(					
					input [15 : 0] ssd_oe,
					input [15 : 0] fifo_full_h,
					
					output  fifo_ready_h
					);
	
	
	assign fifo_ready_h = (ssd_oe == 16'd0) ? 1'b0 : (16'd0==(ssd_oe&fifo_full_h));
	
	endmodule  