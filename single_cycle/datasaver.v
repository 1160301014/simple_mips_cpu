`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:33:23 11/02/2018 
// Design Name: 
// Module Name:    datasaver 
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
module DataSaver(
    input [31:0] result,
    input [31:0] readData2,
    input DataMemRW,
    input ALUM2Reg,
    output [31:0] write_data
    );

    reg [31:0] DataMem [0:63];
    reg [31:0] DataOut;
    //初始化
    integer i;
    initial begin
        for (i = 0; i < 64; i = i + 1)
            DataMem[i] = 0;
    end

    //通过判断DataMemRW的值来判断要进行读操作还是写操作

    always@(result or DataMemRW) begin
        if (DataMemRW == 0) //lw
            DataOut = DataMem[result];
        else   //sw
            DataMem[result] = readData2;
    end
     // == 0 是alu运算输出， == 1是数据存储输出  数据选择器
        assign write_data = (ALUM2Reg == 0) ? result : DataOut;
endmodule

