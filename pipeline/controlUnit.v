`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:25:38 11/02/2018 
// Design Name: 
// Module Name:    controlUnit 
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
module ControlUnit(
    input [5:0] operation,
    output reg PCWre,
    output reg ALUSrcB,
    output reg ALUM2Reg,
    output reg RegWre,//是否写寄存器的标志
	 output reg DataMemRW,
    output  ExtSel,
    output reg RegOut,// 只有 lw 时为0
    output reg [2:0] ALUOp,
	 output reg rs_src,
    output reg rt_src
    );
	 
    parameter ADD = 6'b000000, SUB = 6'b000010, AND = 6'b010001, OR = 6'b010010, 
	 SW = 6'b100110,LW = 6'b100111, BEQ = 6'b110000, HALT = 6'b111111,XOR=6'b010100,
	 SLT=6'b000100,JMP=6'b110010;
	 
	 assign ExtSel = 1;  
	 		
	 always @(*) begin
		case(operation)
			ADD:begin
			ALUOp <= 3'b000;
			PCWre <= 1'b0;
			ALUSrcB <= 1'b0;
			ALUM2Reg <= 1'b0;
			RegWre <= 1'b1;
			DataMemRW <= 1'b0;
			RegOut <= 1'b1;
			rs_src <= 1'b1;
         rt_src <= 1'b1;
			end
			
			SUB:begin
			ALUOp <= 3'b001;
			PCWre <= 1'b0;
			ALUSrcB <= 1'b0;
			ALUM2Reg <= 1'b0;
			RegWre <= 1'b1;
			DataMemRW <= 1'b0;
			RegOut <= 1'b1;
			rs_src <= 1'b1;
         rt_src <= 1'b1;
			end
			
			AND:begin
			ALUOp <= 3'b100;
			PCWre <= 1'b0;
			ALUSrcB <= 1'b0;
			ALUM2Reg <= 1'b0;
			RegWre <= 1'b1;
			DataMemRW <= 1'b0;
			RegOut <= 1'b1;
			rs_src <= 1'b1;
         rt_src <= 1'b1;
			end
			
			OR:begin
			ALUOp <= 3'b011;
			PCWre <= 1'b0;
			ALUSrcB <= 1'b0;
			ALUM2Reg <= 1'b0;
			RegWre <= 1'b1;
			DataMemRW <= 1'b0;
			RegOut <= 1'b1;
			rs_src <= 1'b1;
         rt_src <= 1'b1;
			end
			
			SW:begin
			ALUOp <= 3'b000;
			PCWre <= 1'b0;
			ALUSrcB <= 1'b1;
			ALUM2Reg <= 1'b0;
			RegWre <= 1'b0;
			DataMemRW <= 1'b1;
			RegOut <= 1'b1;
			rs_src <= 1'b1;
         rt_src <= 1'b1;
			end
			
			LW:begin
			ALUOp <= 3'b000;
			PCWre <= 1'b0;
			ALUSrcB <= 1'b1;
			ALUM2Reg <= 1'b1;
			RegWre <= 1'b1;
			DataMemRW <= 1'b0;
			RegOut <= 1'b0;
			rs_src <= 1'b1;
         rt_src <= 1'b0;
			end
			
			BEQ:begin
			ALUOp <= 3'b001;
			PCWre <= 1'b1;
			ALUSrcB <= 1'b0;
			ALUM2Reg <= 1'b0;
			RegWre <= 1'b0;
			DataMemRW <= 1'b0;
			RegOut <= 1'b1;
			rs_src <= 1'b1;
         rt_src <= 1'b1;
			end
			
			XOR:begin
			ALUOp <= 3'b110;
			PCWre <= 1'b0;
			ALUSrcB <= 1'b0;
			ALUM2Reg <= 1'b0;
			RegWre <= 1'b1;
			DataMemRW <= 1'b0;
			RegOut <= 1'b1;
			rs_src <= 1'b1;
         rt_src <= 1'b1;
			end
			
			SLT:begin
			ALUOp <= 3'b111;
			PCWre <= 1'b0;
			ALUSrcB <= 1'b0;
			ALUM2Reg <= 1'b0;
			RegWre <= 1'b1;
			DataMemRW <= 1'b0;
			RegOut <= 1'b1;
			rs_src <= 1'b1;
         rt_src <= 1'b1;
			end
			
			JMP:begin
			ALUOp <= 3'b001;
			PCWre <= 1'b1;
			ALUSrcB <= 1'b0;
			ALUM2Reg <= 1'b0;
			RegWre <= 1'b0;
			DataMemRW <= 1'b0;
			RegOut <= 1'b1;
			rs_src <= 1'b0;
         rt_src <= 1'b0;
			end
		endcase
	 end
	
endmodule

