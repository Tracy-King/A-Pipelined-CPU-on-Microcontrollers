`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:48:24 03/17/2016 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input clk,
    input reset,
    input [31:0] newPC,
    output reg [31:0] PC
    );
	 
	always @(posedge clk or posedge reset)
	 begin
		if(reset==1)
			PC=32'h00000000;
		else
			begin
				PC=newPC;
			end
	end

endmodule
