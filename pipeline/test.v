`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:03:59 12/10/2018
// Design Name:   pipelineCPU
// Module Name:   C:/Users/ian/iansProjects/mipsPipeline/test.v
// Project Name:  mipsPipeline
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pipelineCPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg clk;
	reg Rst;

	// Outputs
	wire [31:0] resultbuf;

	// Instantiate the Unit Under Test (UUT)
	pipelineCPU uut (
		.clk(clk), 
		.Rst(Rst), 
		.resultbuf(resultbuf)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		Rst = 1;

		// Wait 100 ns for global reset to finish
		#110;
      Rst = 0;
		// Add stimulus here
	end
	always #50 
			clk = ~clk;
      
endmodule

