`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:46:40 03/03/2016 
// Design Name: 
// Module Name:    register 
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
module register(clock_in,readReg1,readReg2,writeReg,reset,
					writeData,regWrite,REG_NUM,REG_DATA,readData1,readData2);
    input clock_in;
    input [25:21] readReg1;
    input [20:16] readReg2;
    input [4:0] writeReg;
    input [31:0] writeData;
    input regWrite;
	 input reset;
	 input [3:0] REG_NUM;
	 output [31:0] REG_DATA;
    output [31:0] readData1;
    output [31:0] readData2;
	 
	 integer i;
	 
	 reg [31:0] regFile[7:0];
	 reg [31:0] readData1;
	 reg [31:0] readData2;
	 reg [31:0] REG_DATA;
	 
	 always @(regFile[REG_NUM])
	 begin
		REG_DATA=regFile[REG_NUM];
	 end
	 
	 always @ (regFile[readReg1] or regFile[readReg2])
	 begin
			readData1=regFile[readReg1];
			readData2=regFile[readReg2];
	 end
	 
	 always @ (negedge clock_in or posedge reset)
	 begin
		if(reset==1)
			for(i=0;i<8;i=i+1)regFile[i]=0;
		else if(regWrite==1)
			regFile[writeReg]=writeData;
	 end

endmodule

