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
   input clock,reset,BTNCi,BTNUi,BTNDi,BTNRi,BTNLi,switchp,IRQ,ringoff,
	 output hsync,vsync,
	 output ADo,CSo,RDo,WRo,
	 inout  [7:0] AddressDatao,
   output [11:0] rgb,
	 output  [1:0] mstate,
	 output IRQo,
	 output [3:0]  ustate/*
	 output [2:0] PFHstate, PTstate, rstate, wstate,
	 output BTNP,
	 output BTNC,
	 output reg_enable,
	 output reg [7:0] rseg_vga, datamux, outAD, rseg,
	 output [7:0] address, rsegw, datai,
	 output wrmuxselec, datatype,
	 output reg BTNPa, TS, selecAD*/

    );
reg programando;


Debouncer Antirebote(clock,BTNCi,BTNUi,BTNDi,BTNRi,BTNLi,reset,BTNCd,BTNUd,BTNDd,BTNRd,BTNLd);


diezns BTNCa(clock,reset,BTNCd,BTNC);
diezns BTNUa(clock,reset,BTNUd,BTNU);
diezns BTNDa(clock,reset,BTNDd,BTND);
diezns BTNRa(clock,reset,BTNRd,BTNR);
diezns BTNLa(clock,reset,BTNLd,BTNL);

reg BTNPa;
always @(posedge clock, posedge reset)
	if (reset)
		BTNPa = 1'b0;
	else begin
		BTNPa = BTNPa;
		case (BTNPa)
			1'b0: if (BTNC)
						BTNPa = 1'b1;
					else
						BTNPa = 1'b0;
			1'b1: if ((( (mstate ==2'b10)||(mstate == 2'b11) )&&(ustate == 4'h0)&&(PFHstate == 4'h0)&&(PTstate == 4'h0)) || (Lstate==4'b01))
						BTNPa = 1'b0;
					else
						BTNPa = 1'b1;
			default: BTNPa = 1'b0;
		endcase
	end
wire BTNP;
assign BTNP = BTNPa;


reg AD,CS,RD,WR;
assign {ADo,CSo,RDo,WRo} = {AD,CS,RD,WR};
//reg [7:0] AddressData;
//assign AddressDatao = AddressData;
//wire PFH, PT, donew, doner, wrmuxseleco, win, rin;
wire [7:0] datai, address;
//wire [1:0] mstate;
wire [3:0] istate, Lstate, /*ustate,*/ dir;
wire [2:0] PFHstate, PTstate, rstate, wstate;

reg TS;
reg selecAD;
reg [7:0] outAD, datamux, userdata;
wire [7:0] diaw, mesw, annow, rhoraw, rminw, rsegw, thoraw, tminw, tsegw;
reg [7:0] diaw2, mesw2, annow2, rhoraw2, rminw2, rsegw2, thoraw2, tminw2, tsegw2;


FSM_RTC Master(clock, reset,PFH, PT, doner, donew, wrmuxselec, win, rin, datatype, datai, address, mstate, istate, Lstate, PFHstate, PTstate, BTNP,ustate,OK,Endpfh,Endpt,pixX,pixY);
ReadCycle Lectura(clock, reset, rin, readselec, doner, rstate, rAD, rCS, rRD, rWR, rTS, reg_enable) ;
WriteCycle Escritura(clock, reset, win, writeselec, donew, wstate, wAD, wCS, wRD, wWR, wTS) ;

ControlUsuario Usuario(clock, reset, BTNP, BTNR, BTNL, BTNU, BTND, switchp, mstate, ustate, dir, diaw, mesw, annow, rhoraw, rminw, rsegw, thoraw, tminw, tsegw) ;

always@(posedge clock, posedge reset)
begin
if (reset)
  {diaw2, mesw2, annow2, rhoraw2, rminw2, rsegw2, thoraw2, tminw2, tsegw2} = {8'b0,8'b0,8'b0,8'b0,8'b0,8'b0,8'b0,8'b0};
  else
    //{diaw2, mesw2, annow2, rhoraw2, rminw2, rsegw2, thoraw2, tminw2, tsegw2} = {diaw2, mesw2, annow2, rhoraw2, rminw2, rsegw2, thoraw2, tminw2, tsegw2} ;
    if ((pixX == 10'b0) && (pixY == 10'b0))
      {diaw2, mesw2, annow2, rhoraw2, rminw2, rsegw2, thoraw2, tminw2, tsegw2} = {diaw, mesw, annow, rhoraw, rminw, rsegw, thoraw, tminw, tsegw};
    else
      {diaw2, mesw2, annow2, rhoraw2, rminw2, rsegw2, thoraw2, tminw2, tsegw2} = {diaw2, mesw2, annow2, rhoraw2, rminw2, rsegw2, thoraw2, tminw2, tsegw2} ;
end


assign PFH = (BTNP && ~switchp);
assign PT = (BTNP && switchp);

always @*
begin
	case (mstate)
		2'b00: {AD,CS,RD,WR,TS} = {wAD,wCS,wRD,wWR,wTS};
		2'b01: {AD,CS,RD,WR,TS} = {rAD,rCS,rRD,rWR,rTS};
		2'b10: {AD,CS,RD,WR,TS} = {wAD,wCS,wRD,wWR,wTS};
		2'b11: {AD,CS,RD,WR,TS} = {wAD,wCS,wRD,wWR,wTS};
		default: {AD,CS,RD,WR,TS} = {wAD,wCS,wRD,wWR,wTS};
	endcase
end

always @*
begin
	case (mstate)
		2'b00: programando <= 1'b0;
		2'b01: programando <= 1'b0;
		2'b10: programando <= 1'b1;
		2'b11: programando <= 1'b1;
		default: programando<=1'b0;endcase
		end
//Multiplexor de Data de Usuario
always @*
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
	else begin
		if (mstate == 2'b11)
			case (PTstate)
				3'b000: userdata = 8'h00;
        3'b001: begin
							if ((tminw == 8'b0) & (tsegw == 8'b0))
								if (thoraw == 8'b0)
									userdata = thoraw;
								else
									if ((thoraw[3:0] == 4'h3)|(thoraw[3:0] == 4'h2)|(thoraw[3:0] == 4'h1)|(thoraw[3:0] == 4'h0))
										userdata = 8'h24 - thoraw;
									else
										userdata = 8'h1e - thoraw;
							else
								if ((thoraw[3:0] == 4'h3)|(thoraw[3:0] == 4'h2)|(thoraw[3:0] == 4'h1)|(thoraw[3:0] == 4'h0))
									userdata = 8'h23 - thoraw;
								else
									userdata = 8'h1d - thoraw;
							end
				3'b010: begin
							if (tsegw == 8'b0)
								if (tminw == 8'b0)
									userdata = tminw;
								else
									if (tminw[3:0] == 4'h0)
										userdata = 8'h60 - tminw;
									else
										userdata = 8'h5a - tminw;
							else
								userdata = 8'h59 - tminw;
							end
				3'b011: begin
                if (tsegw == 8'h0)
                  userdata = tsegw;
                else
								  if (tsegw[3:0] == 4'h0)
										userdata = 8'h60 - tsegw;
									else
										userdata = 8'h5a - tsegw;
						 end

        3'b100: userdata = 8'h00;
        3'b101: userdata = 8'h08;
        3'b110: userdata = 8'h04;
				default : userdata = 8'h00;
			endcase
		else
			userdata = 8'h00;
      end

//Multiplexor de tipo de Data
always @*
	case (datatype)
		1'b0: datamux = userdata;
		1'b1: datamux = datai;
		default : datamux = datai;
	endcase

//Multiplexor de seleccion A/D
always @*
	case (wrmuxselec)
		1'b0: selecAD = readselec;
		1'b1: selecAD = writeselec;
		default : selecAD = readselec;
	endcase

//Multiplexor A/D
always @*
	case (selecAD)
		1'b0: outAD = address;
		1'b1: outAD = datamux;
		default : outAD = datamux;//CAMBIOOOOOOOOOOOOOOOO
	endcase

//Buffer de Tercer Estado
/*always @*
	if (TS)
		AddressData = 8'hzz;
	else
		AddressData = outAD;*/
assign AddressDatao = TS ? 8'hzz : outAD;

//Registro de Datos Le�dos
reg [7:0] anno_vga,
			 mes_vga,
			 dia_vga,
			 rhora_vga,
			 rmin_vga,
			 rseg_vga,
			 thora_vga,
			 tmin_vga,
			 tseg_vga;
always @(posedge clock, posedge reset)
	if (reset)
		{anno_vga,mes_vga,dia_vga,rhora_vga,rmin_vga,rseg_vga,thora_vga,tmin_vga,tseg_vga} = {8'h0,8'h0,8'h0,8'h0,8'h0,8'h0,8'h0,8'h0,8'h0};
	else	begin
		{anno_vga,mes_vga,dia_vga,rhora_vga,rmin_vga,rseg_vga,thora_vga,tmin_vga,tseg_vga} = {anno_vga,mes_vga,dia_vga,rhora_vga,rmin_vga,rseg_vga,thora_vga,tmin_vga,tseg_vga};
		case (Lstate)
			4'b0000: {anno_vga,mes_vga,dia_vga,rhora_vga,rmin_vga,rseg_vga,thora_vga,tmin_vga,tseg_vga} = {anno_vga,mes_vga,dia_vga,rhora_vga,rmin_vga,rseg_vga,thora_vga,tmin_vga,tseg_vga};
			4'b0001: {anno_vga,mes_vga,dia_vga,rhora_vga,rmin_vga,rseg_vga,thora_vga,tmin_vga,tseg_vga} = {anno_vga,mes_vga,dia_vga,rhora_vga,rmin_vga,rseg_vga,thora_vga,tmin_vga,tseg_vga};
			4'b0010: if (reg_enable)
							anno_vga = AddressDatao;
						else
							anno_vga = anno_vga;
			4'b0011: if (reg_enable)
							mes_vga = AddressDatao;
						else
							mes_vga = mes_vga;
			4'b0100: if (reg_enable)
							dia_vga = AddressDatao;
						else
							dia_vga = dia_vga;
			4'b0101: if (reg_enable)
							rhora_vga = AddressDatao;
						else
							rhora_vga = rhora_vga;
			4'b0110: if (reg_enable)
							rmin_vga = AddressDatao;
						else
							rmin_vga = rmin_vga;
			4'b0111: if (reg_enable)
							rseg_vga = AddressDatao;
						else
							rseg_vga = rseg_vga;
			4'b1000: if (reg_enable)
							thora_vga = AddressDatao;
						else
							thora_vga = thora_vga;
			4'b1001: if (reg_enable)
							tmin_vga = AddressDatao;
						else
							tmin_vga = tmin_vga;
			4'b1010: if (reg_enable)
							tseg_vga =  AddressDatao;
						else
							tseg_vga = tseg_vga;
			default: {anno_vga,mes_vga,dia_vga,rhora_vga,rmin_vga,rseg_vga,thora_vga,tmin_vga,tseg_vga} = {anno_vga,mes_vga,dia_vga,rhora_vga,rmin_vga,rseg_vga,thora_vga,tmin_vga,tseg_vga};
		endcase
	end

  //Modulo de Resta en Registro de Data Leída
  //Declaracion de resgistros de salida

  reg [7:0] rthoravga,
  		   rtminvga,
  			rtsegvga;

  always @(posedge clock, posedge reset) begin
  if (reset)
    {rthoravga,rtminvga,rtsegvga} = {8'h00,8'h00,8'h00};
  else begin
  //Resta de hora
  	if ((tmin_vga == 8'b0) & (tseg_vga == 8'b0)) begin
  		if (thora_vga == 8'b0)
  			rthoravga = thora_vga;
  		else begin
  			if ((thora_vga[3:0] == 4'h3)|(thora_vga[3:0] == 4'h2)|(thora_vga[3:0] == 4'h1)|(thora_vga[3:0] == 4'h0))
  				rthoravga = 8'h24 - thora_vga;
  			else
  				rthoravga = 8'h1e - thora_vga;
      end
    end
  	else begin
  		if ((thora_vga[3:0] == 4'h3)|(thora_vga[3:0] == 4'h2)|(thora_vga[3:0] == 4'h1)|(thora_vga[3:0] == 4'h0))
  			rthoravga = 8'h23 - thora_vga;
  		else
  			rthoravga = 8'h1d - thora_vga;
    end

  //Resta de minutos
  	if (tseg_vga == 8'b0) begin
  		if (tmin_vga == 8'b0)
  			rtminvga = tmin_vga;
  		else begin
  			if (tmin_vga[3:0] == 4'h0)
  				rtminvga = 8'h60 - tmin_vga;
  			else
  				rtminvga = 8'h5a - tmin_vga;
      end
    end
  	else
  		rtminvga = 8'h59 - tmin_vga;


  //Resta de segundos
  	if (tseg_vga == 8'h0)
  		rtsegvga = tseg_vga;
  	else begin
  		if (tseg_vga[3:0] == 4'h0)
  			rtsegvga = 8'h60 - tseg_vga;
  		else
  			rtsegvga = 8'h5a - tseg_vga;
    end
    end
  end


wire [7:0] mtseg,mtmin,mthora;
assign mtseg = IRQ ? rtsegvga:8'h00;
assign mtmin = IRQ ? rtminvga:8'h00;
assign mthora = IRQ ? rthoravga:8'h00;



/*always @*
	if (TS)
		AddressData = 8'hzz;
	else
		AddressData = outAD;*/

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
always @*
	if (wrmuxselec)
		{anno,mes,dia,rhora,rmin,rseg,thora,tmin,tseg} = {annow2, mesw2, diaw2, rhoraw2, rminw2, rsegw2, thoraw2, tminw2, tsegw2} ;
	else
{anno,mes,dia,rhora,rmin,rseg,thora,tmin,tseg} = {anno_vga,mes_vga,dia_vga,rhora_vga,rmin_vga,rseg_vga,mthora,mtmin,mtseg};

reg FFalarma;
always @ (posedge clock, posedge reset)
	if (reset)
		FFalarma <= 1'b0;
	else begin
		FFalarma <= FFalarma;
		case (FFalarma)
			1'b0: if (Endpt)
						FFalarma <= 1'b1;
					else
						FFalarma <= 1'b0;
			1'b1: if ((~IRQ && ringoff)|((PTstate == 3'b000) && (mstate == 2'b11) ))
						FFalarma <= 1'b0;
					else
						FFalarma <= 1'b1;
			default: FFalarma <= 1'b1;
		endcase
	end

and(alarma,FFalarma,~IRQ);

assign IRQo = ~IRQ;

VGATOP Display(clock,reset,alarma,hsync,vsync,rgb,pixX,pixY,rhora,rmin,rseg,dia,mes,anno,thora,tmin,tseg,programando,dir);



endmodule
