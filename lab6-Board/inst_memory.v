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
module inst_memory(clk,PC,inst,reset);
    input clk;
	 input reset;
    input [31:0] PC;
    output [31:0] inst;
	 
	 reg[31:0] instMemFile[13:0];
	 reg [31:0] inst;
    
	 always @ (instMemFile[PC/4] or reset)
	 begin
		if(reset==1)
		begin
			instMemFile[0]=32'b00000000000000000000000000000000;
			instMemFile[1]=32'b10001100000000010000000000000100;
			instMemFile[2]=32'b10001100000000100000000000001000;
			instMemFile[3]=32'b10001100000000110000000000001100;
			instMemFile[4]=32'b00000000000000000000000000000000;
			instMemFile[5]=32'b00000000001000110010000000100000;
			instMemFile[6]=32'b00000000100000100010100000100000;
			instMemFile[7]=32'b00000000101000110011000000100010;
			instMemFile[8]=32'b00010000011001100000000000000010;
			instMemFile[9]=32'b00000000010000110010000000100101;
			instMemFile[10]=32'b00000000010000110010000000100000;
			instMemFile[11]=32'b10101100000001010000000000000010;
			instMemFile[12]=32'b00000000010000100011100000100010;
			instMemFile[13]=32'b00010000111000001111111111110011;
			inst=32'h00000000;
		end
		else
			inst=instMemFile[PC/4];
	 end
	
endmodule
