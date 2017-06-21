`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:30:31 03/10/2016
// Design Name:   top
// Module Name:   E:/codjstu_design/lab5/Top_tb.v
// Project Name:  lab5
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Top_tb;

	// Inputs
	reg clk;
	reg RESET;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.RESET(RESET)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		RESET = 1;
		 

		// Wait 100 ns for global reset to finish
		#130;
		RESET = 0;
        
		// Add stimulus here

	end
	always
	#100 clk=!clk;
      
endmodule

