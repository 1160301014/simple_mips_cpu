`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:44:57 12/08/2018 
// Design Name: 
// Module Name:    EX 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module EX(
	 input [31:0] readData1,//rs
    input [31:0] readData2,//rt
    input [31:0] immediate_32,
    input choose_immediate_32,//Ñ¡Ôñimmediate_32
    input [2:0] ALUOp,
	 
    input [1:0] forward_A,
	 input [1:0] forward_B,
	 input [31:0] regV2wr_ex_mem,
	 input [31:0] regV2wr_wb,
    output [31:0] result,
	 output reg [31:0] readData2_EX
    );
	 reg [31:0] aluA,aluB;
	 
    always @(*) begin
		if(choose_immediate_32)
			aluB <= immediate_32;
		else if(forward_B == 2'b1) begin
			aluB <= regV2wr_ex_mem;
			readData2_EX <= regV2wr_ex_mem;
			end
		else if(forward_B == 2'b10) begin
			aluB <= regV2wr_wb;
			readData2_EX <= regV2wr_wb;
			end
		else begin
			aluB <= readData2;
			readData2_EX <= readData2;
			end
	 end
	 
	 always @(*) begin
		if(forward_A == 2'b1)
			aluA <= regV2wr_ex_mem;
		else if(forward_A == 2'b10)
			aluA <= regV2wr_wb;
		else
			aluA <= readData1;
	 end
	 
    ALU alu(aluA,aluB,ALUOp,result);

endmodule
