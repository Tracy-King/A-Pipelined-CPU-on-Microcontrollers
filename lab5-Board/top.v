`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:54:41 03/10/2016 
// Design Name: 
// Module Name:    top 
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
module top(cl,RESET,led,blink,PC_SELECT,REG_SELECT,REG_NUM);
	 
	 input cl;
	 input RESET;
	 input PC_SELECT;
	 input REG_SELECT;
	 input [2:0] REG_NUM;
	 output reg [6:0] led;
	 output blink;
	 wire[31:0] INST;

	 wire REG_DST,
			JUMP,
			BRANCH,
			MEM_READ,
			MEM_TO_REG,
			MEM_WRITE;
	 wire[1:0] ALU_OP;
	 wire ALU_SRC,
			REG_WRITE;
			
	 wire [4:0] SRC_MUX;
    wire	[31:0] REG_MUX;
	 wire [3:0] ALU_CTR;
	 wire	[31:0] EXT_OUT;
	 wire	[31:0] BRANCH_MUX;
	 wire	[31:0] JUMP_MUX;
    wire	ZERO;
	 wire	[31:0] MEM_MUX;
	 wire [31:0] READ_DATA1;
	 wire [31:0] READ_DATA2;
	 wire [31:0] READ_DATA;
	 wire [31:0] ALU_RES;
	 
	 wire [31:0] REG_DATA;
	 
	 wire [31:0] PC;
	 wire [31:0] newPC;
	 reg pc_select = 0;
	 reg reg_select = 1;
	 reg [24:0]clk_cnt;
	 wire clk;


	assign REG_MUX = ALU_SRC?EXT_OUT:READ_DATA2;
	assign MEM_MUX = MEM_TO_REG?READ_DATA:ALU_RES;
	assign BRANCH_MUX = BRANCH&ZERO?(EXT_OUT<<2)+PC:PC;
	assign JUMP_MUX = JUMP?{PC[31:28],INST[25:0]<<2}:BRANCH_MUX;
	assign SRC_MUX = REG_DST?INST[15:11]:INST[20:16];
	assign newPC=JUMP?JUMP_MUX:JUMP_MUX+4;
	assign blink=clk;
	assign clk=clk_cnt[24];
	
	always @(posedge cl or posedge RESET)
	begin
		if(RESET == 1)
		begin
			clk_cnt = 0;
		end
		else
			clk_cnt = clk_cnt + 1;
	end
	
	always @(posedge PC_SELECT or posedge REG_SELECT)
	begin
		if(PC_SELECT==1)pc_select=~pc_select;
		else if(REG_SELECT==1)reg_select=~reg_select;
	end
	
	always @(pc_select or reg_select)
	begin
		if(pc_select==1)led=PC[6:0];
		else if(reg_select==1)led=REG_DATA[6:0];
	end
	 
	 PC mainPC(
				.clk(clk),
				.reset(RESET),
				.newPC(newPC),
				.PC(PC));
	 
	 inst_memory maininst_memory(
				.clk(clk),
				.PC(PC),
				.reset(RESET),
				.inst(INST));
	 
	 ctr mainctr(
				.opCode(INST[31:26]),
				.regDst(REG_DST),
				.jump(JUMP),
				.branch(BRANCH),
				.memRead(MEM_READ),
				.memToReg(MEM_TO_REG),
				.memWrite(MEM_WRITE),
				.aluOp(ALU_OP),
				.aluSrc(ALU_SRC),
				.regWrite(REG_WRITE));
	 
	 register mainregister(
				.clock_in(clk),
				.readReg1(INST[25:21]),
				.readReg2(INST[20:16]),
				.writeReg(SRC_MUX),
				.reset(RESET),
				.REG_DATA(REG_DATA),
				.REG_NUM(REG_NUM),
				.writeData(MEM_MUX),
				.readData1(READ_DATA1),
				.readData2(READ_DATA2),
				.regWrite(REG_WRITE));
				
	 ALUCtr mainALUCtr(
				.aluOp(ALU_OP),
				.funct(INST[5:0]),
				.aluCtr(ALU_CTR));
				
	 alu mainalu(
				.input1(READ_DATA1),
				.input2(REG_MUX),
				.aluCtr(ALU_CTR),
				.zero(ZERO),
				.aluRes(ALU_RES));
				
	 data_memory maindata_memory(
				.clock_in(clk),
				.memWrite(MEM_WRITE),
				.memRead(MEM_READ),
				.address(ALU_RES),
				.readData(READ_DATA),
				.reset(RESET),
				.writeData(READ_DATA2));
				
	 signext mainsignext(
			   .inst(INST[15:0]),
				.data(EXT_OUT));
				
	 
				
endmodule
