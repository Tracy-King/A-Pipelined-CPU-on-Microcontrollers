`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:58:05 03/27/2016 
// Design Name: 
// Module Name:    forward 
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
module forward(
    input clk,
    input reset,
    input EX_MEM_regWrite,
	 input MEM_WB_regWrite,
	 input [4:0] ID_EX_rs,
	 input [4:0] ID_EX_rt,
    input [4:0] EX_MEM_rd,
	 input [4:0] MEM_WB_rd,
    input [31:0] EX_MEM_regData,
	 input [31:0] MEM_WB_regData,
	 
	 output reg [31:0] forward,
	 output reg fwdRs,
	 output reg fwdRt
    );
	 
	 reg E_M_regWrite;
	 reg M_W_regWrite;
	 reg [31:0] E_M_regData;
	 reg [31:0] M_W_regData;
	 
	 always@(*)
	 begin
		if(reset == 1)
		begin
			E_M_regWrite = 0;
			M_W_regWrite = 0;
			E_M_regData = 0;
			M_W_regData = 0;
			fwdRs = 0;
			fwdRt = 0;
		end
		E_M_regWrite = EX_MEM_regWrite;
		M_W_regWrite = MEM_WB_regWrite;
		E_M_regData = EX_MEM_regData;
		M_W_regData = MEM_WB_regData;
		fwdRs = 0;
		fwdRt = 0;
		if((E_M_regWrite == 1)&&(EX_MEM_rd == ID_EX_rs))
		begin
			forward = E_M_regData;
			fwdRs = 1;
			fwdRt = 0;
		end
		else if((E_M_regWrite == 1)&&(EX_MEM_rd == ID_EX_rt))
		begin
			forward = E_M_regData;
			fwdRt = 1;
			fwdRs = 0;
		end
		else if((M_W_regWrite == 1)&&(MEM_WB_rd == ID_EX_rs))
		begin
			forward = M_W_regData;
			fwdRs = 1;
			fwdRt = 0;
		end
		else if((M_W_regWrite == 1)&&(MEM_WB_rd == ID_EX_rt))
		begin
			forward = M_W_regData;
			fwdRt = 1;
			fwdRs = 0;
		end
	end

endmodule
