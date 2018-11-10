`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:23:35 11/02/2018 
// Design Name: 
// Module Name:    instructionSave 
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
module InstructionSave(
    input [31:0] PC,
    output reg [31:0] instruction
    );
    reg [31:0] mem [0:64];
    initial begin
        //$readmemb("C:\Users\ian\iansProjects\mipsSingle\my_test_rom.txt", mem);
		  mem[0]=32'b10011000010000100000000000000000;//sw $2,0($2) 
		  mem[1]=32'b00000000010000010001100000000000;//add $3,$2,$1 
		  mem[2]=32'b00001000011000010001100000000000;//sub $3,$3,$1
		  mem[3]=32'b11000000010000111111111111111110;//beq $2,$3,-2
		  mem[4]=32'b00010000011000010001100000000000;//slt $3,$3,$1
		  mem[5]=32'b11001000000000000000000000000000;//jump 0
		  mem[6]=32'b01001000101001100011100000000000;//or $7,$5,$6
		  mem[7]=32'b01000100101001100011100000000000;//and $7,$5,$6
		  mem[8]=32'b10011100010001000000000000000000;//lw $4,0($2)
		  mem[9]=32'b01010000010000010001100000000000;//xor $3,$2,$1
		  mem[10]=32'b11111100000000000000000000000000;//halt
		  //mem[10]=32'b
   end

    always@(PC) begin
            instruction <= mem[PC >> 2];
            $display("the instruction now is %b,rs: %b,rt: %b,rd: %b imm: %b", instruction[31:26],instruction[25:21],instruction[20:16],instruction[15:11],instruction[15:0]);
        end
endmodule
