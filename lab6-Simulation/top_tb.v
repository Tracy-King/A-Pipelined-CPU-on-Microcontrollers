`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:07:37 03/31/2016
// Design Name:   top
// Module Name:   E:/codjstu_design/lab6/top_tb.v
// Project Name:  lab6
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

module top_tb;

	// Inputs
	reg clk;
	reg RESET;
	reg PC_SELECT;
	reg REG_SELECT;
	reg [3:0] REG_NUM;

	// Outputs
	wire blink;
	wire [6:0] led;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clk(clk), 
		.RESET(RESET), 
		.PC_SELECT(PC_SELECT), 
		.REG_SELECT(REG_SELECT), 
		.REG_NUM(REG_NUM), 
		.blink(blink), 
		.led(led)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		RESET = 1;
		PC_SELECT = 0;
		REG_SELECT = 0;
		REG_NUM = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		#130;
		RESET = 0;
        
		// Add stimulus here

	end
		always
		#100 clk = ~clk;
	  
endmodule

