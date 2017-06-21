`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:57:55 03/03/2016
// Design Name:   data_memory
// Module Name:   E:/codjstu_design/genesys/lab4/test_for_memory.v
// Project Name:  lab4
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: data_memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_for_memory;

	// Inputs
	reg clock_in;
	reg memWrite;
	reg memRead;
	reg [31:0] address;
	reg [31:0] writeData;

	// Outputs
	wire [31:0] readData;

	// Instantiate the Unit Under Test (UUT)
	data_memory uut (
		.clock_in(clock_in), 
		.memWrite(memWrite), 
		.memRead(memRead), 
		.address(address), 
		.readData(readData), 
		.writeData(writeData)
	);

	initial begin
		// Initialize Inputs
		clock_in = 0;
		memWrite = 0;
		memRead = 0;
		address = 0;
		writeData = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		#185;
		memWrite=1'b1;
		address=32'h0000000F;
		memRead=1'b0;
		writeData=32'h00000003;
		
		
        
		// Add stimulus here

	end
	
	always #100 clock_in=~clock_in;
      
endmodule

