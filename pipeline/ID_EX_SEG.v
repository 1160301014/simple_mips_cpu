`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:40:59 12/08/2018 
// Design Name: 
// Module Name:    ID_EX_SEG 
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
module ID_EX_SEG(
	 input Clk,
	 input stall,
	 input flush,

	 input PCWre,
	 input if_wr_reg,
	 input isLW,
    input ALUSrcB,
    input ALUM2Reg,
    input DataMemRW,
	 input [2:0] ALUOp,
	 input [31:0] readData1,
	 input [31:0] readData2,
    input [31:0] targPcOut_ID,
	 input [31:0] immediate_32,
	 input [4:0] rs,
	 input [4:0] rt,
	 input rs_src,
	 input rt_src,
	 input [4:0] targReg,

	 output reg PCWre_ID_EX_SEG_out,
	 output reg if_wr_reg_ID_EX_SEG_out,
	 output reg isLW_ID_EX_SEG_out,
    output reg ALUSrcB_ID_EX_SEG_out,
    output reg ALUM2Reg_ID_EX_SEG_out,
    output reg DataMemRW_ID_EX_SEG_out,
	 output reg [2:0] ALUOp_ID_EX_SEG_out,
	 output reg [31:0] readData1_ID_EX_SEG_out,
	 output reg [31:0] readData2_ID_EX_SEG_out,
    output reg [31:0] targPcOut_ID_ID_EX_SEG_out,
	 output reg [31:0] immediate_32_ID_EX_SEG_out,
	 output reg [4:0] rs_ID_EX_SEG_out,
	 output reg [4:0] rt_ID_EX_SEG_out,
	 output reg rs_src_ID_EX_SEG_out,
	 output reg rt_src_ID_EX_SEG_out,
	 output reg [4:0] targReg_ID_EX_SEG_out
    );
	 
always@(posedge Clk)
begin

if(flush)
begin
	PCWre_ID_EX_SEG_out <= 1'b0;
	if_wr_reg_ID_EX_SEG_out <= 1'b0;
	isLW_ID_EX_SEG_out <= 1'b0;
	ALUSrcB_ID_EX_SEG_out <= 1'b0;
	ALUM2Reg_ID_EX_SEG_out <= 1'b0;
	DataMemRW_ID_EX_SEG_out <= 1'b0;
	ALUOp_ID_EX_SEG_out <= 3'b0;
	readData1_ID_EX_SEG_out <= 32'b0;
	readData2_ID_EX_SEG_out <= 32'b0;
	targPcOut_ID_ID_EX_SEG_out <= 32'b0;
	immediate_32_ID_EX_SEG_out <= 32'b0;
	rs_ID_EX_SEG_out <= 5'b0;
	rt_ID_EX_SEG_out <= 5'b0;
	rs_src_ID_EX_SEG_out <= 1'b0;
	rt_src_ID_EX_SEG_out <= 1'b0;
	targReg_ID_EX_SEG_out <= 5'b0;
end
else if(~stall)
begin
	 //#10
	 PCWre_ID_EX_SEG_out <= PCWre;
	 if_wr_reg_ID_EX_SEG_out <= if_wr_reg;
	 isLW_ID_EX_SEG_out <= isLW;
	 ALUSrcB_ID_EX_SEG_out <= ALUSrcB;
	 ALUM2Reg_ID_EX_SEG_out <= ALUM2Reg;
	 DataMemRW_ID_EX_SEG_out <= DataMemRW;
	 ALUOp_ID_EX_SEG_out <= ALUOp;
	 readData1_ID_EX_SEG_out <= readData1;
	 readData2_ID_EX_SEG_out <= readData2;
	 targPcOut_ID_ID_EX_SEG_out <= targPcOut_ID;
	 immediate_32_ID_EX_SEG_out <= immediate_32;
	 rs_ID_EX_SEG_out <= rs;
	 rt_ID_EX_SEG_out <= rt;
	 rs_src_ID_EX_SEG_out <= rs_src;
	 rt_src_ID_EX_SEG_out <= rt_src;
	 targReg_ID_EX_SEG_out <= targReg;
end

end

endmodule
