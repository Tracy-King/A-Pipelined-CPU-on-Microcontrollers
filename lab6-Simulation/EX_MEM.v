`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:29:02 03/24/2016 
// Design Name: 
// Module Name:    EX_MEM 
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
module EX_MEM(
	 input clk,
	 input reset,
    input in_branch,
    input in_memRead,
    input in_memWrite,
    input in_regWrite,
    input in_memToReg,
    input [31:0] in_newPC,
    input [31:0] in_aluRes,
    input in_zero,
    input [31:0] in_readData2,
    input [4:0] in_reg,
	 
	 output reg out_branch,
	 output reg out_memRead,
	 output reg out_memWrite,
	 output reg out_regWrite,
	 output reg out_memToReg,
	 output reg [31:0] out_newPC,
	 output reg [31:0] out_aluRes,
	 output reg out_zero,
	 output reg [31:0] out_readData2,
    output reg [4:0] out_reg
    );
	 
	reg EX_MEM_branch;
	reg EX_MEM_memRead;
	reg EX_MEM_memWrite;
	reg EX_MEM_regWrite;
	reg EX_MEM_memToReg;
	
	reg [31:0] EX_MEM_newPC;
	reg EX_MEM_zero;
	reg [31:0] EX_MEM_aluRes;
	reg [31:0] EX_MEM_readData2;
	reg [4:0] EX_MEM_reg;
	
	always@(posedge clk)
	begin
		out_branch = EX_MEM_branch;
		out_memRead = EX_MEM_memRead;
		out_memWrite = EX_MEM_memWrite;
		out_regWrite = EX_MEM_regWrite;
		out_memToReg = EX_MEM_memToReg;
		out_newPC = EX_MEM_newPC;
		out_zero = EX_MEM_zero;
		out_aluRes = EX_MEM_aluRes;
		out_readData2 = EX_MEM_readData2;
		out_reg = EX_MEM_reg;
	end
	
	always @(negedge clk or posedge reset)
	begin
		if(reset == 1)
		begin
			EX_MEM_branch = 0;
			EX_MEM_memRead = 0;
			EX_MEM_memWrite = 0;
			EX_MEM_regWrite = 0;
			EX_MEM_memToReg = 0;
			EX_MEM_newPC = 0;
			EX_MEM_zero = 0;
			EX_MEM_aluRes = 0;
			EX_MEM_readData2 = 0;
			EX_MEM_reg = 0;
		end
		else
		begin
			EX_MEM_branch = in_branch;
			EX_MEM_memRead = in_memRead;
			EX_MEM_memWrite = in_memWrite;
			EX_MEM_regWrite = in_regWrite;
			EX_MEM_memToReg = in_memToReg;
			EX_MEM_newPC = in_newPC;
			EX_MEM_zero = in_zero;
			EX_MEM_aluRes = in_aluRes;
			EX_MEM_readData2 = in_readData2;
			EX_MEM_reg = in_reg;
		end
	end

endmodule
