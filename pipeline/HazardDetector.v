`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:16:56 12/10/2018 
// Design Name: 
// Module Name:    HazardDetector 
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
module HazardDetector(
input next_isLW,
input [4:0] lw_Wr_reg,
input [4:0] id_rs_reg,
input [4:0] id_rt_reg,
input rs_src,
input rt_src,
output stall_PC_IFID,
output flush_IDEX
    );
	 assign stall_PC_IFID = ((lw_Wr_reg==id_rs_reg && rs_src && next_isLW) || (lw_Wr_reg==id_rt_reg && rt_src && next_isLW)) ? 1'b1:1'b0;
	 assign flush_IDEX = ((lw_Wr_reg==id_rs_reg && rs_src && next_isLW) || (lw_Wr_reg==id_rt_reg && rt_src && next_isLW)) ? 1'b1:1'b0;
	 /*always @(*) 
			if((lw_Wr_reg==id_rs_reg && rs_src && next_isLW) || (lw_Wr_reg==id_rt_reg && rt_src && next_isLW)) begin
				stall_PC_IFID = 1'b1;
				flush_IDEX = 1'b1;
			end
			else begin
				stall_PC_IFID = 1'b0;
				flush_IDEX = 1'b0;
			end
			*/
			
endmodule
