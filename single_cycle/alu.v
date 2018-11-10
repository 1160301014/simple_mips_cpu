`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:28:57 11/02/2018 
// Design Name: 
// Module Name:    alu 
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
module ALU( 
    input [31:0] readData1,
    input [31:0] readData2,
    input [31:0] immediate_32,
    input ALUSrcB,
    input [2:0] ALUOp,
    output wire zero,
    output reg [31:0] result
    );


    wire [31:0] alub;
    //ALUSrcB == 1 要计算立即数
    assign alub = (ALUSrcB == 0) ? readData2 : immediate_32;

    always@( readData1 or alub or ALUOp) begin
       $display("here alu");
        case (ALUOp)
            3'b000: result <= readData1 + alub;
            3'b001: result <= readData1 - alub;
            3'b010: result <= alub - readData1;
            3'b011: result <= readData1 | alub;
            3'b100: result <= readData1 & alub;
            3'b101: result <= ~readData1 & alub;
            3'b110: result <= (~readData1 & alub) | (readData1 & ~alub);
            3'b111: result <= (readData1 < alub)?1:0;//doubt
        endcase

        end
        assign zero = (result == 0) ? 1 : 0;



endmodule
