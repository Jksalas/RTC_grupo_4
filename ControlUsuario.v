`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:43:00 09/14/2016 
// Design Name: 
// Module Name:    ControlUsuario 
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
module ControlUsuario (clk, reset, BTNP, BTNR, BTNL, BTNU, BTND, CTRL_Switch, state, diaw, mesw, annow, rhoraw, rminw, rsegw, thoraw, tminw, tsegw) ;
	input clk, reset, BTNP, BTNR, BTNL, BTNU, BTND, CTRL_Switch; //Declarion de  entradas y salidas
	output[3:0] state; //salida de prueba
	output [7:0] diaw, mesw, annow, rhoraw, rminw, rsegw, thoraw, tminw, tsegw; //registros de salida
	reg [3:0] next_state, state ; // variables de estado
	reg [7:0] diaw, mesw, annow, rhoraw, rminw, rsegw, thoraw, tminw, tsegw;
	
parameter [3:0] P0 = 4'b0000; //Hold State
parameter [3:0] RoT = 4'b0001; //Decision Timer o Reloj
parameter [3:0] Rrst = 4'b0010; //Reset reloj
parameter [3:0] Rdia = 4'b0011; //Programar día reloj
parameter [3:0] Rmes = 4'b0100; //Programar mes reloj
parameter [3:0] Ranno = 4'b0101; //Programar año reloj
parameter [3:0] Rhora = 4'b0110; //Programar hora reloj
parameter [3:0] Rmin = 4'b0111; //Programar minutos reloj
parameter [3:0] Rseg = 4'b1000; //Programar segundos reloj
parameter [3:0] Trst = 4'b1001; //Reseteo timer
parameter [3:0] Thora = 4'b1010; //Programar hora crono
parameter [3:0] Tmin = 4'b1011; //Programar minutos crono
parameter [3:0] Tseg = 4'b1100; //Programar segundos crono
parameter [3:0] A = 4'b1101;

	always @(posedge clk) begin //Lógica de siguiente estado
		case(state)
			P0: next_state = BTNP ? RoT:P0; 
			RoT: next_state = CTRL_Switch ? Trst: Rrst;
			Rrst: next_state = Rdia;					
			Rdia: if (BTNP)
						next_state = P0;
					else if (BTNR)
						next_state = Rmes;
					else if (BTNL)
						next_state = Rseg;
					else
						next_state = Rdia;			
			Rmes: if (BTNP)
						next_state = P0;
					else if (BTNR)
						next_state = Ranno;
					else if (BTNL)
						next_state = Rdia;
					else
						next_state = Rmes;
			Ranno: if (BTNP)
						next_state = P0;
					else if (BTNR)
						next_state = Rhora;
					else if (BTNL)
						next_state = Rmes;
					else
						next_state = Ranno;
			Rhora: if (BTNP)
						next_state = P0;
					else if (BTNR)
						next_state = Rmin;
					else if (BTNL)
						next_state = Ranno;
					else
						next_state = Rhora;
			Rmin: if (BTNP)
						next_state = P0;
					else if (BTNR)
						next_state = Rseg;
					else if (BTNL)
						next_state = Rhora;
					else
						next_state = Rmin;
			Rseg: if (BTNP)
						next_state = P0;
					else if (BTNR)
						next_state = Rdia;
					else if (BTNL)
						next_state = Rmin;
					else
						next_state = Rseg;
			Trst: next_state = Thora;
			Thora: if (BTNP)
						next_state = P0;
					else if (BTNR)
						next_state = Tmin;
					else if (BTNL)
						next_state = Tseg;
					else
						next_state = Thora;
			Tmin: if (BTNP)
						next_state = P0;
					else if (BTNR)
						next_state = Tseg;
					else if (BTNL)
						next_state = Thora;
					else
						next_state = Tmin;
			Tseg: if (BTNP)
						next_state = P0;
					else if (BTNR)
						next_state = Thora;
					else if (BTNL)
						next_state = Tmin;
					else
						next_state = Tseg;
			default: next_state = P0;
		endcase
	end
	
	//Control de Usuarios por botones
	always @(posedge clk) begin
		case(state)
		   P0:{diaw, mesw, annow, rhoraw, rminw, rsegw, thoraw, tminw, tsegw} = {diaw, mesw, annow, rhoraw, rminw, rsegw, thoraw, tminw, tsegw} ;
			Rrst: {diaw, mesw, annow, rhoraw, rminw, rsegw} = {8'h1, 8'h1, 8'b0, 8'b0, 8'b0, 8'b0 } ;
			Rdia: if (BTNU)
						if (diaw == 8'h31)
							diaw = 8'h1;
						else if (diaw[3:0] == 4'h9)
							diaw = diaw + 8'h7;
						else 
							diaw = diaw + 8'h1;
					else if (BTND)
						if (diaw == 8'h0)
							diaw = 8'h31;
						else if (diaw[3:0] == 4'h0)
							diaw = diaw - 8'h7;
						else
							diaw = diaw - 8'h1;
			Rmes: if (BTNU)
						if (mesw == 8'h12)
							mesw = 8'h1;
						else if (mesw[3:0] == 4'h9)
							mesw = mesw + 8'h7;
						else 
							mesw = mesw + 8'h1;
					else if (BTND)
						if (mesw == 8'h1)
							mesw = 8'h12;
						else if (mesw[3:0] == 4'h0)
							mesw = mesw - 8'h7;
						else
							mesw = mesw - 8'h1;
			Ranno: if (BTNU)
						if (annow == 8'h99)
							annow = 8'h0;
						else if (annow[3:0] == 4'h9)
							annow = annow + 8'h7;
						else 
							annow = annow + 8'h1;
					else if (BTND)
						if (annow == 8'h0)
							annow = 8'h99;
						else if (annow[3:0] == 4'h0)
							annow = annow - 8'h7;
						else
							annow = annow - 8'h1;
			Rhora: if (BTNU)
						if (rhoraw == 8'h23)
							rhoraw = 8'h0;
						else if (rhoraw[3:0] == 4'h9)
							rhoraw = rhoraw + 8'h7;
						else 
							rhoraw = rhoraw + 8'h1;
					else if (BTND)
						if (rhoraw == 8'h0)
							rhoraw = 8'h23;
						else if (rhoraw[3:0] == 4'h0)
							rhoraw = rhoraw - 8'h7;
						else
							rhoraw = rhoraw - 8'h1;
			Rmin: if (BTNU)
						if (rminw == 8'h59)
							rminw = 8'h0;
						else if (rminw[3:0] == 4'h9)
							rminw = rminw + 8'h7;
						else 
							rminw = rminw + 8'h1;
					else if (BTND)
						if (rminw == 8'h0)
							rminw = 8'h59;
						else if (rminw[3:0] == 4'h0)
							rminw = rminw - 8'h7;
						else
							rminw = rminw - 8'h1;
			Rseg: if (BTNU)
						if (rsegw == 8'h59)
							rsegw= 8'h0;
						else if (rsegw[3:0] == 4'h9)
							rsegw = rsegw + 8'h7;
						else 
							rsegw = rsegw + 8'h1;
					else if (BTND)
						if (rsegw == 8'h0)
							rsegw = 8'h59;
						else if (rsegw[3:0] == 4'h0)
							rsegw = rsegw - 8'h7;
						else
							rsegw = rsegw - 8'h1;
			Trst: {thoraw, tminw, tsegw} = {8'b0, 8'b0, 8'b0 } ;
			Thora: if (BTNU)
						if (thoraw == 8'h23)
							rhoraw = 8'h0;
						else if (thoraw[3:0] == 4'h9)
							thoraw = thoraw + 8'h7;
						else 
							thoraw = thoraw + 8'h1;
					else if (BTND)
						if (thoraw == 8'h0)
							thoraw = 8'h23;
						else if (thoraw[3:0] == 4'h0)
							thoraw = thoraw - 8'h7;
						else
							thoraw = thoraw - 8'h1;
			Tmin: if (BTNU)
						if (tminw == 8'h59)
							tminw = 8'h0;
						else if (tminw[3:0] == 4'h9)
							tminw = tminw + 8'h7;
						else 
							tminw = tminw + 8'h1;
					else if (BTND)
						if (tminw == 8'h0)
							tminw = 8'h59;
						else if (tminw[3:0] == 4'h0)
							tminw = tminw - 8'h7;
						else
							tminw = tminw - 8'h1;
			Tseg: if (BTNU)
						if (tsegw == 8'h59)
							tsegw= 8'h0;
						else if (tsegw[3:0] == 4'h9)
							tsegw = tsegw + 8'h7;
						else 
							tsegw = tsegw + 8'h1;
					else if (BTND)
						if (tsegw == 8'h0)
							tsegw = 8'h59;
						else if (tsegw[3:0] == 4'h0)
							tsegw = tsegw - 8'h7;
						else
							tsegw = tsegw - 8'h1;
			A: {diaw, mesw, annow, rhoraw, rminw, rsegw, thoraw, tminw, tsegw} = {8'hff, 8'hff, 8'hff, 8'hff, 8'hff, 8'hff, 8'hff, 8'hff, 8'hff } ;
			default: {diaw, mesw, annow, rhoraw, rminw, rsegw, thoraw, tminw, tsegw} = {8'h1, 8'h1, 8'h0, 8'h0, 8'h0, 8'h0, 8'h0, 8'h0, 8'h0 } ; //Evita warning de Latch
		endcase
	end 
	
	always @(posedge clk) 
		begin
			if (reset)
				state <= P0;
			else
				state <= next_state;
		end
	
endmodule
