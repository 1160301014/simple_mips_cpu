`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:27:30 11/02/2018 
// Design Name: 
// Module Name:    registerFile 
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
module RegisterFile(
   input    [4:0]   rs,rt,rd,
    input   [31:0] write_data,
    input       RegWre,RegOut,clk,  
    output [31:0] readData1,readData2
    );
//  integer i;
    wire [4:0] rin;
	 wire nclk=~clk;
    assign rin = (RegOut == 0) ? rt : rd;
	 

    //����31���Ĵ���������Ҫ0�żĴ�����Ϊ������ж�
    reg     [31:0]  register [1:31]; // r1 - r31
    integer i;
    initial begin
      for (i = 1; i < 32; i = i + 1)
        register[i] = 1;
		register[4] = 0;
		register[5] = 10;
		register[6] = 5;
    end
    //0�żĴ���ֵ�̶�Ϊ0
    assign readData1 = (rs == 0)? 0 : register[rs]; // ȡ��
    assign readData2 = (rt == 0)? 0 : register[rt]; // ȡ��

    //��ʱ�������ص�����������õ���ֵ�����õ���ֵ����ָ���Ĵ���
    always @(posedge nclk) 
            if ((rin != 0) && (RegWre == 1)) begin // RegWre==1ʱд��
					register[rin] <= write_data;
				end
 
endmodule