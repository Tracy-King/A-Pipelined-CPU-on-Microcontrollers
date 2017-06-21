`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:36:22 03/24/2016 
// Design Name: 
// Module Name:    MEM_WB 
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
module MEM_WB(
	 input clk,
	 input reset,
    input in_regWrite,
    input in_memToReg,
    input [31:0] in_readData,
    input [31:0] in_aluRes,
    input [4:0] in_reg,
	 
	 output reg out_regWrite,
	 output reg out_memToReg,
	 output reg [31:0] out_readData,
	 output reg [31:0] out_aluRes,
	 output reg [4:0] out_reg
    );
	 
	reg MEM_WB_regWrite;
	reg MEM_WB_memToReg;
	reg [31:0] MEM_WB_readData;
	reg [31:0] MEM_WB_aluRes;
	reg [4:0] MEM_WB_reg;
	
	always @(posedge clk)
	begin
		out_regWrite = MEM_WB_regWrite;
		out_memToReg = MEM_WB_memToReg;
		out_readData = MEM_WB_readData;
		out_aluRes = MEM_WB_aluRes;
		out_reg = MEM_WB_reg;
	end
	
	always @(negedge clk or posedge reset)
	begin
		if(reset == 1)
		begin
			MEM_WB_regWrite = 0;
			MEM_WB_memToReg = 0;
			MEM_WB_readData = 0;
			MEM_WB_aluRes = 0;
			MEM_WB_reg = 0;
		end
		else
		begin
			MEM_WB_regWrite = in_regWrite;
			MEM_WB_memToReg = in_memToReg;
			MEM_WB_readData = in_readData;
			MEM_WB_aluRes = in_aluRes;
			MEM_WB_reg = in_reg;
		end
	end

endmodule
