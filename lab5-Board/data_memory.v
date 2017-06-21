`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:52:46 03/03/2016 
// Design Name: 
// Module Name:    data_memory 
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
module data_memory(clock_in,memWrite,memRead,address,
							readData,writeData,reset);
    input clock_in;
    input memWrite;
    input memRead;
    input [31:0] address;
    output [31:0] readData;
    input [31:0] writeData;
    
	 reg [31:0] memFile[15:0];
	 reg [31:0] readData;
	 input reset;
	 
	 integer i;
	 
	 always @(memFile[address])
	 begin
			if(memRead==1)
				readData=memFile[address];
	 end
	 
	 always @(negedge clock_in or posedge reset)
	 begin
		if(reset==1)
			for(i=0;i<16;i=i+1)
				memFile[i]=i;
		else if(memWrite==1)
					memFile[address]=writeData; 
	 end

endmodule
