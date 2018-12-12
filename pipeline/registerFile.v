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
    input   [4:0]   rs,rt,targReg,
    input   [31:0] write_data,
    input       RegWre,clk,  
    output reg [31:0] readData1,readData2 
    );
	 
    //����31���Ĵ���������Ҫ0�żĴ�����Ϊ������ж�
    reg     [31:0]  register [0:31]; // r1 - r31
    integer i;
    initial begin
		//$readmemh("regf_basic", register,1);
		$readmemh("regf_extra", register);
		$display("%h",register[1]);
      /*for (i = 1; i < 32; i = i + 1)
        register[i] = 1;
		register[4] = 0;
		register[5] = 10;
		register[6] = 5;
		*/
    end
    //��ʱ���½��ص�����������õ���ֵ�����õ���ֵ����ָ���Ĵ���
	 always @(negedge clk)
		begin
			if ((targReg != 0) && (RegWre == 1)) begin // RegWre==1ʱд��
					register[targReg] = write_data;
				end
			readData1 = (rs == 0)? 0 : register[rs];
			readData2 = (rt == 0)? 0 : register[rt];
		end
endmodule