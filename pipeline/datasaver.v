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
module DataMem(
    input [31:0] result,
    input [31:0] readData2,
    input DataMemRW,
	 input clk,
    output reg [31:0] DataOut
    );
    reg [31:0] DataMem [0:63];
    wire en;
    //初始化
    integer i;
    initial begin
		//$readmemh("dataf_basic", DataMem);
		$readmemh("dataf_extra", DataMem);
		  /*
        for (i = 0; i < 40; i = i + 1)
            DataMem[i] = 0;
			*/
    end
	 assign en = (result>=0 && result<64)? 1'b1:1'b0;//overflow check
    //通过判断DataMemRW的值来判断要进行读操作还是写操作
    always@(*) 
        if (DataMemRW == 0 && en) //not sw
            DataOut <= DataMem[result];
	 always@(negedge clk)
			if (DataMemRW == 1 && en)//sw
            DataMem[result] <= readData2;
				
endmodule

