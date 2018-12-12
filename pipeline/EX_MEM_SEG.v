`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:10:28 12/08/2018 
// Design Name: 
// Module Name:    EX_WB_SEG 
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
module EX_MEM_SEG(
input Clk,
input stall,
input flush,

input [31:0] result,
input  ALUM2Reg,
input  DataMemRW,
input [31:0] readData2,
input [4:0] r2wr,
input if_wr_reg,

output reg [31:0] result_EX_MEM_SEG_out,
output reg DataMemRW_EX_MEM_SEG_out,
output reg ALUM2Reg_EX_MEM_SEG_out,
output reg [31:0] readData2_EX_MEM_SEG_out,
output reg [4:0] r2wr_EX_MEM_SEG_out,
output reg if_wr_reg_EX_MEM_SEG_out
);
always@(posedge Clk)
begin

if(flush)
begin
	result_EX_MEM_SEG_out<=32'b0;
	DataMemRW_EX_MEM_SEG_out<=1'b0;
	readData2_EX_MEM_SEG_out<=32'b0;
	ALUM2Reg_EX_MEM_SEG_out<=1'b0;
	r2wr_EX_MEM_SEG_out <= 5'b0;
	if_wr_reg_EX_MEM_SEG_out <= 1'b0;
end
else if(~stall)
begin
	 //#5
	 result_EX_MEM_SEG_out<=result;
	 DataMemRW_EX_MEM_SEG_out<=DataMemRW;
	 readData2_EX_MEM_SEG_out<=readData2;
	 ALUM2Reg_EX_MEM_SEG_out<=ALUM2Reg;
	 r2wr_EX_MEM_SEG_out <= r2wr;
	 if_wr_reg_EX_MEM_SEG_out <= if_wr_reg;
end

end

endmodule
