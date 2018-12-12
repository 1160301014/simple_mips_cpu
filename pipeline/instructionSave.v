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
module InsMem(
    input [31:0] PC,
    output reg [31:0] instruction
    );
	 
    reg [31:0] mem [0:64];
    initial begin
        //$readmemh("instr_basic", mem);
		  $readmemh("instr_extra", mem);
		  /*
		  mem[1]=32'b100110_00010_00010_0000000000000000;//sw $2,0($2) 98420000

		  mem[0]=32'b000000_00010_00001_00011_00000000000;//add $3,$2,$1 00411800

		  mem[2]=32'b000010_10000_10001_10010_00000000000;//sub $8,$9,$10 0a119000

		  mem[3]=32'b110000_00011_00011_0000000000000010;//beq $3,$3,2 c0630002

		  mem[4]=32'b000100_00011_00001_0001100000000000;//slt $3,$3,$1 10611800 

		  mem[5]=32'b110010_00000_00000_0000000000000000;//jump 0 c8000000

		  mem[6]=32'b010010_00101_00110_0011100000000000;//or $7,$5,$6 48a63800 01001000101001100011100000000000

		  mem[7]=32'b01000100101001100011100000000000;//and $7,$5,$6 44a63800

		  mem[8]=32'b10011100010001000000000000000000;//lw $4,0($2) 9c440000

		  mem[9]=32'b01010000010000010001100000000000;//xor $3,$2,$1 50411800
		  //Ê®Áù½øÖÆfc000000
		  //mem[10]=32'b11111100000000000000000000000000;//halt
		  //mem[10]=32'b
		  */
   end

    always@(PC) begin
            instruction <= mem[PC >> 2];
            $display("the instruction now is %b,rs: %b,rt: %b,rd: %b imm: %b", instruction[31:26],instruction[25:21],instruction[20:16],instruction[15:11],instruction[15:0]);
        end
endmodule
