`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  Laboratorio Sistemas Digitales TEC
// Engineer: Danny Mejías, Joao Salas, Javier Cordero
// 
// Create Date:    20:38:05 09/14/2016 
// Design Name: 	 Ruta de Datos
// Module Name:    Controlador_RTC 
// Project Name: 	 Control RTC
// Target Devices: Nexsys 4
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
module Controlador_RTC(
    input clock,reset,BTNP,BTNU,BTND,BTNR,BTNL,switchp,IRQ,ringoff,
	 output hsync,vsync,
	 output ADo,CSo,RDo,WRo,
	 inout [7:0] AdressDatao,
    output [2:0] rgb,
	 output [1:0] mstate,
	 output [3:0] istate, Lstate, ustate,
	 output [2:0] PFHstate, PTstate, rstate, wstate

    );
	 
reg AD,CS,RD,WR;
assign {ADo,CSo,RDo,WRo} = {AD,CS,RD,WR};	 
reg [7:0] AdressData;
assign AdressDatao = AdressData;
//wire PFH, PT, donew, doner, wrmuxseleco, win, rin;
wire [7:0] datai, address;
wire [1:0] mstate;
wire [3:0] istate, Lstate, ustate;
wire [2:0] PFHstate, PTstate, rstate, wstate;
reg TS;
reg selecAD;
reg [7:0] outAD,datamux,userdata;
wire [7:0] diaw, mesw, annow, rhoraw, rminw, rsegw, thoraw, tminw, tsegw;	 

FSM_RTC Master(clock, reset,PFH, PT, donew, doner, wrmuxselec, win, rin, datatype, datai, address, mstate, Lstate, PFHstate, PTstate);
ReadCycle Lectura(clock, reset, rin, readselec, doner, rstate, rAD, rCS, rRD, rWR, rTS, reg_enable) ;
WriteCycle Escritura(clock, reset, win, writeselec, donew, wstate, wAD, wCS, wRD, wWR, wTS) ;

ControlUsuario Usuario(clock, reset, BTNP, BTNR, BTNL, BTNU, BTND, switchp, ustate, diaw, mesw, annow, rhoraw, rminw, rsegw, thoraw, tminw, tsegw) ;


assign PFH = BTNP & ~switchp;
assign PT = BTNP & switchp;

always @(posedge clock)
	case (mstate)
		2'b00: {AD,CS,RD,WR,TS} = {wAD,wCS,wRD,wWR,wTS};
		2'b01: {AD,CS,RD,WR,TS} = {rAD,rCS,rRD,rWR,rTS};
		2'b10: {AD,CS,RD,WR,TS} = {wAD,wCS,wRD,wWR,wTS};
		2'b11: {AD,CS,RD,WR,TS} = {wAD,wCS,wRD,wWR,wTS};
		default: {AD,CS,RD,WR,TS} = {wAD,wCS,wRD,wWR,wTS};
	endcase	

//Multiplexor de Data de Usuario
always @(posedge clock)
	if (mstate == 2'b10)
		case (PFHstate)
		3'b000: userdata = 8'h00;
		3'b001: userdata = annow;
		3'b010: userdata = mesw;
		3'b011: userdata = diaw;
		3'b100: userdata = rhoraw;
		3'b101: userdata = rminw;
		3'b110: userdata = rsegw;
		3'b111: userdata = 8'h00;
		default : userdata = 8'h00;
		endcase
	else
		if (mstate == 2'b11)
			case (PTstate)
				3'b000: userdata = 8'h00;
				3'b001: userdata = thoraw;
				3'b010: userdata = tminw;
				3'b011: userdata = tsegw;
				3'b100: userdata = 8'h00;
				default : userdata = 8'h00;
			endcase
		else
			userdata = 8'h00;

//Multiplexor de tipo de Data
always @(posedge clock)
	case (datatype)
		1'b0: datamux = userdata;
		1'b1: datamux = datai;
		default : datamux = datai;
	endcase

//Multiplexor de seleccion A/D
always @(posedge clock)
	case (wrmuxselec)
		1'b0: selecAD = readselec;
		1'b1: selecAD = writeselec;
		default : selecAD = readselec;
	endcase

//Multiplexor A/D
always @(posedge clock)
	case (selecAD)
		1'b0: outAD = datamux;
		1'b1: outAD = address;
		default : outAD = address;
	endcase	
		
//Buffer de Tercer Estado
always @(posedge clock)
	if (TS)
		AdressData = 8'hzz;
	else
		AdressData = outAD;

//Registro de Datos Leídos
reg [7:0] anno_vga,
			 mes_vga,
			 dia_vga,
			 rhora_vga,
			 rmin_vga,
			 rseg_vga,
			 thora_vga,
			 tmin_vga,
			 tseg_vga;
always @(posedge clock)
	case (Lstate)
		4'b0000: {anno_vga,mes_vga,dia_vga,rhora_vga,rmin_vga,rseg_vga,thora_vga,tmin_vga,tseg_vga} = {anno_vga,mes_vga,dia_vga,rhora_vga,rmin_vga,rseg_vga,thora_vga,tmin_vga,tseg_vga};
		4'b0001: {anno_vga,mes_vga,dia_vga,rhora_vga,rmin_vga,rseg_vga,thora_vga,tmin_vga,tseg_vga} = {anno_vga,mes_vga,dia_vga,rhora_vga,rmin_vga,rseg_vga,thora_vga,tmin_vga,tseg_vga};
		4'b0010: if (reg_enable)
						anno_vga = AdressDatao;
					else
						anno_vga = anno_vga;
		4'b0011: if (reg_enable)
						mes_vga = AdressDatao;
					else
						mes_vga = mes_vga;
		4'b0100: if (reg_enable)
						dia_vga = AdressDatao;
					else
						dia_vga = dia_vga;
		4'b0101: if (reg_enable)
						rhora_vga = AdressDatao;
					else
						rhora_vga = rhora_vga;
		4'b0110: if (reg_enable)
						rmin_vga = AdressDatao;
					else
						rmin_vga = rmin_vga;
		4'b0111: if (reg_enable)
						rseg_vga = AdressDatao;
					else
						rseg_vga = rseg_vga;
		4'b1000: if (reg_enable)
						thora_vga = AdressDatao;
					else
						thora_vga = thora_vga;
		4'b1001: if (reg_enable)
						tmin_vga = AdressDatao;
					else
						tmin_vga = tmin_vga;
		4'b1010: if (reg_enable)
						tseg_vga = AdressDatao;
					else
						tseg_vga = tseg_vga;
		default: {anno_vga,mes_vga,dia_vga,rhora_vga,rmin_vga,rseg_vga,thora_vga,tmin_vga,tseg_vga} = {anno_vga,mes_vga,dia_vga,rhora_vga,rmin_vga,rseg_vga,thora_vga,tmin_vga,tseg_vga};
	endcase
	

//Multiplexor VGA
reg [7:0] anno,
			 mes,
			 dia,
			 rhora,
			 rmin,
			 rseg,
			 thora,
			 tmin,
			 tseg;
always @(posedge clock)
	if (wrmuxselec)
		{anno,mes,dia,rhora,rmin,rseg,thora,tmin,tseg} = {annow,mesw,diaw,rhoraw,rminw,rsegw,thoraw,tminw,tsegw};
	else
		{anno,mes,dia,rhora,rmin,rseg,thora,tmin,tseg} = {anno_vga,mes_vga,dia_vga,rhora_vga,rmin_vga,rseg_vga,thora_vga,tmin_vga,tseg_vga};





endmodule
