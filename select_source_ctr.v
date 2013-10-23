module   select_source_ctr(
							input clk,
							input flag,
							input en1,
							input [7:0]din1,
							input en2,
							input [7:0]din2,
							output reg [7:0]dout,
							output reg en_out
							);



always @(posedge clk)
begin
	case(flag)
		0:begin
			en_out <= en1;
			dout <= din1;
		end
		1:
		begin
			en_out <= en2;
			dout <= {din2[0],din2[1],din2[2],din2[3],din2[4],din2[5],din2[6],din2[7]};
		end
		default:
			begin
			en_out <= 0;
			dout <= 0;
		end
	endcase
end


endmodule

