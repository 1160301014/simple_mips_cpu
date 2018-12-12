`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:14:48 12/08/2018 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID_SEG(
input Clk,
input stall,
input flush,

input [31:0] PC_in,IR_in,
output reg [31:0] PC_out,IR_out
    );

always@(posedge Clk)
begin

if(flush)
begin
	PC_out <= 32'h00000000;
	IR_out <= 32'h00000000;
end
else if(~stall)
begin
	//#15
	PC_out <= PC_in;
	IR_out <= IR_in;
end

end
endmodule
