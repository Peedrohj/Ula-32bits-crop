module alu(input1, input2, aluControlOut, shumt, result);
	input signed [31:0] input1, input2;
	input [3:0] aluControlOut;
	input [4:0] shumt;
	output signed [31:0] result;
	
	assign result = aluControlOut == 0 ? input1 + input2:
						 aluControlOut == 1 ? input1 - input2:
						 aluControlOut == 2 ? input1 & input2:
						 aluControlOut == 3 ? input1 | input2:
						 aluControlOut == 4 ? input1 << shumt:
						 aluControlOut == 5 ? input1 >> shumt:
						 aluControlOut == 6 ? input1 >>> shumt:
						 aluControlOut == 7 ? input1 > input2 ? 1 : 0:
						 aluControlOut == 8 ? input1 < input2 ? 1 : 0;
endmodule

module_
						 