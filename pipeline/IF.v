`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:34:46 12/08/2018 
// Design Name: 
// Module Name:    IF 
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
module PC(
input Clk,
input [31:0] PC_in,

output reg [31:0] PC_out);

initial
begin
	PC_out = 32'b0;
end

always@(negedge Clk)
begin
	PC_out = PC_in;
end
endmodule


module IF(
input clk,
input [31:0] targPC,
input PCwre,
input stall,

output [31:0] NPC,
output [31:0] instruction
    );
	 reg [31:0] pcIn;
	 reg ini;
	 wire [31:0] pcOut;
	 
	 initial begin
    pcIn = 32'h00000000;
	 ini = 1'b1;
	 end
	 always @(stall or pcOut) 
		if(stall == 1'b1)
			pcIn = pcOut;
		else if(PCwre == 1'b1)
			pcIn = targPC;
		else
			pcIn = pcOut+4;
	
	 assign NPC = pcOut+4;
	 PC pcSave(clk,pcIn,pcOut);
    InsMem insmem(pcOut, instruction);
endmodule
