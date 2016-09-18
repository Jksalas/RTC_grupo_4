`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:13:30 09/15/2016 
// Design Name: 
// Module Name:    CUADROS 
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
module CUADROS(
	input [9:0] pix_y, pix_x,
	 input wire video_on,
	 input clk,reset,
	 output reg [11:0] rgbtext

);
	 //*********************************************************
	 //SECCION GENERADORA DE CUADROS EN LA PANTALLA

	 localparam MAX_Y= 480;
	 localparam MAX_X= 640;
	wire [11:0] color_rgb; //output de salida
		//tamanos de lineas
//CAJAS GRANDES CREACION, LAS QUE ENCIERRAN,
//comienza la cajote de la hora
//vertical1

	localparam grande1v_left=169;
	localparam grande1v_right=173;
	localparam grande1v_y_t = 40;
	localparam grande1v_y_b = 150;
	wire  grande1v_on;
	assign grande1v_on = (grande1v_left<=pix_x) && (pix_x<=grande1v_right) &&
	(grande1v_y_t<=pix_y) && (pix_y<=grande1v_y_b);
//vertial2
	localparam grande2v_left=530;
	localparam grande2v_right=534;
	localparam grande2v_y_t = 40;
	localparam grande2v_y_b = 150;
	wire  grande2v_on;
	assign grande2v_on = (grande2v_left<=pix_x) && (pix_x<=grande2v_right) &&
	(grande2v_y_t<=pix_y) && (pix_y<=grande2v_y_b);
//horizontal1

	localparam grande1h_left=174;
	localparam grande1h_right=529;
	localparam grande1h_y_t = 40;
	localparam grande1h_y_b = 44;
	wire  grande1h_on;
	assign grande1h_on = (grande1h_left<=pix_x) && (pix_x<=grande1h_right) &&
	(grande1h_y_t<=pix_y) && (pix_y<=grande1h_y_b);
//horizontal2

	localparam grande2h_left=174;
	localparam grande2h_right=529;
	localparam grande2h_y_t = 146;
	localparam grande2h_y_b = 150;
	wire  grande2h_on;
	assign grande2h_on = (grande2h_left<=pix_x) && (pix_x<=grande2h_right) &&
	(grande2h_y_t<=pix_y) && (pix_y<=grande2h_y_b);

//----------------------------------------------------------------------------
//sigue la caja de la fecha

//vertical1

	localparam grandef1v_left=140;
	localparam grandef1v_right=144;
	localparam grandef1v_y_t = 175;
	localparam grandef1v_y_b = 275;
	wire  grandef1v_on;
	assign grandef1v_on = (grandef1v_left<=pix_x) && (pix_x<=grandef1v_right) &&
	(grandef1v_y_t<=pix_y) && (pix_y<=grandef1v_y_b);
//vertial2

	localparam grandef2v_left=564;
	localparam grandef2v_right=568;
	localparam grandef2v_y_t = 175;
	localparam grandef2v_y_b = 275;
	wire  grandef2v_on;
	assign grandef2v_on = (grandef2v_left<=pix_x) && (pix_x<=grandef2v_right) &&
	(grandef2v_y_t<=pix_y) && (pix_y<=grandef2v_y_b);
//horizontal1

	localparam grandef1h_left=145;
	localparam grandef1h_right=563;
	localparam grandef1h_y_t = 175;
	localparam grandef1h_y_b = 179;
	wire  grandef1h_on;
	assign grandef1h_on = (grandef1h_left<=pix_x) && (pix_x<=grandef1h_right) &&
	(grandef1h_y_t<=pix_y) && (pix_y<=grandef1h_y_b);
//horizontal2

	localparam grandef2h_left=145;
	localparam grandef2h_right=563;
	localparam grandef2h_y_t = 271;
	localparam grandef2h_y_b = 275;
	wire  grandef2h_on;
	assign grandef2h_on = (grandef2h_left<=pix_x) && (pix_x<=grandef2h_right) &&
	(grandef2h_y_t<=pix_y) && (pix_y<=grandef2h_y_b);
//---------------------------------------------------------------------

//sigue la caja del cronometro
//vertical1

	localparam grandec1v_left=169;
	localparam grandec1v_right=173;
	localparam grandec1v_y_t = 298;
	localparam grandec1v_y_b = 410;
	wire  grandec1v_on;
	assign grandec1v_on = (grandec1v_left<=pix_x) && (pix_x<=grandec1v_right) &&
	(grandec1v_y_t<=pix_y) && (pix_y<=grandec1v_y_b);
//vertial2

	localparam grandec2v_left=530;
	localparam grandec2v_right=534;
	localparam grandec2v_y_t = 298;
	localparam grandec2v_y_b = 410;
	wire  grandec2v_on;
	assign grandec2v_on = (grandec2v_left<=pix_x) && (pix_x<=grandec2v_right) &&
	(grandec2v_y_t<=pix_y) && (pix_y<=grandec2v_y_b);
//horizontal1

	localparam grandec1h_left=174;
	localparam grandec1h_right=529;
	localparam grandec1h_y_t = 298;
	localparam grandec1h_y_b = 302;
	wire  grandec1h_on;
	assign grandec1h_on = (grandec1h_left<=pix_x) && (pix_x<=grandec1h_right) &&
	(grandec1h_y_t<=pix_y) && (pix_y<=grandec1h_y_b);
//horizontal2

	localparam grandec2h_left=174;
	localparam grandec2h_right=529;
	localparam grandec2h_y_t = 406;
	localparam grandec2h_y_b = 410;
	wire  grandec2h_on;
	assign grandec2h_on = (grandec2h_left<=pix_x) && (pix_x<=grandec2h_right) &&
	(grandec2h_y_t<=pix_y) && (pix_y<=grandec2h_y_b);


//---------------------------------------------------------------------------
//**********************************************************************

//recuadros dentro de la caja del reloj

//cajas para las horas
//primer caja
//vertical1

	localparam media1v_left=179;
	localparam media1v_right=182;
	localparam media1v_y_t = 54;
	localparam media1v_y_b = 137;
	wire  media1v_on;
	assign media1v_on = (media1v_left<=pix_x) && (pix_x<=media1v_right) &&
	(media1v_y_t<=pix_y) && (pix_y<=media1v_y_b);
//vertial2

	localparam media2v_left=265;
	localparam media2v_right=268;
	localparam media2v_y_t = 54;
	localparam media2v_y_b = 137;
	wire  media2v_on;
	assign media2v_on = (media2v_left<=pix_x) && (pix_x<=media2v_right) &&
	(media2v_y_t<=pix_y) && (pix_y<=media2v_y_b);
//horizontal1
	localparam media1h_left=183;
	localparam media1h_right=264;
	localparam media1h_y_t = 54;
	localparam media1h_y_b = 57;
	wire  media1h_on;
	assign media1h_on = (media1h_left<=pix_x) && (pix_x<=media1h_right) &&
	(media1h_y_t<=pix_y) && (pix_y<=media1h_y_b);
//horizontal2
	localparam media2h_left=183;
	localparam media2h_right=264;
	localparam media2h_y_t = 134;
	localparam media2h_y_b = 137;
	wire  media2h_on;
	assign media2h_on = (media2h_left<=pix_x) && (pix_x<=media2h_right) &&
	(media2h_y_t<=pix_y) && (pix_y<=media2h_y_b);
//------------------------------------------
//segunda caja
//------------------------------------------

//vertical1

	localparam media1v2_left=307;
	localparam media1v2_right=310;
	localparam media1v2_y_t = 54; //listos
	localparam media1v2_y_b = 137;
	wire  media1v2_on;
	assign media1v2_on = (media1v2_left<=pix_x) && (pix_x<=media1v2_right) &&
	(media1v2_y_t<=pix_y) && (pix_y<=media1v2_y_b);
//vertial2

	localparam media2v2_left=393;
	localparam media2v2_right=396;
	localparam media2v2_y_t = 54;
	localparam media2v2_y_b = 137;
	wire  media2v2_on;
	assign media2v2_on = (media2v2_left<=pix_x) && (pix_x<=media2v2_right) &&
	(media2v2_y_t<=pix_y) && (pix_y<=media2v2_y_b);
//horizontal1
	localparam media1h2_left=307;
	localparam media1h2_right=392;
	localparam media1h2_y_t = 54;
	localparam media1h2_y_b = 57;
	wire  media1h2_on;
	assign media1h2_on = (media1h2_left<=pix_x) && (pix_x<=media1h2_right) &&
	(media1h2_y_t<=pix_y) && (pix_y<=media1h2_y_b);
//horizontal2
	localparam media2h2_left=307;
	localparam media2h2_right=392;
	localparam media2h2_y_t = 134; //ready
	localparam media2h2_y_b = 137;
	wire  media2h2_on;
	assign media2h2_on = (media2h2_left<=pix_x) && (pix_x<=media2h2_right) &&
	(media2h2_y_t<=pix_y) && (pix_y<=media2h2_y_b);

//tercera caja
//------------------------------------------

//vertical1

	localparam media1v3_left=435;
	localparam media1v3_right=438;
	localparam media1v3_y_t = 54; //ready
	localparam media1v3_y_b = 137;
	wire  media1v3_on;
	assign media1v3_on = (media1v3_left<=pix_x) && (pix_x<=media1v3_right) &&
	(media1v3_y_t<=pix_y) && (pix_y<=media1v3_y_b);
//vertial2

	localparam media2v3_left=521;
	localparam media2v3_right=523;
	localparam media2v3_y_t = 54;
	localparam media2v3_y_b = 137;
	wire  media2v3_on;
	assign media2v3_on = (media2v3_left<=pix_x) && (pix_x<=media2v3_right) &&
	(media2v3_y_t<=pix_y) && (pix_y<=media2v3_y_b);
//horizontal1
	localparam media1h3_left=436;
	localparam media1h3_right=520;
	localparam media1h3_y_t = 54;
	localparam media1h3_y_b = 57;
	wire  media1h3_on;
	assign media1h3_on = (media1h3_left<=pix_x) && (pix_x<=media1h3_right) &&
	(media1h3_y_t<=pix_y) && (pix_y<=media1h3_y_b);
//horizontal2
	localparam media2h3_left=436;
	localparam media2h3_right=520;
	localparam media2h3_y_t = 134; //ready
	localparam media2h3_y_b = 137;
	wire  media2h3_on;
	assign media2h3_on = (media2h3_left<=pix_x) && (pix_x<=media2h3_right) &&
	(media2h3_y_t<=pix_y) && (pix_y<=media2h3_y_b);
//------------------------------------------------------------------------------

//********************************************
//CREACION DE CAJAS QUE VAN DENTRO DE LA CAJA DE FECHA las que encierran a los numeros
//-----------------------
//primer caja
//vertical1

	localparam fecha1v_left=150;
	localparam fecha1v_right=153;
	localparam fecha1v_y_t = 182;
	localparam fecha1v_y_b = 265;
	wire  fecha1v_on;
	assign fecha1v_on = (fecha1v_left<=pix_x) && (pix_x<=fecha1v_right) &&
	(fecha1v_y_t<=pix_y) && (pix_y<=fecha1v_y_b);
//vertial2

	localparam fecha2v_left=232;
	localparam fecha2v_right=235;
	localparam fecha2v_y_t = 182; //listo
	localparam fecha2v_y_b = 265;
	wire  fecha2v_on;
	assign fecha2v_on = (fecha2v_left<=pix_x) && (pix_x<=fecha2v_right) &&
	(fecha2v_y_t<=pix_y) && (pix_y<=fecha2v_y_b);
//horizontal1
	localparam fecha1h_left=154;
	localparam fecha1h_right=231;
	localparam fecha1h_y_t = 182; //listo
	localparam fecha1h_y_b = 185;
	wire  fecha1h_on;
	assign fecha1h_on = (fecha1h_left<=pix_x) && (pix_x<=fecha1h_right) &&
	(fecha1h_y_t<=pix_y) && (pix_y<=fecha1h_y_b);
//horizontal2
	localparam fecha2h_left=154;
	localparam fecha2h_right=231;
	localparam fecha2h_y_t = 262; //ok
	localparam fecha2h_y_b = 265;
	wire  fecha2h_on;
	assign fecha2h_on = (fecha2h_left<=pix_x) && (pix_x<=fecha2h_right) &&
	(fecha2h_y_t<=pix_y) && (pix_y<=fecha2h_y_b);

//segunda caja en la fecha

//vertical1

	localparam fecha1v2_left=317;
	localparam fecha1v2_right=320;
	localparam fecha1v2_y_t = 182;  //listo
	localparam fecha1v2_y_b = 265;
	wire  fecha1v2_on;
	assign fecha1v2_on = (fecha1v2_left<=pix_x) && (pix_x<=fecha1v2_right) &&
	(fecha1v2_y_t<=pix_y) && (pix_y<=fecha1v2_y_b);
//vertial2

	localparam fecha2v2_left=389;
	localparam fecha2v2_right=392;
	localparam fecha2v2_y_t = 182;
	localparam fecha2v2_y_b = 265;
	wire  fecha2v2_on;
	assign fecha2v2_on = (fecha2v2_left<=pix_x) && (pix_x<=fecha2v2_right) &&
	(fecha2v2_y_t<=pix_y) && (pix_y<=fecha2v2_y_b);
//horizontal1
	localparam fecha1h2_left=321;
	localparam fecha1h2_right=388;
	localparam fecha1h2_y_t = 182;//ok
	localparam fecha1h2_y_b = 185;
	wire  fecha1h2_on;
	assign fecha1h2_on = (fecha1h2_left<=pix_x) && (pix_x<=fecha1h2_right) &&
	(fecha1h2_y_t<=pix_y) && (pix_y<=fecha1h2_y_b);
//horizontal2
	localparam fecha2h2_left=321;
	localparam fecha2h2_right=388;
	localparam fecha2h2_y_t = 262;//ok
	localparam fecha2h2_y_b = 265;
	wire  fecha2h2_on;
	assign fecha2h2_on = (fecha2h2_left<=pix_x) && (pix_x<=fecha2h2_right) &&
	(fecha2h2_y_t<=pix_y) && (pix_y<=fecha2h2_y_b);

//tercera caja dentro de fecha

//vertical1

	localparam fecha1v3_left=469;
	localparam fecha1v3_right=472;
	localparam fecha1v3_y_t = 182; //listo
	localparam fecha1v3_y_b = 265;
	wire  fecha1v3_on;
	assign fecha1v3_on = (fecha1v3_left<=pix_x) && (pix_x<=fecha1v3_right) &&
	(fecha1v3_y_t<=pix_y) && (pix_y<=fecha1v3_y_b);
//vertial2

	localparam fecha2v3_left=552;
	localparam fecha2v3_right=555;
	localparam fecha2v3_y_t = 182;
	localparam fecha2v3_y_b = 265;
	wire  fecha2v3_on;
	assign fecha2v3_on = (fecha2v3_left<=pix_x) && (pix_x<=fecha2v3_right) &&
	(fecha2v3_y_t<=pix_y) && (pix_y<=fecha2v3_y_b);
//horizontal1
	localparam fecha1h3_left=473;
	localparam fecha1h3_right=551;
	localparam fecha1h3_y_t = 182;//ok
	localparam fecha1h3_y_b = 185;
	wire  fecha1h3_on;
	assign fecha1h3_on = (fecha1h3_left<=pix_x) && (pix_x<=fecha1h3_right) &&
	(fecha1h3_y_t<=pix_y) && (pix_y<=fecha1h3_y_b);
//horizontal2
	localparam fecha2h3_left=473;
	localparam fecha2h3_right=551;
	localparam fecha2h3_y_t = 262;//ok
	localparam fecha2h3_y_b = 265;
	wire  fecha2h3_on;
	assign fecha2h3_on = (fecha2h3_left<=pix_x) && (pix_x<=fecha2h3_right) &&
	(fecha2h3_y_t<=pix_y) && (pix_y<=fecha2h3_y_b);

//---------------------------------------------------------------------------
//-----------------------------------------------------------------
//***************************************************
//---------------------------------------------------------------
//CAJAS QUE VAN DENTRO DEL CRONOMETRO


//vertical1

	localparam crono1v_left=179;
	localparam crono1v_right=182;
	localparam crono1v_y_t = 310;
	localparam crono1v_y_b = 393;
	wire  crono1v_on;
	assign crono1v_on = (crono1v_left<=pix_x) && (pix_x<=crono1v_right) &&
	(crono1v_y_t<=pix_y) && (pix_y<=crono1v_y_b);
//vertial2

	localparam crono2v_left=265;
	localparam crono2v_right=268;
	localparam crono2v_y_t = 310;
	localparam crono2v_y_b = 393;
	wire  crono2v_on;
	assign crono2v_on = (crono2v_left<=pix_x) && (pix_x<=crono2v_right) &&
	(crono2v_y_t<=pix_y) && (pix_y<=crono2v_y_b);
//horizontal1
	localparam crono1h_left=183;
	localparam crono1h_right=264;
	localparam crono1h_y_t = 310;
	localparam crono1h_y_b = 313;
	wire  crono1h_on;
	assign crono1h_on = (crono1h_left<=pix_x) && (pix_x<=crono1h_right) &&
	(crono1h_y_t<=pix_y) && (pix_y<=crono1h_y_b);
//horizontal2
	localparam crono2h_left=183;
	localparam crono2h_right=264;
	localparam crono2h_y_t = 390;
	localparam crono2h_y_b = 393;
	wire  crono2h_on;
	assign crono2h_on = (crono2h_left<=pix_x) && (pix_x<=crono2h_right) &&
	(crono2h_y_t<=pix_y) && (pix_y<=crono2h_y_b);

//segunda caja crono
//si algo comienza a dar problemas es porque aqui el pixel 307 coincide en la cajas, igual pasa en las cajas de la hora
//vertical1

	localparam crono1v2_left=307;
	localparam crono1v2_right=310;
	localparam crono1v2_y_t = 310;
	localparam crono1v2_y_b = 393;
	wire  crono1v2_on;
	assign crono1v2_on = (crono1v2_left<=pix_x) && (pix_x<=crono1v2_right) &&
	(crono1v2_y_t<=pix_y) && (pix_y<=crono1v2_y_b);
//vertial2

	localparam crono2v2_left=393;
	localparam crono2v2_right=396;
	localparam crono2v2_y_t = 310;
	localparam crono2v2_y_b = 393;
	wire  crono2v2_on;
	assign crono2v2_on = (crono2v2_left<=pix_x) && (pix_x<=crono2v2_right) &&
	(crono2v2_y_t<=pix_y) && (pix_y<=crono2v2_y_b);
//horizontal1
	localparam crono1h2_left=307;
	localparam crono1h2_right=392;
	localparam crono1h2_y_t = 310;
	localparam crono1h2_y_b = 313;
	wire  crono1h2_on;
	assign crono1h2_on = (crono1h2_left<=pix_x) && (pix_x<=crono1h2_right) &&
	(crono1h2_y_t<=pix_y) && (pix_y<=crono1h2_y_b);
//horizontal2
	localparam crono2h2_left=307;
	localparam crono2h2_right=392;
	localparam crono2h2_y_t = 390;
	localparam crono2h2_y_b = 393;
	wire  crono2h2_on;
	assign crono2h2_on = (crono2h2_left<=pix_x) && (pix_x<=crono2h2_right) &&
	(crono2h2_y_t<=pix_y) && (pix_y<=crono2h2_y_b);

//tercera caja crono

//vertical1

	localparam crono1v3_left=435;
	localparam crono1v3_right=438;
	localparam crono1v3_y_t = 310;
	localparam crono1v3_y_b = 393;
	wire  crono1v3_on;
	assign crono1v3_on = (crono1v3_left<=pix_x) && (pix_x<=crono1v3_right) &&
	(crono1v3_y_t<=pix_y) && (pix_y<=crono1v3_y_b);
//vertial2

	localparam crono2v3_left=521;
	localparam crono2v3_right=523;
	localparam crono2v3_y_t = 310;
	localparam crono2v3_y_b = 393;
	wire  crono2v3_on;
	assign crono2v3_on = (crono2v3_left<=pix_x) && (pix_x<=crono2v3_right) &&
	(crono2v3_y_t<=pix_y) && (pix_y<=crono2v3_y_b);
//horizontal1
	localparam crono1h3_left=436;//ok
	localparam crono1h3_right=520;
	localparam crono1h3_y_t = 310;
	localparam crono1h3_y_b = 313;
	wire  crono1h3_on;
	assign crono1h3_on = (crono1h3_left<=pix_x) && (pix_x<=crono1h3_right) &&
	(crono1h3_y_t<=pix_y) && (pix_y<=crono1h3_y_b);
//horizontal2
	localparam crono2h3_left=436;
	localparam crono2h3_right=520;
	localparam crono2h3_y_t = 390;
	localparam crono2h3_y_b = 393;
	wire  crono2h3_on;
	assign crono2h3_on = (crono2h3_left<=pix_x) && (pix_x<=crono2h3_right) &&
	(crono2h3_y_t<=pix_y) && (pix_y<=crono2h3_y_b);


//-----------------------------------------------------------------------
//CAJAS QUE ENCERRAN EL RTC
//*************************************************************************
//vertical1

	localparam B1v2_left=28;
	localparam B1v2_right=30;
	localparam B1v2_y_t = 30;
	localparam B1v2_y_b = 157;
	wire  B1v2_on;
	assign B1v2_on = (B1v2_left<=pix_x) && (pix_x<=B1v2_right) &&
	(B1v2_y_t<=pix_y) && (pix_y<=B1v2_y_b);
//vertial2

	localparam B2v2_left=548;
	localparam B2v2_right=550;
	localparam B2v2_y_t = 30;
	localparam B2v2_y_b = 157;
	wire  B2v2_on;
	assign B2v2_on = (B2v2_left<=pix_x) && (pix_x<=B2v2_right) &&
	(B2v2_y_t<=pix_y) && (pix_y<=B2v2_y_b);
//horizontal1
	localparam B1h2_left=31;
	localparam B1h2_right=547;
	localparam B1h2_y_t = 30;
	localparam B1h2_y_b = 32;
	wire  B1h2_on;
	assign B1h2_on = (B1h2_left<=pix_x) && (pix_x<=B1h2_right) &&
	(B1h2_y_t<=pix_y) && (pix_y<=B1h2_y_b);
//horizontal2
	localparam B2h2_left=31;
	localparam B2h2_right=547;
	localparam B2h2_y_t = 155;
	localparam B2h2_y_b = 157;
	wire  B2h2_on;
	assign B2h2_on = (B2h2_left<=pix_x) && (pix_x<=B2h2_right) &&
	(B2h2_y_t<=pix_y) && (pix_y<=B2h2_y_b);


//**********************************************************************
//SEGUNDO BORDE
//*************************************************************************
//vertical1
	localparam B1v2b_left=28;
	localparam B1v2b_right=30;
	localparam B1v2b_y_t = 165;
	localparam B1v2b_y_b = 285;
	wire  B1v2b_on;
	assign B1v2b_on = (B1v2b_left<=pix_x) && (pix_x<=B1v2b_right) &&
	(B1v2b_y_t<=pix_y) && (pix_y<=B1v2b_y_b);
//vertial2

	localparam B2v2b_left=578;
	localparam B2v2b_right=580;
	localparam B2v2b_y_t = 165;
	localparam B2v2b_y_b = 285;
	wire  B2v2b_on;
	assign B2v2b_on = (B2v2b_left<=pix_x) && (pix_x<=B2v2b_right) &&
	(B2v2b_y_t<=pix_y) && (pix_y<=B2v2b_y_b);
//horizontal1
	localparam B1h2b_left=31;
	localparam B1h2b_right=577;
	localparam B1h2b_y_t = 165;
	localparam B1h2b_y_b = 167;
	wire  B1h2b_on;
	assign B1h2b_on = (B1h2b_left<=pix_x) && (pix_x<=B1h2b_right) &&
	(B1h2b_y_t<=pix_y) && (pix_y<=B1h2b_y_b);
//horizontal2
	localparam B2h2b_left=31;
	localparam B2h2b_right=577;
	localparam B2h2b_y_t = 283;
	localparam B2h2b_y_b = 285;
	wire  B2h2b_on;
	assign B2h2b_on = (B2h2b_left<=pix_x) && (pix_x<=B2h2b_right) &&
	(B2h2b_y_t<=pix_y) && (pix_y<=B2h2b_y_b);

//*********************************************************
//tercer borde

//vertical1
	localparam B1v2c_left=28;
	localparam B1v2c_right=30;
	localparam B1v2c_y_t = 290;
	localparam B1v2c_y_b = 420;
	wire  B1v2c_on;
	assign B1v2c_on = (B1v2c_left<=pix_x) && (pix_x<=B1v2c_right) &&
	(B1v2c_y_t<=pix_y) && (pix_y<=B1v2c_y_b);
//vertial2

	localparam B2v2c_left=545;
	localparam B2v2c_right=547;
	localparam B2v2c_y_t = 290;
	localparam B2v2c_y_b = 420;
	wire  B2v2c_on;
	assign B2v2c_on = (B2v2c_left<=pix_x) && (pix_x<=B2v2c_right) &&
	(B2v2c_y_t<=pix_y) && (pix_y<=B2v2c_y_b);
//horizontal1
	localparam B1h2c_left=31;
	localparam B1h2c_right=544;
	localparam B1h2c_y_t = 290;
	localparam B1h2c_y_b = 292;
	wire  B1h2c_on;
	assign B1h2c_on = (B1h2c_left<=pix_x) && (pix_x<=B1h2c_right) &&
	(B1h2c_y_t<=pix_y) && (pix_y<=B1h2c_y_b);
//horizontal2
	localparam B2h2c_left=31;
	localparam B2h2c_right=544;
	localparam B2h2c_y_t = 418;
	localparam B2h2c_y_b = 420;
	wire  B2h2c_on;
	assign B2h2c_on = (B2h2c_left<=pix_x) && (pix_x<=B2h2c_right) &&
	(B2h2c_y_t<=pix_y) && (pix_y<=B2h2c_y_b);
//**********************************************************************
//------------------------------------------------------------------



always@*
	if(~video_on)
		rgbtext=0;
	else begin
		if (grandec2h_on | grandec1h_on | grandec1v_on |grandec2v_on | grandef2h_on | grandef1h_on | grandef2v_on | grandef1v_on | grande2h_on | grande1h_on | grande2v_on | grande1v_on)
			rgbtext=12'h0f0;
		else if (media1v_on | media2v_on | media1h_on | media2h_on |media1v2_on | media2v2_on|media1h2_on |media2h2_on |media1v3_on | media2v3_on|media1h3_on |media2h3_on)
			rgbtext=12'h0f0;
		else if(fecha1v_on | fecha2v_on | fecha1h_on | fecha2h_on |fecha1v2_on | fecha2v2_on | fecha1h2_on | fecha2h2_on |fecha1v3_on | fecha2v3_on | fecha1h3_on | fecha2h3_on)
			rgbtext=12'h0f0;
		else if(crono1v_on | crono2v_on | crono1h_on | crono2h_on |crono1v2_on | crono2v2_on | crono1h2_on | crono2h2_on |crono1v3_on | crono2v3_on | crono1h3_on | crono2h3_on)
			rgbtext=12'h0f0;
			else if(B2h2_on | B1h2_on |B1v2_on | B2v2_on|B2h2b_on | B1h2b_on |B1v2b_on | B2v2b_on|B2h2c_on | B1h2c_on |B1v2c_on | B2v2c_on)
				rgbtext=12'h0f0;
		else
		rgbtext=0;


	end


endmodule
