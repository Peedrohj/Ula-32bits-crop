module Ula(input1, input2, aluControlOut, shamt, result, opCode, clk, isOverflowed, opOverflowed);
	input signed [31:0] input1, input2;
	input [2:0] aluControlOut;
	input [4:0] shamt;
	input opCode;
	input clk;
	output reg signed [31:0] result;
	output reg [1:0] isOverflowed;
	output reg [1:0] opOverflowed;
	
	// OverflowCheck
	always @ (posedge clk) begin
		if(input1 + input2 > 2147483647) begin
			// foi overflow	
			isOverflowed <= 01;
			opOverflowed <= opCode;
		end else begin 
				result <= aluControlOut == 0 ? input1 + input2: //ADD/ADDi
									 aluControlOut == 1 ? input1 - input2: //SUB
									 aluControlOut == 2 ? input1 & input2: //AND/ANDi
									 aluControlOut == 3 ? input1 | input2: //OR
									 aluControlOut == 4 ? input1 << shamt: //SLL
									 aluControlOut == 5 ? input1 >> shamt: //SRL
									 aluControlOut == 6 ? input1 >>> shamt: //SRA
									 aluControlOut == 7 ? input1 < input2 ? 1 : 0 : 0; //SLT
		end
	end
endmodule

module aluControl(aluOp, funct, opCode, opOverflowed, aluControlOut, clk);
	input [5:0] funct;
	input [5:0] opCode;
	input [5:0] opOverflowed;
	input [1:0] aluOp;
	output clk;
	output reg [2:0] aluControlOut;
	assign isOverflowed = 0;

	
	always @ (posedge clk) begin
		if(aluOp == 0) begin
			assign aluControlOut = 0; // Chama um add pq era addi
		end if(aluOp == 1) begin
			assign aluControlOut = 2; // chama um and pq era andi
		end if(aluOp == 2) begin
			
			assign aluControlOut = funct == 0 ? 4: // SLL
			funct == 2 ? 5:	// SRL
			funct == 3 ? 6: // SRA
			funct == 32 ? 0: // ADD
			funct == 34 ? 1: // SUB
			funct == 36 ? 2: // AND | ANDI
			funct == 37 ? 3: // OR
			funct == 42 ? 7: 0; // SLT 
		end
	end
endmodule
						 