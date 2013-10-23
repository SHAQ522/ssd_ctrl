module LBA_SET(
	input   [31:0]	begin_lba,
	input   [31:0]	end_lba,
	output 	[47:0]	LBA_INIT,
	output 	[47:0]	LBA_END
	);
assign 	LBA_INIT = {16'd0,begin_lba};
assign 	LBA_END = {16'd0,end_lba};
endmodule
