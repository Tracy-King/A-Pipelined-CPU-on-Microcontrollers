`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:15:34 03/27/2016 
// Design Name: 
// Module Name:    hazard 
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
module hazard(
    input clk,
    input reset,
    input ID_EX_memRead,
    input [4:0] ID_EX_rt,
	 input [31:0] IF_ID_inst,
    output reg stall
    );
	 
	 reg [5:0] instType;
	 reg [4:0] reg1;
	 reg [4:0] reg2;
	 reg [4:0] lwreg;
	 
	 always @(posedge clk or posedge reset)
	 begin
		if(reset == 1)
		begin
			instType = 0;
			reg1 = 0;
			reg2 = 0;
			lwreg = 0;
			IF_ID_stall = 0;
		end
		instType = IF_ID_inst[31:26];
		reg1 = IF_ID_inst[25:21];
		reg2 = IF_ID_inst[20:16];
		lwreg = ID_EX_rt;
	end
	
	always @(*)
	begin
		if((ID_EX_memRead == 1)&&(instType == 6b'000000)&&((reg1 == lwreg)||(reg2 == lwreg)))
			IF_ID_stall = 1;
	end


endmodule
