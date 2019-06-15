module alu(input1, input2, aluControlOut, shumt, result, aluOp, funct, isOverflowed);
	input signed [31:0] input1, input2;
	input [4:0] shumt;
	output signed [31:0] result;
	assign isOverflowed = 0;
	
	// Alu Control
	if(aluOp == 0)
		assign aluControlOut = 0; // Chama um add pq era addi
	if(aluOp == 1)
		assign aluControlOut = 2; // chama um and pq era andi
	
	// OverflowCheck
	if(input1 + input2 > 2147483647) 
		// foi overflow
		assign isOverflowed = 1;
	
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
						 