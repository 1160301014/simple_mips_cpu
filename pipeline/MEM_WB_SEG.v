`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:10:26 12/08/2018 
// Design Name: 
// Module Name:    MEM_WB_SEG 
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
module MEM_WB_SEG(
input Clk,
input stall,
input flush,

input [31:0] result,
input [31:0] DataOut,
input  ALUM2Reg,
input [4:0] r2wr,
input if_wr_reg,

output reg [31:0] result_MEM_WB_SEG_out,
output reg [31:0] DataOut_MEM_WB_SEG_out,
output reg ALUM2Reg_MEM_WB_SEG_out,
output reg [4:0] r2wr_MEM_WB_SEG_out,
output reg if_wr_reg_MEM_WB_SEG_out
    );

always@(posedge Clk)
begin

if(flush)
begin
 result_MEM_WB_SEG_out <= 32'b0;
 DataOut_MEM_WB_SEG_out <= 32'b0;
 ALUM2Reg_MEM_WB_SEG_out <= 1'b0;
 r2wr_MEM_WB_SEG_out <= 5'b0;
 if_wr_reg_MEM_WB_SEG_out <= 1'b0;
end

else if(~stall)
begin
  //#5
  result_MEM_WB_SEG_out <= result;
  DataOut_MEM_WB_SEG_out <= DataOut;
  ALUM2Reg_MEM_WB_SEG_out <= ALUM2Reg;
  r2wr_MEM_WB_SEG_out <= r2wr;
  if_wr_reg_MEM_WB_SEG_out <= if_wr_reg;
end

end
endmodule
