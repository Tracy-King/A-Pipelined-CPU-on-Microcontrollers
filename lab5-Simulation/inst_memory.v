`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:44:23 03/10/2016 
// Design Name: 
// Module Name:    inst_memory 
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
module inst_memory(clk,PC,inst);
    input clk;
    input [31:0] PC;
    output [31:0] inst;
	 
	 reg[31:0] instMemFile[127:0];
	 reg [31:0] inst;
	 
	 initial
	 begin
		$readmemh("E:/codjstu_design/lab5/inst.txt",instMemFile);
	 end
    
	 always @ (posedge clk)
	 begin
		inst=instMemFile[PC/4];
	 end
	
endmodule
