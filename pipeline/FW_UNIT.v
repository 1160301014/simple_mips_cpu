`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:20:27 12/09/2018 
// Design Name: 
// Module Name:    FW_UNIT 
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
module FW_UNIT(
input clk,
input [4:0] rs_id_ex,
input [4:0] rt_id_ex,
input rs_src_ID_EX,
input rt_src_ID_EX,
input [4:0] reg2wr_ex_mem,
input [4:0] reg2wr_mem_wb,
input wr_reg_ex_mem,
input wr_reg_mem_wb,
output reg [1:0] forward_A,
output reg [1:0] forward_B
    );
	 always @(negedge clk) begin
	   //#12
		if(wr_reg_ex_mem && reg2wr_ex_mem == rs_id_ex && rs_src_ID_EX)
			forward_A <= 2'b1;
		else if(wr_reg_mem_wb && reg2wr_mem_wb == rs_id_ex && rs_src_ID_EX)
			forward_A <= 2'b10;
		else
			forward_A <= 2'b0;
	 end
	 
	 always @(negedge clk) begin
	   //#12
		if(wr_reg_ex_mem && reg2wr_ex_mem == rt_id_ex && rt_src_ID_EX)
			forward_B <= 2'b1;
		else if(wr_reg_mem_wb && reg2wr_mem_wb == rt_id_ex && rt_src_ID_EX)
			forward_B <= 2'b10;
		else
			forward_B <= 2'b0;
	 end

endmodule
