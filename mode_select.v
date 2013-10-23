module   mode_select(
							input clk,
							input [1:0]mode,
							input en1,
							input [15:0]din1,
							input en2,
							input [15:0]din2,
							input en3,
							input [15:0]din3,
							output reg [15:0]dout,
							output reg en_out
							);



always @(posedge clk)
begin
	case(mode)
		2'd0:begin
			en_out <= en1;
			dout <= {din1[7:0],din1[15:8]};
		end
		2'd1:
		begin
			en_out <= en2;
			dout <= din2;
		end
		2'd2:
		begin
			en_out <= en3;
			dout <= din3;
		end
		default:
			begin
			en_out <= 0;
			dout <= 0;
		end
	endcase
end


endmodule

