`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:49:26 12/08/2018 
// Design Name: 
// Module Name:    MEM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
/* Additional Comments: 
    input [31:0] result,
    input [31:0] readData2,
    input DataMemRW,
	 input clk,
    output reg [31:0] DataOut
*/
//////////////////////////////////////////////////////////////////////////////////
module MEM(
input clk,
input [31:0] result,
input  DataMemRW,
input [31:0] readData2,
output [31:0] DataOut
    );

DataMem dmem(result, readData2, DataMemRW,clk,DataOut);

endmodule
