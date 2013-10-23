module telemetry_signal(
	input clk,
	input out_en,	
	output reg signal_tele
	);

always @(posedge clk)
begin
	signal_tele <= out_en;
end

endmodule
