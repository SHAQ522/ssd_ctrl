module ConstantChannelNum(
							output [3 : 0] constant_num
							);
		parameter [3 : 0] num = 4'd0;
		
		assign constant_num = num;
	endmodule 