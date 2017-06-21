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
module top(clk,RESET);
	 
	 input clk;
	 input RESET;
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
	 
	 reg [31:0] PC = 32'h00000000;
	 reg [31:0] newPC = 32'h00000004;


	assign REG_MUX = ALU_SRC?EXT_OUT:READ_DATA2;
	assign MEM_MUX = MEM_TO_REG?READ_DATA:ALU_RES;
	assign BRANCH_MUX = BRANCH&ZERO?(EXT_OUT<<2)+newPC:newPC;
	assign JUMP_MUX = JUMP?{newPC[31:28],INST[25:0]<<2}:BRANCH_MUX;
	assign SRC_MUX = REG_DST?INST[15:11]:INST[20:16];
	
	always @(posedge clk)
	 begin
		if(RESET==1)PC=32'h00000004;
		else
			begin
				PC=JUMP_MUX+4;
				newPC=PC;
			end
	end
	
	always @(negedge clk)
	begin
		if(RESET==0)PC=JUMP_MUX;
	end
	 
	 inst_memory maininst_memory(
				.clk(clk),
				.PC(PC),
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
