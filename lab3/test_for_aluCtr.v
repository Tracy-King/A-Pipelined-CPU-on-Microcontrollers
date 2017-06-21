`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:41:35 02/25/2016
// Design Name:   ALUCtr
// Module Name:   E:/codjstu_design/lab3/test_for_aluCtr.v
// Project Name:  lab3
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALUCtr
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_aluCtr;

	// Inputs
	reg [1:0] aluOp;
	reg [5:0] funct;

	// Outputs
	wire [3:0] aluCtr;

	// Instantiate the Unit Under Test (UUT)
	ALUCtr uut (
		.aluOp(aluOp), 
		.funct(funct), 
		.aluCtr(aluCtr)
	);

	initial begin
		// Initialize Inputs
		aluOp = 0;
		funct = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		#100 aluOp = 2'b00;funct = 6'bxxxxxx;
		#100 aluOp = 2'b01;funct = 6'bxxxxxx;
		#100 aluOp = 2'b10;funct = 6'bxx0000;
		#100 aluOp = 2'b1x;funct = 6'bxx0010;
		#100 aluOp = 2'b1x;funct = 6'bxx0100;
		#100 aluOp = 2'b1x;funct = 6'bxx0101;
		#100 aluOp = 2'b1x;funct = 6'bxx1010;

        
		// Add stimulus here

	end
      
endmodule

