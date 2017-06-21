`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:58:06 03/24/2016 
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
module top(
    input cl,
    input RESET,
	 input PC_SELECT,
	 input REG_SELECT,
	 input [3:0]REG_NUM,
	 output blink,
	 output reg [6:0] led
    );
	 

//WIREs

	//PC
	wire [31:0] PC;
	
	//Forward
	wire [31:0] forward;
	wire fwdRs;
	wire fwdRt;
	
	//IF_ID
	wire [31:0] IN_IF_ID_PCAdd4;
	wire [31:0] IN_IF_ID_inst;
	wire [31:0] OUT_IF_ID_PCAdd4;
	wire [31:0] OUT_IF_ID_inst;
	
	//ID_EX
	wire IN_ID_EX_regDst;
	wire [1:0] IN_ID_EX_aluOp;
	wire IN_ID_EX_aluSrc;
	wire IN_ID_EX_branch;
	wire IN_ID_EX_memRead;
	wire IN_ID_EX_memWrite;
	wire IN_ID_EX_regWrite;
	wire IN_ID_EX_memToReg;
	
	wire [31:0] IN_ID_EX_PCAdd4;
	wire [31:0] IN_ID_EX_readData1;
	wire [31:0] IN_ID_EX_readData2;
	wire [31:0] IN_ID_EX_signExt;
	wire [4:0] IN_ID_EX_reg1;
	wire [4:0] IN_ID_EX_reg2;
	wire [4:0] IN_ID_EX_rs;
	wire [4:0] IN_ID_EX_rt;
	
	wire OUT_ID_EX_regDst;
	wire [1:0] OUT_ID_EX_aluOp;
	wire OUT_ID_EX_aluSrc;
	wire OUT_ID_EX_branch;
	wire OUT_ID_EX_memRead;
	wire OUT_ID_EX_memWrite;
	wire OUT_ID_EX_regWrite;
	wire OUT_ID_EX_memToReg;
	
	wire [31:0] OUT_ID_EX_PCAdd4;
	wire [31:0] OUT_ID_EX_readData1;
	wire [31:0] OUT_ID_EX_readData2;
	wire [31:0] OUT_ID_EX_signExt;
	wire [4:0] OUT_ID_EX_reg1;
	wire [4:0] OUT_ID_EX_reg2;
	wire [4:0] OUT_ID_EX_rs;
	wire [4:0] OUT_ID_EX_rt;
	
	//EX_MEM
	wire IN_EX_MEM_branch;
	wire IN_EX_MEM_memRead;
	wire IN_EX_MEM_memWrite;
	wire IN_EX_MEM_regWrite;
	wire IN_EX_MEM_memToReg;
	
	wire [31:0] IN_EX_MEM_newPC;
	wire IN_EX_MEM_zero;
	wire [31:0] IN_EX_MEM_aluRes;
	wire [31:0] IN_EX_MEM_readData2;
	wire [4:0] IN_EX_MEM_reg;
	
	wire OUT_EX_MEM_branch;
	wire OUT_EX_MEM_memRead;
	wire OUT_EX_MEM_memWrite;
	wire OUT_EX_MEM_regWrite;
	wire OUT_EX_MEM_memToReg;
	
	wire [31:0] OUT_EX_MEM_newPC;
	wire OUT_EX_MEM_zero;
	wire [31:0] OUT_EX_MEM_aluRes;
	wire [31:0] OUT_EX_MEM_readData2;
	wire [4:0] OUT_EX_MEM_reg;
	
	//MEM_WB
	wire IN_MEM_WB_regWrite;
	wire IN_MEM_WB_memToReg;
	wire [31:0] IN_MEM_WB_readData;
	wire [31:0] IN_MEM_WB_aluRes;
	wire [4:0] IN_MEM_WB_reg;
	
	wire OUT_MEM_WB_regWrite;
	wire OUT_MEM_WB_memToReg;
	wire [31:0] OUT_MEM_WB_readData;
	wire [31:0] OUT_MEM_WB_aluRes;
	wire [4:0] OUT_MEM_WB_reg;
	
	//Others
	wire [31:0] REG_DATA;
	wire [3:0] ALUCTR;
	wire [31:0] MUX_PCSRC;
	wire [31:0] MUX_ALUSRC;
	wire [31:0] MUX_REGWRITE;
	wire [5:0] MUX_REGDST;
	wire [31:0] MUX_FWDRS;
	wire [31:0] MUX_FWDRT;
	wire [31:0] PCAdd4;

	//time_divider
	
	 reg [24:0] clk_cnt;
	 wire clk;
	 
	 always @(posedge cl or posedge RESET)
	 begin
		if(RESET == 1)clk_cnt = 0;
		else
			clk_cnt = clk_cnt + 1;
	 end
	 
	 assign clk = clk_cnt[24];
	 assign blink = clk;
	 
	 // FPGA
	 
	 reg pc_select = 0;
	 reg reg_select = 1;
	 
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

	//Mux
	assign MUX_PCSRC = (OUT_EX_MEM_zero&OUT_EX_MEM_branch)?OUT_EX_MEM_newPC:PCAdd4;
	assign MUX_FWDRS = fwdRs?forward:OUT_ID_EX_readData1;
	assign MUX_FWDRT = fwdRt?forward:OUT_ID_EX_readData2;
	assign MUX_ALUSRC = OUT_ID_EX_aluSrc?OUT_ID_EX_signExt:MUX_FWDRT;
	assign MUX_REGWRITE = OUT_MEM_WB_memToReg?OUT_MEM_WB_readData:OUT_MEM_WB_aluRes;
	assign MUX_REGDST = OUT_ID_EX_regDst?OUT_ID_EX_reg2:OUT_ID_EX_reg1;

	
	//Assign
		//IF
	assign PCAdd4 = PC + 4;
	assign IN_IF_ID_PCAdd4 = PCAdd4;
		//ID
	assign IN_ID_EX_PCAdd4 = OUT_IF_ID_PCAdd4;
	assign IN_ID_EX_reg1 = OUT_IF_ID_inst[20:16];
	assign IN_ID_EX_reg2 = OUT_IF_ID_inst[15:11];
	assign IN_ID_EX_rs = OUT_IF_ID_inst[25:21];
	assign IN_ID_EX_rt = OUT_IF_ID_inst[20:16];
		//EX
	assign IN_EX_MEM_newPC = OUT_ID_EX_PCAdd4 + (OUT_ID_EX_signExt<<2);
	assign IN_EX_MEM_branch = OUT_ID_EX_branch;
	assign IN_EX_MEM_memRead = OUT_ID_EX_memRead;
	assign IN_EX_MEM_memWrite = OUT_ID_EX_memWrite;
	assign IN_EX_MEM_regWrite = OUT_ID_EX_regWrite;
	assign IN_EX_MEM_memToReg = OUT_ID_EX_memToReg;
	assign IN_EX_MEM_readData2 = MUX_FWDRT;
	assign IN_EX_MEM_reg = MUX_REGDST;
		//MEM
	assign IN_MEM_WB_regWrite = OUT_EX_MEM_regWrite;
	assign IN_MEM_WB_memToReg = OUT_EX_MEM_memToReg;
	assign IN_MEM_WB_aluRes = OUT_EX_MEM_aluRes;
	assign IN_MEM_WB_reg = OUT_EX_MEM_reg;
	
	forward mainforward(
	 		.clk(clk),
    		.reset(RESET|(OUT_EX_MEM_zero&OUT_EX_MEM_branch)),
    		.EX_MEM_regWrite(OUT_EX_MEM_regWrite),
	 		.MEM_WB_regWrite(OUT_MEM_WB_regWrite),
	 		.ID_EX_rs(OUT_ID_EX_rs),
	 		.ID_EX_rt(OUT_ID_EX_rt),
    		.EX_MEM_rd(OUT_EX_MEM_reg),
	 		.MEM_WB_rd(OUT_MEM_WB_reg),
    		.EX_MEM_regData(OUT_EX_MEM_aluRes),
	 		.MEM_WB_regData(OUT_MEM_WB_aluRes),
	 		.forward(forward),
	 		.fwdRs(fwdRs),
	 		.fwdRt(fwdRt));
	
	EX_MEM mainEX_MEM(
			.clk(clk),
			.reset(RESET),
			.in_branch(IN_EX_MEM_branch),
    		.in_memRead(IN_EX_MEM_memRead),
    		.in_memWrite(IN_EX_MEM_memWrite),
    		.in_regWrite(IN_EX_MEM_regWrite),
    		.in_memToReg(IN_EX_MEM_memToReg),
    		.in_newPC(IN_EX_MEM_newPC),
    		.in_aluRes(IN_EX_MEM_aluRes),
    		.in_zero(IN_EX_MEM_zero),
    		.in_readData2(MUX_FWDRT),
    		.in_reg(IN_EX_MEM_reg),
	 
	 		.out_branch(OUT_EX_MEM_branch),
	 		.out_memRead(OUT_EX_MEM_memRead),
	 		.out_memWrite(OUT_EX_MEM_memWrite),
	 		.out_regWrite(OUT_EX_MEM_regWrite),
			.out_memToReg(OUT_EX_MEM_memToReg),
	 		.out_newPC(OUT_EX_MEM_newPC),
	 		.out_aluRes(OUT_EX_MEM_aluRes),
	 		.out_zero(OUT_EX_MEM_zero),
	 		.out_readData2(OUT_EX_MEM_readData2),
    		.out_reg(OUT_EX_MEM_reg));
			
	ID_EX mainID_EX(
			.clk(clk),
			.reset(RESET|(OUT_EX_MEM_zero&OUT_EX_MEM_branch)),
    		.in_PCAdd4(IN_ID_EX_PCAdd4),
    		.in_readData1(IN_ID_EX_readData1),
    		.in_readData2(IN_ID_EX_readData2),
    		.in_signext(IN_ID_EX_signExt),
    		.in_reg1(IN_ID_EX_reg1),
    		.in_reg2(IN_ID_EX_reg2),
			.in_rs(IN_ID_EX_rs),
			.in_rt(IN_ID_EX_rt),
    		.in_regDst(IN_ID_EX_regDst),
    		.in_aluOp(IN_ID_EX_aluOp),
    		.in_aluSrc(IN_ID_EX_aluSrc),
    		.in_branch(IN_ID_EX_branch),
    		.in_memRead(IN_ID_EX_memRead),
    		.in_memWrite(IN_ID_EX_memWrite),
    		.in_regWrite(IN_ID_EX_regWrite),
    		.in_memToReg(IN_ID_EX_memToReg),
	 
	 		.out_regDst(OUT_ID_EX_regDst),
	 		.out_aluOp(OUT_ID_EX_aluOp),
			.out_aluSrc(OUT_ID_EX_aluSrc),
	 		.out_branch(OUT_ID_EX_branch),
	 		.out_memRead(OUT_ID_EX_memRead),
	 		.out_memWrite(OUT_ID_EX_memWrite),
	 		.out_regWrite(OUT_ID_EX_regWrite),
	 		.out_memToReg(OUT_ID_EX_memToReg),
	 		.out_PCAdd4(OUT_ID_EX_PCAdd4),
	 		.out_readData1(OUT_ID_EX_readData1),
	 		.out_readData2(OUT_ID_EX_readData2),
	 		.out_signext(OUT_ID_EX_signExt),
	 		.out_reg1(OUT_ID_EX_reg1),
	 		.out_reg2(OUT_ID_EX_reg2),
			.out_rs(OUT_ID_EX_rs),
			.out_rt(OUT_ID_EX_rt));
			
	IF_ID mainIF_ID(
	 		.clk(clk),
	  		.reset(RESET|(OUT_EX_MEM_zero&OUT_EX_MEM_branch)),
     		.in_PCAdd4(IN_IF_ID_PCAdd4),
     		.int_inst(IN_IF_ID_inst),
     		.out_PCAdd4(OUT_IF_ID_PCAdd4),
     		.out_inst(OUT_IF_ID_inst));
			
	MEM_WB mainMEM_WB(
	  		.clk(clk),
			.reset(RESET),
    		.in_regWrite(IN_MEM_WB_regWrite),
    		.in_memToReg(IN_MEM_WB_memToReg),
    		.in_readData(IN_MEM_WB_readData),
    		.in_aluRes(IN_MEM_WB_aluRes),
    		.in_reg(IN_MEM_WB_reg), 
			.out_regWrite(OUT_MEM_WB_regWrite),
	 		.out_memToReg(OUT_MEM_WB_memToReg),
	 		.out_readData(OUT_MEM_WB_readData),
	 		.out_aluRes(OUT_MEM_WB_aluRes),
	 		.out_reg(OUT_MEM_WB_reg));
	
	ALUCtr mainALUCtr(
			.aluOp(OUT_ID_EX_aluOp),
			.funct(OUT_ID_EX_signExt[5:0]),
			.aluCtr(ALUCTR));
			
	PC mainPC(
			.clk(clk),
			.reset(RESET),
			.newPC(MUX_PCSRC),
			.PC(PC));
			
	alu mainalu(
			.input1(MUX_FWDRS),
			.input2(MUX_ALUSRC),
			.aluCtr(ALUCTR),
			.zero(IN_EX_MEM_zero),
			.aluRes(IN_EX_MEM_aluRes));
			
	ctr mainctr(
			.opCode(OUT_IF_ID_inst[31:26]),
			.regDst(IN_ID_EX_regDst),
			.aluSrc(IN_ID_EX_aluSrc),
			.memToReg(IN_ID_EX_memToReg),
			.regWrite(IN_ID_EX_regWrite),
			.memRead(IN_ID_EX_memRead),
			.memWrite(IN_ID_EX_memWrite),
			.branch(IN_ID_EX_branch),
			.aluOp(IN_ID_EX_aluOp));
			
	data_memory maindata_memory(
			.clock_in(clk),
			.memWrite(OUT_EX_MEM_memWrite),
			.memRead(OUT_EX_MEM_memRead),
			.address(OUT_EX_MEM_aluRes),
			.readData(IN_MEM_WB_readData),
			.writeData(OUT_EX_MEM_readData2),
			.reset(RESET));
			
	inst_memory maininst_memory(
			.clk(clk),
			.PC(PC),
			.inst(IN_IF_ID_inst),
			.reset(RESET));
			
	register mainregister(
			.clock_in(clk),
			.readReg1(OUT_IF_ID_inst[25:21]),
			.readReg2(OUT_IF_ID_inst[20:16]),
			.writeReg(OUT_MEM_WB_reg),
			.reset(RESET),
			.writeData(MUX_REGWRITE),
			.regWrite(OUT_MEM_WB_regWrite),
			.REG_NUM(REG_NUM),
			.REG_DATA(REG_DATA),
			.readData1(IN_ID_EX_readData1),
			.readData2(IN_ID_EX_readData2));
			
	signext mainsignext(
			.inst(OUT_IF_ID_inst[15:0]),
			.data(IN_ID_EX_signExt));
	
endmodule
