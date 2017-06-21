`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:09:39 03/24/2016 
// Design Name: 
// Module Name:    ID_EX 
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
module ID_EX(
	 input clk,
	 input reset,
    input [31:0] in_PCAdd4,
    input [31:0] in_readData1,
    input [31:0] in_readData2,
    input [31:0] in_signext,
    input [4:0] in_reg1,
    input [4:0] in_reg2,
	 input [4:0] in_rs,
	 input [4:0] in_rt,
    input in_regDst,
    input [1:0] in_aluOp,
    input in_aluSrc,
    input in_branch,
    input in_memRead,
    input in_memWrite,
    input in_regWrite,
    input in_memToReg,
	 
	 output reg out_regDst,
	 output reg [1:0] out_aluOp,
	 output reg out_aluSrc,
	 output reg out_branch,
	 output reg out_memRead,
	 output reg out_memWrite,
	 output reg out_regWrite,
	 output reg out_memToReg,
	 output reg [31:0] out_PCAdd4,
	 output reg [31:0] out_readData1,
	 output reg [31:0] out_readData2,
	 output reg [31:0] out_signext,
	 output reg [4:0] out_reg1,
	 output reg [4:0] out_reg2,
	 output reg [4:0] out_rs,
	 output reg [4:0] out_rt
    );
	 
	reg ID_EX_regDst;
	reg [1:0] ID_EX_aluOp;
	reg ID_EX_aluSrc;
	reg ID_EX_branch;
	reg ID_EX_memRead;
	reg ID_EX_memWrite;
	reg ID_EX_regWrite;
	reg ID_EX_memToReg;
	reg [31:0] ID_EX_PCAdd4;
	reg [31:0] ID_EX_readData1;
	reg [31:0] ID_EX_readData2;
	reg [31:0] ID_EX_signext;
	reg [4:0] ID_EX_reg1;
	reg [4:0] ID_EX_reg2;
	reg [4:0] ID_EX_rs;
	reg [4:0] ID_EX_rt;
	
	always @(posedge clk)
	begin
		out_regDst = ID_EX_regDst;
		out_aluOp = ID_EX_aluOp;
		out_aluSrc = ID_EX_aluSrc;
		out_branch = ID_EX_branch;
		out_memRead = ID_EX_memRead;
		out_memWrite = ID_EX_memWrite;
		out_regWrite = ID_EX_regWrite;
		out_memToReg = ID_EX_memToReg;
		out_PCAdd4 = ID_EX_PCAdd4;
		out_readData1 = ID_EX_readData1;
		out_readData2 = ID_EX_readData2;
		out_signext = ID_EX_signext;
		out_reg1 = ID_EX_reg1;
		out_reg2 = ID_EX_reg2;
		out_rs = ID_EX_rs;
		out_rt =	ID_EX_rt;
	end
	
	always @(negedge clk or posedge reset)
	begin
		if(reset == 1)
		begin
			ID_EX_regDst = 0;
			ID_EX_aluOp = 0;
			ID_EX_aluSrc = 0;
			ID_EX_branch = 0;
			ID_EX_memRead = 0;
			ID_EX_memWrite = 0;
			ID_EX_regWrite = 0;
			ID_EX_memToReg = 0;
			ID_EX_PCAdd4 = 0;
			ID_EX_readData1 = 0;
			ID_EX_readData2 = 0;
			ID_EX_signext = 0;
			ID_EX_reg1 = 0;
			ID_EX_reg2 = 0;
			ID_EX_rs = 0;
			ID_EX_rt = 0;
		end
		else
		begin
			ID_EX_regDst = in_regDst;
			ID_EX_aluOp = in_aluOp;
			ID_EX_aluSrc = in_aluSrc;
			ID_EX_branch = in_branch;
			ID_EX_memRead = in_memRead;
			ID_EX_memWrite = in_memWrite;
			ID_EX_regWrite = in_regWrite;
			ID_EX_memToReg = in_memToReg;
			ID_EX_PCAdd4 = in_PCAdd4;
			ID_EX_readData1 = in_readData1;
			ID_EX_readData2 = in_readData2;
			ID_EX_signext = in_signext;
			ID_EX_reg1 = in_reg1;
			ID_EX_reg2 = in_reg2;
			ID_EX_rs = in_rs;
			ID_EX_rt = in_rt;
		end
	end

endmodule
