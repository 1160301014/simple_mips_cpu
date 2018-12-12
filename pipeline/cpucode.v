`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:21:27 11/02/2018 
// Design Name: 
// Module Name:    cpucode 
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
module pipelineCPU
(input clk,input Rst,
output reg [31:0] resultbuf);

//此模块中需要赋值的变量
 

//controlunit产生的控制信号线

//其他的模块相互传递的线
	 //forwarding unit
	 wire [1:0] forward_A;
	 wire [1:0] forward_B;
	 //IF
    wire [31:0] instruction;
	 wire [31:0] NPC;
	 
	 //IF_ID_SEG
	 wire [31:0] pc_if_id_out;
	 wire [31:0] ins_if_id_out;
	 
	 //ID
	 wire PCWre;
	 wire if_wr_reg;
	 wire isLW;
    wire ALUSrcB;
    wire ALUM2Reg;
    wire DataMemRW;
	 wire [2:0] ALUOp;
	 wire [31:0] readData1;
	 wire [31:0] readData2;
    wire [31:0] targPcOut_ID;
	 wire [31:0] immediate_32;
	 wire [4:0] rs;
	 wire [4:0] rt;
	 wire [4:0] targReg;
	 wire rs_src;
	 wire rt_src;
	 
	 //hazard detector
	 wire stall_PC_IFID;
	 wire flush_IDEX;
	 
	 //ID_EX_SEG 流出的线
	 wire PCWre_ID_EX_SEG_out;
	 wire if_wr_reg_ID_EX_SEG_out;
	 wire isLW_ID_EX_SEG_out;
    wire ALUSrcB_ID_EX_SEG_out;
    wire ALUM2Reg_ID_EX_SEG_out;
    wire DataMemRW_ID_EX_SEG_out;
	 wire [2:0] ALUOp_ID_EX_SEG_out;
	 wire [31:0] readData1_ID_EX_SEG_out;
	 wire [31:0] readData2_ID_EX_SEG_out;
    wire [31:0] targPcOut_ID_ID_EX_SEG_out;
	 wire [31:0] immediate_32_ID_EX_SEG_out;
	 wire [4:0] rs_ID_EX_SEG_out;
	 wire [4:0] rt_ID_EX_SEG_out;
	 wire [4:0] targReg_ID_EX_SEG_out;
	 wire rs_src_ID_EX_SEG_out;
	 wire rt_src_ID_EX_SEG_out;
	 
	 //EX 
    wire [31:0] result;
	 wire [31:0] readData2_EX;
	 //EX_MEM_SEG 流出的线
	 wire [31:0] readData2_EX_MEM_SEG_out;
	 wire DataMemRW_EX_MEM_SEG_out;
	 wire ALUM2Reg_EX_MEM_SEG_out;
	 wire [31:0] result_EX_MEM_SEG_out;
	 wire [4:0] targReg_EX_MEM_SEG_out;
	 wire if_wr_reg_EX_MEM_SEG_out;
	 //MEM
	 wire [31:0] DataOut;
	 
	 //MEM_WB_SEG
	 wire [31:0] result_MEM_WB_SEG_out;
	 wire [31:0] DataOut_MEM_WB_SEG_out;
	 wire ALUM2Reg_MEM_WB_SEG_out;
	 wire [4:0] targReg_MEM_WB_SEG_out;
	 wire if_wr_reg_MEM_WB_SEG_out;
	 //WB
	 wire [31:0] write_data;
	 
	 // overall control
	 wire stall;
	 wire flush;
	 
	 assign stall = 1'b0;
	 assign flush = Rst;
	 always @(*) 
		resultbuf <= result;

// forwarding unit
/*
*/
FW_UNIT forward(
.clk(clk),
.rs_id_ex(rs_ID_EX_SEG_out),
.rt_id_ex(rt_ID_EX_SEG_out),
.rs_src_ID_EX(rs_src_ID_EX_SEG_out),
.rt_src_ID_EX(rt_src_ID_EX_SEG_out),
.reg2wr_ex_mem(targReg_EX_MEM_SEG_out),
.reg2wr_mem_wb(targReg_MEM_WB_SEG_out),
.wr_reg_ex_mem(if_wr_reg_EX_MEM_SEG_out),
.wr_reg_mem_wb(if_wr_reg_MEM_WB_SEG_out),
.forward_A(forward_A),
.forward_B(forward_B)
);

// IF --------------------------------------------------------------
IF ifStg(
.clk(clk),
.targPC(targPcOut_ID),
.PCwre(PCWre),
.stall(stall_PC_IFID | Rst),// to refactor
//output
.NPC(NPC),
.instruction(instruction)
);

IF_ID_SEG if_id_seg(
.Clk(clk),
.stall(stall_PC_IFID),
.flush(flush),
.PC_in(NPC),
.IR_in(instruction),
//output
.PC_out(pc_if_id_out),
.IR_out(ins_if_id_out)
); 



// ID --------------------------------------------------------------
/*
	 */
ID idStg(
.clk(clk),
.instruction(ins_if_id_out),
.pcIn_ID(pc_if_id_out),
.write_data(write_data),
.r2wr(targReg_MEM_WB_SEG_out),
	 // output
.PCWre(PCWre),
.if_wr_reg(if_wr_reg),
.isLW(isLW),
.ALUSrcB(ALUSrcB),
.ALUM2Reg(ALUM2Reg),
.DataMemRW(DataMemRW),
.ALUOp(ALUOp),
.readData1(readData1),
.readData2(readData2),
.targPcOut_ID(targPcOut_ID),
.immediate_32(immediate_32),
.rs(rs),
.rt(rt),
.rs_src(rs_src),
.rt_src(rt_src),
.targReg(targReg)
);
HazardDetector HD(
.next_isLW(isLW_ID_EX_SEG_out),
.lw_Wr_reg(targReg_ID_EX_SEG_out),
.id_rs_reg(rs),
.id_rt_reg(rt),
.rs_src(rs_src),
.rt_src(rt_src),
.stall_PC_IFID(stall_PC_IFID),
.flush_IDEX(flush_IDEX)
);


ID_EX_SEG id_ex_seg(
.Clk(clk),
.stall(stall),
.flush(flush_IDEX | flush),

.if_wr_reg(if_wr_reg),
.PCWre(PCWre),
.isLW(isLW),
.ALUSrcB(ALUSrcB),
.ALUM2Reg(ALUM2Reg),
.DataMemRW(DataMemRW),
.ALUOp(ALUOp),
.readData1(readData1),
.readData2(readData2),
.targPcOut_ID(targPcOut_ID),
.immediate_32(immediate_32),
.rs(rs),
.rt(rt),
.rs_src(rs_src),
.rt_src(rt_src),
.targReg(targReg),
//output
.PCWre_ID_EX_SEG_out(PCWre_ID_EX_SEG_out),
.if_wr_reg_ID_EX_SEG_out(if_wr_reg_ID_EX_SEG_out),
.isLW_ID_EX_SEG_out(isLW_ID_EX_SEG_out),
.ALUSrcB_ID_EX_SEG_out(ALUSrcB_ID_EX_SEG_out),
.ALUM2Reg_ID_EX_SEG_out(ALUM2Reg_ID_EX_SEG_out),
.DataMemRW_ID_EX_SEG_out(DataMemRW_ID_EX_SEG_out),
.ALUOp_ID_EX_SEG_out(ALUOp_ID_EX_SEG_out),
.readData1_ID_EX_SEG_out(readData1_ID_EX_SEG_out),
.readData2_ID_EX_SEG_out(readData2_ID_EX_SEG_out),
.targPcOut_ID_ID_EX_SEG_out(targPcOut_ID_ID_EX_SEG_out),
.immediate_32_ID_EX_SEG_out(immediate_32_ID_EX_SEG_out),
.rs_ID_EX_SEG_out(rs_ID_EX_SEG_out),
.rt_ID_EX_SEG_out(rt_ID_EX_SEG_out),
.rs_src_ID_EX_SEG_out(rs_src_ID_EX_SEG_out),
.rt_src_ID_EX_SEG_out(rt_src_ID_EX_SEG_out),
.targReg_ID_EX_SEG_out(targReg_ID_EX_SEG_out)
);


// EX --------------------------------------------------------------
/*
*/
EX exStg(
.readData1(readData1_ID_EX_SEG_out),
.readData2(readData2_ID_EX_SEG_out),
.immediate_32(immediate_32_ID_EX_SEG_out),
.choose_immediate_32(ALUSrcB_ID_EX_SEG_out),
.ALUOp(ALUOp_ID_EX_SEG_out),
.forward_A(forward_A),
.forward_B(forward_B),
.regV2wr_ex_mem(result_EX_MEM_SEG_out),
.regV2wr_wb(write_data),
//output
.result(result),
.readData2_EX(readData2_EX)
);

EX_MEM_SEG ex_mem_seg(
.Clk(clk),
.stall(stall),
.flush(flush),

.result(result),
.ALUM2Reg(ALUM2Reg_ID_EX_SEG_out),
.DataMemRW(DataMemRW_ID_EX_SEG_out),
.readData2(readData2_EX),
.r2wr(targReg_ID_EX_SEG_out),
.if_wr_reg(if_wr_reg_ID_EX_SEG_out),
//output
.result_EX_MEM_SEG_out(result_EX_MEM_SEG_out),
.ALUM2Reg_EX_MEM_SEG_out(ALUM2Reg_EX_MEM_SEG_out),
.DataMemRW_EX_MEM_SEG_out(DataMemRW_EX_MEM_SEG_out),
.readData2_EX_MEM_SEG_out(readData2_EX_MEM_SEG_out),
.r2wr_EX_MEM_SEG_out(targReg_EX_MEM_SEG_out),
.if_wr_reg_EX_MEM_SEG_out(if_wr_reg_EX_MEM_SEG_out)
);


// MEM --------------------------------------------------------------
/*
*/
MEM memStg(
.clk(clk),
.readData2(readData2_EX_MEM_SEG_out),
.result(result_EX_MEM_SEG_out),
.DataMemRW(DataMemRW_EX_MEM_SEG_out),
.DataOut(DataOut)
);
/*
*/
MEM_WB_SEG mem_wb_seg(
.Clk(clk),
.stall(stall),
.flush(flush),

.result(result_EX_MEM_SEG_out),
.ALUM2Reg(ALUM2Reg_EX_MEM_SEG_out),
.DataOut(DataOut),
.r2wr(targReg_EX_MEM_SEG_out),
.if_wr_reg(if_wr_reg_EX_MEM_SEG_out),
//output
.result_MEM_WB_SEG_out(result_MEM_WB_SEG_out),
.DataOut_MEM_WB_SEG_out(DataOut_MEM_WB_SEG_out),
.ALUM2Reg_MEM_WB_SEG_out(ALUM2Reg_MEM_WB_SEG_out),
.r2wr_MEM_WB_SEG_out(targReg_MEM_WB_SEG_out),
.if_wr_reg_MEM_WB_SEG_out(if_wr_reg_MEM_WB_SEG_out)
);


// WB --------------------------------------------------------------

assign write_data = (ALUM2Reg_MEM_WB_SEG_out == 0)? result_MEM_WB_SEG_out:DataOut_MEM_WB_SEG_out;


endmodule
