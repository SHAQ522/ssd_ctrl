module ram_ch(
				input [15 : 0] ram_oe,
				input [3 : 0] ch_num,
				
				output reg ram_oe_out
			);
	always @ (*)
	begin
		case (ch_num)
		4'd0:
			ram_oe_out <= ram_oe[0];
		4'd1:
			ram_oe_out <= ram_oe[1];
		4'd2:
			ram_oe_out <= ram_oe[2];
		4'd3:
			ram_oe_out <= ram_oe[3];
		4'd4:
			ram_oe_out <= ram_oe[4];
		4'd5:
			ram_oe_out <= ram_oe[5];
		4'd6:
			ram_oe_out <= ram_oe[6];
		4'd7:
			ram_oe_out <= ram_oe[7];
		4'd8:
			ram_oe_out <= ram_oe[8];
		4'd9:
			ram_oe_out <= ram_oe[9];
		4'd10:
			ram_oe_out <= ram_oe[10];
		4'd11:
			ram_oe_out <= ram_oe[11];
		4'd12:
			ram_oe_out <= ram_oe[12];
		4'd13:
			ram_oe_out <= ram_oe[13];
		4'd14:
			ram_oe_out <= ram_oe[14];
		4'd15:
			ram_oe_out <= ram_oe[15];
		default:
			ram_oe_out <= 1'b0;
		endcase
	end 
	
endmodule 