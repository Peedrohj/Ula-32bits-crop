module alu(input1, input2, aluControlOut, shamt, result, aluOp, funct, isOverflowed,opCode);
	input signed [31:0] input1, input2;
	input [4:0] shamt;
	input [5:0] funct,opCode,opOverflowed;
	input [1:0] aluOp;

	output signed [31:0] result;
	
	assign [2:0] aluControlOut;
	assign isOverflowed = 0;
	
	//INICIO: Alu Control
	if(aluOp == 0)
		assign aluControlOut = 0; // Chama um add pq era addi
	if(aluOp == 1)
		assign aluControlOut = 2; // chama um and pq era andi
	if(aluOp == 2)
		funct == 0 ? assign aluControlOut = 4: // SLL
		funct == 2 ? assign aluControlOut = 5:	// SRL
		funct == 3 ? assign aluControlOut = 6: // SRA
		funct == 32 ? assign aluControlOut = 0: // ADD
		funct == 34 ? assign aluControlOut = 1: // SUB
		funct == 36 ? assign aluControlOut = 2: // AND | ANDI
		funct == 37 ? assign aluControlOut = 3: // OR
		funct == 42 ? assign aluControlOut = 7: // SLT 
	
	
	// OverflowCheck
	if(input1 + input2 > 2147483647) 
		// foi overflow
		assign isOverflowed = 1;
		assign opOverflowed = opCode;
		
	//FIM: Alu Control
	//
	assign result = 	 aluControlOut == 0 ? input1 + input2: //ADD/ADDi
						 aluControlOut == 1 ? input1 - input2: //SUB
						 aluControlOut == 2 ? input1 & input2: //AND/ANDi
						 aluControlOut == 3 ? input1 | input2: //OR
						 aluControlOut == 4 ? input1 << shamt: //SLL
						 aluControlOut == 5 ? input1 >> shamt: //SRL
						 aluControlOut == 6 ? input1 >>> shamt: //SRA
						 aluControlOut == 7 ? input1 < input2 ? 1 : 0: //SLT
						 
endmodule
						 