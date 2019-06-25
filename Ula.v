module Ula(input1, input2, shamt, result, aluOp, funct, opCode);
	wire [3:0] aluControlOut;
	input signed [31:0] input1, input2;
	input [4:0] shamt;
	input [5:0] opCode;
	input [5:0] funct;
	input [1:0] aluOp;
	output wire [31:0] result;
	// output [1:0] isOverflowed;
	// output [5:0] opOverflowed;
	
	AluControl aluControl(.aluOpControl(aluOp), .functControl(func), .opCodeControl(opCode), .aluControlOutContrlol(aluControlOut));
	
	MainUla mainUla(.inputUla1(input1), .inputUla2(input2), .aluControlOutUla(aluControlOut), .shamtUla(shamt), .resultUla(result), .opCodeUla(opCode));
	
	

endmodule


module MainUla(inputUla1, inputUla2, aluControlOutUla, shamtUla, resultUla, opCodeUla);
	input signed [31:0] inputUla1, inputUla2;
	input [3:0] aluControlOutUla;
	input [4:0] shamtUla;
	input [5:0] opCodeUla;
	output wire signed [31:0] resultUla;
	//output [1:0] isOverflowedUla;
	//output [5:0] opOverflowedUla;
	
	// OverflowCheck
	/*
	always @ (posedge clk) begin
		if(input1 + input2 > 2147483647) begin
			// foi overflow	
			isOverflowed = 2'b11;
			opOverflowed = 6'b101010;
		end else begin
	*/
	assign resultUla[31:0] = (aluControlOutUla == 4'b0000) ? inputUla1 + inputUla2: //ADD/ADDi
						 (aluControlOutUla == 4'b0001) ? inputUla1 - inputUla2: //SUB
						 (aluControlOutUla == 4'b0010) ? inputUla1 & inputUla2: //AND/ANDi
						 (aluControlOutUla == 4'b0011) ? inputUla1 | inputUla2: //OR
						 (aluControlOutUla == 4'b00100) ? inputUla1 << shamtUla: //SLL
						 (aluControlOutUla == 4'b0101) ? inputUla1 >> shamtUla: //SRL
						 aluControlOutUla == 4'b0110 ? inputUla1 >>> shamtUla: //SRA
						 aluControlOutUla == 4'b0111 ? inputUla1 < inputUla2 ? 1 : 0 : 0; //SLT
		//end
	//end
endmodule

module AluControl(aluOpControl, functControl, opCodeControl, aluControlOutContrlol);
	input [5:0] functControl;
	input [5:0] opCodeControl;
	input [1:0] aluOpControl;
	output reg [2:0] aluControlOutContrlol;
	assign isOverflowed = 0;

	
	always @(*) begin
		if(aluOpControl == 0) begin
			aluControlOutContrlol = 0; // Chama um add pq era addi
		end if(aluOpControl == 1) begin
			aluControlOutContrlol = 2; // chama um and pq era andi
		end if(aluOpControl == 2) begin
			
			aluControlOutContrlol = functControl == 0 ? 4: // SLL
			functControl == 2 ? 5:	// SRL
			functControl == 3 ? 6: // SRA
			functControl == 32 ? 0: // ADD
			functControl == 34 ? 1: // SUB
			functControl == 36 ? 2: // AND | ANDI
			functControl == 37 ? 3: // OR
			functControl == 42 ? 7: 0; // SLT 
		end
	end
endmodule				 