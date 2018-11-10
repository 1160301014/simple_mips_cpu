`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:21:27 11/02/2018 
// Design Name: 
// Module Name:    cpucode 
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
module CPU_CPU_sch_tb(input clk);

//��ģ������Ҫ��ֵ�ı���
    wire [5:0] operation;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [15:0] immediate_16;
    //reg clk;
    wire [31:0] result;
    wire [31:0] write_data;

//controlunit�����Ŀ����ź���
    wire PCWre;
    wire ALUSrcB;
    wire ALUM2Reg;
    wire RegWre;
    wire InsMemRW;
    wire DataMemRW;
    wire ExtSel;
    wire PCSrc;
    wire RegOut;
    wire [2:0] ALUOp;

//������ģ���໥���ݵ���
    wire [31:0] instruction;
    reg [31:0] PC;

    wire [31:0] immediate_32;
    wire [31:0] readData1;
    wire [31:0] readData2;
    wire zero;


initial begin
    PC = 0;
    //clk = 0;
end
   //always #2
        //clk = ~clk;


//����PC��ַ����ҪInsMemRW��ֵ��ȷ���Ƕ�ָ���дָ��õ���ֵ����instruction
InstructionSave instructionsave(PC, instruction);

//�ֽ��õ���ָ��instruction�������
assign operation[5:0] = instruction[31:26];
assign rs = instruction[25:21];
assign rt = instruction[20:16];
assign rd = instruction[15:11];
assign immediate_16 = instruction[15:0];

//�������ControlUnit,zero����bne��beqָ����ж���ת
ControlUnit controlunit (operation, zero, PCWre, ALUSrcB, ALUM2Reg, RegWre, InsMemRW, DataMemRW, ExtSel, PCSrc, RegOut,ALUOp);

RegisterFile registerfile (rs, rt, rd, write_data, RegWre, RegOut,clk,readData1,readData2);

Extend extend(immediate_16, ExtSel, immediate_32);

ALU alu(readData1, readData2, immediate_32, ALUSrcB, ALUOp, zero, result);

DataSaver datasaver(result, readData2, DataMemRW, ALUM2Reg, write_data);



//ִ����һ��ָ��
always@(posedge clk) begin
   if  ( PCWre == 1)
    PC <= (PCSrc == 0)? PC + 4 : PC + 4 + immediate_32 * 4;
    else 
    PC <= PC;
end
 
endmodule
