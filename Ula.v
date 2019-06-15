module alu(input1, input2, aluControlOut, shamt, result);
	input signed [31:0] input1, input2;
	input [2:0] aluControlOut;
	input [4:0] shamt;
	output signed [31:0] result;
	
	// OverflowCheck
	if(input1 + input2 > 2147483647) 
		// foi overflow
		assign isOverflowed = 1;
		assign opOverflowed = opCode;
	else
		begin
			assign result = aluControlOut == 3'b000' ? input1 + input2: //ADD/ADDi
								 aluControlOut == 3'b001' ? input1 - input2: //SUB
								 aluControlOut == 3'b010' ? input1 & input2: //AND/ANDi
								 aluControlOut == 3'b011' ? input1 | input2: //OR
								 aluControlOut == 3'b100' ? input1 << shamt: //SLL
								 aluControlOut == 3'b101' ? input1 >> shamt: //SRL
								 aluControlOut == 3'b110' ? input1 >>> shamt: //SRA
								 aluControlOut == 3'b111' ? input1 < input2 ? 1 : 0; //SLT
		end		
endmodule

module aluControl(aluOp, funct, opCode):
	input [5:0] funct,opCode,opOverflowed;
	input [1:0] aluOp;
	assign [2:0] aluControlOut;
	assign isOverflowed = 0;
	
	if(aluOp == 0)
		assign aluControlOut = 0; // Chama um add pq era addi
	if(aluOp == 1)
		assign aluControlOut = 2; // chama um and pq era andi
	if(aluOp == 2)
		funct == 0 ? assign aluControlOut = 3'b100': // SLL
		funct == 2 ? assign aluControlOut = 3'b101':	// SRL
		funct == 3 ? assign aluControlOut = 3'b110': // SRA
		funct == 32 ? assign aluControlOut = 3'b000': // ADD
		funct == 34 ? assign aluControlOut = 3'b001': // SUB
		funct == 36 ? assign aluControlOut = 3'b010': // AND | ANDI
		funct == 37 ? assign aluControlOut = 3'b011': // OR
		funct == 42 ? assign aluControlOut = 3'b111': // SLT 
		

endmodule
						 
