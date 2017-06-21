`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:02:53 03/24/2016 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID(
	 input clk,
	 input reset,
    input [31:0] in_PCAdd4,
    input [31:0] int_inst,
    output reg [31:0] out_PCAdd4,
    output reg [31:0] out_inst
    );

	reg [31:0] IF_ID_PCAdd4;
	reg [31:0] IF_ID_inst;
	
	always @(posedge clk)
	begin
		out_PCAdd4 = IF_ID_PCAdd4;
		out_inst = IF_ID_inst;
	end
	
	always @(negedge clk or posedge reset)
	begin
		if(reset == 1)
		begin
			IF_ID_PCAdd4 = 0;
			IF_ID_inst = 0;
		end
		else
		begin
			IF_ID_PCAdd4 = in_PCAdd4;
			IF_ID_inst = int_inst;
		end
	end

endmodule
