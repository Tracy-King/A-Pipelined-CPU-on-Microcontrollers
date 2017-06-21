`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:15:19 02/25/2016 
// Design Name: 
// Module Name:    lab2 
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
module lab2(
    mainClock,
	 reset,
	 count,
    );
	 input mainClock;
	 input reset;
	 output[3:0]count;
	 reg[3:0]count;
	 
	 always @(posedge mainClock)
	 begin
		if(!reset)
			count <= 4'b1111;
		else 
			count <= count-1;
	end

endmodule
