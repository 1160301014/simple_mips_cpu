`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:36:18 12/08/2018 
// Design Name: 
// Module Name:    ID 
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
module ID(
	 input clk,
    input [31:0] instruction,
	 input [31:0] pcIn_ID,
	 input [31:0] write_data,
	 input [4:0] r2wr,
	 //cu output
	 output  if_wr_reg,////1表示写寄存器，0表示不写寄存器
	 output  PCWre,//1表示跳转，0表示不跳转
	 output  isLW,//1表示lw
    output  ALUSrcB,
    output  ALUM2Reg,
    output  DataMemRW,
    output [2:0] ALUOp,
	 //regfile output
	 output [31:0] readData1,readData2,
	 output reg [31:0] targPcOut_ID,
	 output [31:0] immediate_32,
	 output [4:0] rs,
    output [4:0] rt,
	 output rs_src,
    output rt_src,
	 output [4:0] targReg
    );
	 
	 wire [5:0] operation;
    wire [15:0] immediate_16;
	 
	 wire [4:0] rd;
	 wire  ExtSel;
	 wire RegOut;
	 
	 assign isLW = ~RegOut;
	 assign operation = instruction[31:26];
	 assign rs = instruction[25:21];
	 assign rt = instruction[20:16];
	 assign rd = instruction[15:11];
	 assign immediate_16 = instruction[15:0];
	 assign targReg = (RegOut == 1'b1)? rd : rt;
	 
	 ControlUnit controlunit (operation,PCWre, ALUSrcB, ALUM2Reg, if_wr_reg, DataMemRW, ExtSel,RegOut,ALUOp,rs_src,rt_src);
	 
	 RegisterFile registerfile (rs,rt,r2wr, write_data,if_wr_reg,clk,readData1,readData2);
	 
    Extend extend(immediate_16, ExtSel, immediate_32);
	 
	 
	 //branch
	 always @(*) 
			if(operation == 6'b110000 && readData2 == readData1)
				targPcOut_ID <= immediate_32*4 + pcIn_ID;
			else if(operation == 6'b110010)
				targPcOut_ID <= immediate_32*4 + pcIn_ID;
		
endmodule
