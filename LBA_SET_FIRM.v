module LBA_SET_FIRM(
	output 	[47:0]	LBA_INIT,
	output 	[47:0]	LBA_END
	);
assign 	LBA_INIT = 48'h0000_0000_0000;
assign 	LBA_END = 48'h0001_0000_0000;

endmodule
