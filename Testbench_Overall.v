`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:48:39 09/15/2016 
// Design Name: 
// Module Name:    Testbench_Overall 
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
module Testbench_Overall;
	 reg clock_tb;
	 reg reset_tb;
	 reg BTNP_tb;
	 reg BTNU_tb;
	 reg BTND_tb;
	 reg BTNR_tb;
	 reg BTNL_tb;
	 reg switchp_tb;
	
	 wire ADo_tb;
	 wire CSo_tb;
	 wire RDo_tb;
	 wire WRo_tb;
	 wire [7:0] AdressDatao_tb;
	 wire [1:0] mstate_tb;
	 wire [3:0] istate_tb;
	 wire [3:0]	Lstate_tb; 
	 wire [3:0] ustate_tb;
	 wire [2:0] PFHstate_tb;
	 wire [2:0] PTstate_tb;
	 wire [2:0] rstate_tb;
	 wire [2:0] wstate_tb;

	Controlador_RTC dut(
	.clock (clock_tb),
	.reset (reset_tb),
	.BTNP (BTNP_tb),
	.BTNR (BTNR_tb),
	.BTNL (BTNL_tb),
	.BTNU (BTNU_tb),
	.BTND (BTND_tb),
	.switchp (switchp_tb),
	.ADo (ADo_tb),
	.CSo (CSo_tb),
	.RDo (RDo_tb),
	.WRo (WRo_tb),
	.AdressDatao (AdressDatao_tb),
	.mstate (mstate_tb),
	.istate (istate_tb),
	.Lstate (Lstate_tb), 
	.ustate (ustate_tb),
	.PFHstate (PFHstate_tb),
	.PTstate (PTstate_tb),
	.rstate (rstate_tb),
	.wstate (wstate_tb)
	);
	
	
initial
	begin
		clock_tb = 0;
	forever
		begin
		 #5 clock_tb = ~clock_tb; 
		end //Se establece el clock
	end
	
	initial
		begin
			BTNP_tb = 0;
			BTNR_tb = 0;
			BTNL_tb = 0;
			BTNU_tb = 0;
			BTND_tb = 0;
			switchp_tb = 0;
			reset_tb = 1;
			
			#10
			reset_tb = 0;
			/*#50
			BTNP_tb = 1;
			
			#10
			BTNP_tb = 0;
			
			#20
			BTNU_tb = 1;
			*/
			#4000
			$stop;
		end
	

endmodule
