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
    input zero,
    output  PCWre,
    output  ALUSrcB,
    output  ALUM2Reg,
    output  RegWre,
    output  InsMemRW,
    output  DataMemRW,
    output  ExtSel,
    output  PCSrc,
    output  RegOut,
    output  [2:0] ALUOp
    );
	//parameter ADDI = 6'b000001,ORI = 6'b010000,MOVE = 6'b100000；
    parameter ADD = 6'b000000, SUB = 6'b000010, AND = 6'b010001, OR = 6'b010010, 
	 SW = 6'b100110,LW = 6'b100111, BEQ = 6'b110000, HALT = 6'b111111,XOR=6'b010100,
	 SLT=6'b000100,JMP=6'b110010;
	//reg i_addi，i_ori,i_move,
   reg i_add,i_sub,i_and,i_or,i_xor,i_slt,i_jmp,i_sw,i_lw,i_beq,i_halt;

    always@(operation) begin
            //初始化这些变量
            i_add = 0;
            //i_addi = 0;
            i_sub = 0;
            //i_ori = 0;
            i_and = 0;
            i_or = 0;
            //i_move = 0;
            i_sw = 0;
            i_lw = 0;
            i_beq = 0;
            i_halt = 0;
				i_xor=0;
				i_slt=0;
				i_jmp=0;
            //如果是对应操作码则将对应变量名置为1
            case(operation)
                ADD: i_add = 1;
                //ADDI: i_addi = 1;
                SUB: i_sub = 1;
                //ORI: i_ori = 1;
                AND: i_and = 1;
                OR: i_or = 1;
                //MOVE: i_move = 1;
                SW: i_sw = 1;
                LW: i_lw = 1;
                BEQ: i_beq = 1;
                HALT: i_halt = 1;
					 SLT: i_slt=1;
					 XOR: i_xor=1;
					 JMP: i_jmp=1;
            endcase
        end
        //有点类似数字电路中学到的真值表。将各个信号直接用操作码的变量表示。
        assign PCWre = !i_halt;
        assign ALUSrcB = i_sw || i_lw;
        assign ALUM2Reg = i_lw;
        assign RegWre = !(i_sw || i_beq || i_jmp);
        assign InsMemRW = 0;
        assign DataMemRW = i_sw;
        assign ExtSel = 1;   
        assign PCSrc = (i_beq && zero)|| i_jmp ; //beq且相减之后值为0
        assign RegOut = !i_lw;
        assign ALUOp = {i_and || i_xor || i_slt, i_or || i_xor || i_slt, i_slt || i_jmp || i_sub || i_or || i_beq};

endmodule

