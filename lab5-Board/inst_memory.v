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
	 
	 reg[31:0] instMemFile[15:0];
	 reg [31:0] inst;
    
	 always @ (instMemFile[PC/4] or reset)
	 begin
		if(reset==1)
		begin
			instMemFile[0]=32'h00000000;
			instMemFile[1]=32'hAC03000F;
			instMemFile[2]=32'h08000006;
			instMemFile[3]=32'h00000000;
			instMemFile[4]=32'h00000000;
			instMemFile[5]=32'h00000000;
			instMemFile[6]=32'h8C010008;
			instMemFile[7]=32'h8C02000E;
			instMemFile[8]=32'h00411F2A;
			instMemFile[9]=32'h10030003;
			instMemFile[10]=32'h00000000;
			instMemFile[11]=32'h00000000;
			instMemFile[12]=32'h00000000;
			instMemFile[13]=32'h00221820;
			instMemFile[14]=32'h00412022;
			instMemFile[15]=32'h08000000;
			inst=32'h00000000;
		end
		else
			inst=instMemFile[PC/4];
	 end
	
endmodule
