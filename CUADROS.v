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
	 output reg [2:0] rgbtext

);
	 //*********************************************************
	 //SECCION GENERADORA DE CUADROS EN LA PANTALLA
	 
	 localparam MAX_Y= 480;
	 localparam MAX_X= 640;
	wire [2:0] color_rgb; //output de salida
		//tamanos de lineas
//CAJAS GRANDES CREACION, LAS QUE ENCIERRAN, 
//comienza la cajote de la hora
//vertical1
	
	localparam grande1v_left=150;
	localparam grande1v_right=155;
	localparam grande1v_y_t = 40; 
	localparam grande1v_y_b = 210;
	wire  grande1v_on;
	assign grande1v_on = (grande1v_left<=pix_x) && (pix_x<=grande1v_right) &&
	(grande1v_y_t<=pix_y) && (pix_y<=grande1v_y_b);	
//vertial2
	localparam grande2v_left=580;
	localparam grande2v_right=585;
	localparam grande2v_y_t = 40; 
	localparam grande2v_y_b = 210;
	wire  grande2v_on;
	assign grande2v_on = (grande2v_left<=pix_x) && (pix_x<=grande2v_right) &&
	(grande2v_y_t<=pix_y) && (pix_y<=grande2v_y_b);
//horizontal1
	
	localparam grande1h_left=150;
	localparam grande1h_right=585;
	localparam grande1h_y_t = 40; 
	localparam grande1h_y_b = 45;
	wire  grande1h_on;
	assign grande1h_on = (grande1h_left<=pix_x) && (pix_x<=grande1h_right) &&
	(grande1h_y_t<=pix_y) && (pix_y<=grande1h_y_b);
//horizontal2
	
	localparam grande2h_left=150;
	localparam grande2h_right=585;
	localparam grande2h_y_t = 205; 
	localparam grande2h_y_b = 210;
	wire  grande2h_on;
	assign grande2h_on = (grande2h_left<=pix_x) && (pix_x<=grande2h_right) &&
	(grande2h_y_t<=pix_y) && (pix_y<=grande2h_y_b);	

//----------------------------------------------------------------------------
//sigue la caja de la fecha 

//vertical1
	
	localparam grandef1v_left=320;
	localparam grandef1v_right=325;
	localparam grandef1v_y_t = 230; 
	localparam grandef1v_y_b = 320;
	wire  grandef1v_on;
	assign grandef1v_on = (grandef1v_left<=pix_x) && (pix_x<=grandef1v_right) &&
	(grandef1v_y_t<=pix_y) && (pix_y<=grandef1v_y_b);	
//vertial2
	
	localparam grandef2v_left=550;
	localparam grandef2v_right=555;
	localparam grandef2v_y_t = 230; 
	localparam grandef2v_y_b = 320;
	wire  grandef2v_on;
	assign grandef2v_on = (grandef2v_left<=pix_x) && (pix_x<=grandef2v_right) &&
	(grandef2v_y_t<=pix_y) && (pix_y<=grandef2v_y_b);
//horizontal1
	
	localparam grandef1h_left=320;
	localparam grandef1h_right=555;
	localparam grandef1h_y_t = 225; 
	localparam grandef1h_y_b = 230;
	wire  grandef1h_on;
	assign grandef1h_on = (grandef1h_left<=pix_x) && (pix_x<=grandef1h_right) &&
	(grandef1h_y_t<=pix_y) && (pix_y<=grandef1h_y_b);
//horizontal2
	
	localparam grandef2h_left=320;
	localparam grandef2h_right=555;
	localparam grandef2h_y_t = 320; 
	localparam grandef2h_y_b = 325;
	wire  grandef2h_on;
	assign grandef2h_on = (grandef2h_left<=pix_x) && (pix_x<=grandef2h_right) &&
	(grandef2h_y_t<=pix_y) && (pix_y<=grandef2h_y_b);
//---------------------------------------------------------------------

//sigue la caja del cronometro
//vertical1
	
	localparam grandec1v_left=320;
	localparam grandec1v_right=325;
	localparam grandec1v_y_t = 360; 
	localparam grandec1v_y_b = 450;
	wire  grandec1v_on;
	assign grandec1v_on = (grandec1v_left<=pix_x) && (pix_x<=grandec1v_right) &&
	(grandec1v_y_t<=pix_y) && (pix_y<=grandec1v_y_b);	
//vertial2
	
	localparam grandec2v_left=558;
	localparam grandec2v_right=561;
	localparam grandec2v_y_t = 360; 
	localparam grandec2v_y_b = 450;
	wire  grandec2v_on;
	assign grandec2v_on = (grandec2v_left<=pix_x) && (pix_x<=grandec2v_right) &&
	(grandec2v_y_t<=pix_y) && (pix_y<=grandec2v_y_b);
//horizontal1
	
	localparam grandec1h_left=320;
	localparam grandec1h_right=561;
	localparam grandec1h_y_t = 360; 
	localparam grandec1h_y_b = 365;
	wire  grandec1h_on;
	assign grandec1h_on = (grandec1h_left<=pix_x) && (pix_x<=grandec1h_right) &&
	(grandec1h_y_t<=pix_y) && (pix_y<=grandec1h_y_b);
//horizontal2
	
	localparam grandec2h_left=320;
	localparam grandec2h_right=561;
	localparam grandec2h_y_t = 445; 
	localparam grandec2h_y_b = 450;
	wire  grandec2h_on;
	assign grandec2h_on = (grandec2h_left<=pix_x) && (pix_x<=grandec2h_right) &&
	(grandec2h_y_t<=pix_y) && (pix_y<=grandec2h_y_b);	


//---------------------------------------------------------------------------
//**********************************************************************

//recuadros dentro de la caja del reloj

//cajas para las horas
//primer caja
//vertical1
	
	localparam media1v_left=165;
	localparam media1v_right=168;
	localparam media1v_y_t = 55; 
	localparam media1v_y_b = 190;
	wire  media1v_on;
	assign media1v_on = (media1v_left<=pix_x) && (pix_x<=media1v_right) &&
	(media1v_y_t<=pix_y) && (pix_y<=media1v_y_b);	
//vertial2
	
	localparam media2v_left=280;
	localparam media2v_right=283;
	localparam media2v_y_t = 55; 
	localparam media2v_y_b = 190;
	wire  media2v_on;
	assign media2v_on = (media2v_left<=pix_x) && (pix_x<=media2v_right) &&
	(media2v_y_t<=pix_y) && (pix_y<=media2v_y_b);
//horizontal1
	localparam media1h_left=165;
	localparam media1h_right=280;
	localparam media1h_y_t = 55; 
	localparam media1h_y_b = 58;
	wire  media1h_on;
	assign media1h_on = (media1h_left<=pix_x) && (pix_x<=media1h_right) &&
	(media1h_y_t<=pix_y) && (pix_y<=media1h_y_b);
//horizontal2
	localparam media2h_left=165;
	localparam media2h_right=280;
	localparam media2h_y_t = 187; 
	localparam media2h_y_b = 190;
	wire  media2h_on;
	assign media2h_on = (media2h_left<=pix_x) && (pix_x<=media2h_right) &&
	(media2h_y_t<=pix_y) && (pix_y<=media2h_y_b);
//------------------------------------------	
//segunda caja
//------------------------------------------

//vertical1
	
	localparam media1v2_left=305;
	localparam media1v2_right=308;
	localparam media1v2_y_t = 55; 
	localparam media1v2_y_b = 190;
	wire  media1v2_on;
	assign media1v2_on = (media1v2_left<=pix_x) && (pix_x<=media1v2_right) &&
	(media1v2_y_t<=pix_y) && (pix_y<=media1v2_y_b);	
//vertial2
	
	localparam media2v2_left=425;
	localparam media2v2_right=428;
	localparam media2v2_y_t = 55; 
	localparam media2v2_y_b = 190;
	wire  media2v2_on;
	assign media2v2_on = (media2v2_left<=pix_x) && (pix_x<=media2v2_right) &&
	(media2v2_y_t<=pix_y) && (pix_y<=media2v2_y_b);
//horizontal1
	localparam media1h2_left=308;
	localparam media1h2_right=428;
	localparam media1h2_y_t = 55; 
	localparam media1h2_y_b = 58;
	wire  media1h2_on;
	assign media1h2_on = (media1h2_left<=pix_x) && (pix_x<=media1h2_right) &&
	(media1h2_y_t<=pix_y) && (pix_y<=media1h2_y_b);
//horizontal2
	localparam media2h2_left=308;
	localparam media2h2_right=428;
	localparam media2h2_y_t = 187; 
	localparam media2h2_y_b = 190;
	wire  media2h2_on;
	assign media2h2_on = (media2h2_left<=pix_x) && (pix_x<=media2h2_right) &&
	(media2h2_y_t<=pix_y) && (pix_y<=media2h2_y_b);

//tercera caja
//------------------------------------------

//vertical1
	
	localparam media1v3_left=450;
	localparam media1v3_right=453;
	localparam media1v3_y_t = 55; 
	localparam media1v3_y_b = 190;
	wire  media1v3_on;
	assign media1v3_on = (media1v3_left<=pix_x) && (pix_x<=media1v3_right) &&
	(media1v3_y_t<=pix_y) && (pix_y<=media1v3_y_b);	
//vertial2
	
	localparam media2v3_left=563;
	localparam media2v3_right=566;
	localparam media2v3_y_t = 55; 
	localparam media2v3_y_b = 190;
	wire  media2v3_on;
	assign media2v3_on = (media2v3_left<=pix_x) && (pix_x<=media2v3_right) &&
	(media2v3_y_t<=pix_y) && (pix_y<=media2v3_y_b);
//horizontal1
	localparam media1h3_left=453;
	localparam media1h3_right=563;
	localparam media1h3_y_t = 55; 
	localparam media1h3_y_b = 58;
	wire  media1h3_on;
	assign media1h3_on = (media1h3_left<=pix_x) && (pix_x<=media1h3_right) &&
	(media1h3_y_t<=pix_y) && (pix_y<=media1h3_y_b);
//horizontal2
	localparam media2h3_left=453;
	localparam media2h3_right=563;
	localparam media2h3_y_t = 187; 
	localparam media2h3_y_b = 190;
	wire  media2h3_on;
	assign media2h3_on = (media2h3_left<=pix_x) && (pix_x<=media2h3_right) &&
	(media2h3_y_t<=pix_y) && (pix_y<=media2h3_y_b);
//------------------------------------------------------------------------------

//********************************************
//CREACION DE CAJAS QUE VAN DENTRO DE LA CAJA DE FECHA
//-----------------------
//primer caja
//vertical1
	
	localparam fecha1v_left=330;
	localparam fecha1v_right=333;
	localparam fecha1v_y_t = 235; 
	localparam fecha1v_y_b = 315;
	wire  fecha1v_on;
	assign fecha1v_on = (fecha1v_left<=pix_x) && (pix_x<=fecha1v_right) &&
	(fecha1v_y_t<=pix_y) && (pix_y<=fecha1v_y_b);	
//vertial2
	
	localparam fecha2v_left=390;
	localparam fecha2v_right=393;
	localparam fecha2v_y_t = 235; 
	localparam fecha2v_y_b = 315;
	wire  fecha2v_on;
	assign fecha2v_on = (fecha2v_left<=pix_x) && (pix_x<=fecha2v_right) &&
	(fecha2v_y_t<=pix_y) && (pix_y<=fecha2v_y_b);
//horizontal1
	localparam fecha1h_left=333;
	localparam fecha1h_right=390;
	localparam fecha1h_y_t = 235; 
	localparam fecha1h_y_b = 238;
	wire  fecha1h_on;
	assign fecha1h_on = (fecha1h_left<=pix_x) && (pix_x<=fecha1h_right) &&
	(fecha1h_y_t<=pix_y) && (pix_y<=fecha1h_y_b);
//horizontal2
	localparam fecha2h_left=333;
	localparam fecha2h_right=390;
	localparam fecha2h_y_t = 312; 
	localparam fecha2h_y_b = 315;
	wire  fecha2h_on;
	assign fecha2h_on = (fecha2h_left<=pix_x) && (pix_x<=fecha2h_right) &&
	(fecha2h_y_t<=pix_y) && (pix_y<=fecha2h_y_b);

//segunda caja en la fecha

//vertical1
	
	localparam fecha1v2_left=403;
	localparam fecha1v2_right=406;
	localparam fecha1v2_y_t = 235; 
	localparam fecha1v2_y_b = 315;
	wire  fecha1v2_on;
	assign fecha1v2_on = (fecha1v2_left<=pix_x) && (pix_x<=fecha1v2_right) &&
	(fecha1v2_y_t<=pix_y) && (pix_y<=fecha1v2_y_b);	
//vertial2
	
	localparam fecha2v2_left=466;
	localparam fecha2v2_right=469;
	localparam fecha2v2_y_t = 235; 
	localparam fecha2v2_y_b = 315;
	wire  fecha2v2_on;
	assign fecha2v2_on = (fecha2v2_left<=pix_x) && (pix_x<=fecha2v2_right) &&
	(fecha2v2_y_t<=pix_y) && (pix_y<=fecha2v2_y_b);
//horizontal1
	localparam fecha1h2_left=406;
	localparam fecha1h2_right=466;
	localparam fecha1h2_y_t = 235; 
	localparam fecha1h2_y_b = 238;
	wire  fecha1h2_on;
	assign fecha1h2_on = (fecha1h2_left<=pix_x) && (pix_x<=fecha1h2_right) &&
	(fecha1h2_y_t<=pix_y) && (pix_y<=fecha1h2_y_b);
//horizontal2
	localparam fecha2h2_left=406;
	localparam fecha2h2_right=466;
	localparam fecha2h2_y_t = 312; 
	localparam fecha2h2_y_b = 315;
	wire  fecha2h2_on;
	assign fecha2h2_on = (fecha2h2_left<=pix_x) && (pix_x<=fecha2h2_right) &&
	(fecha2h2_y_t<=pix_y) && (pix_y<=fecha2h2_y_b);

//tercera caja dentro de fecha

//vertical1
	
	localparam fecha1v3_left=479;
	localparam fecha1v3_right=482;
	localparam fecha1v3_y_t = 235; 
	localparam fecha1v3_y_b = 315;
	wire  fecha1v3_on;
	assign fecha1v3_on = (fecha1v3_left<=pix_x) && (pix_x<=fecha1v3_right) &&
	(fecha1v3_y_t<=pix_y) && (pix_y<=fecha1v3_y_b);	
//vertial2
	
	localparam fecha2v3_left=542;
	localparam fecha2v3_right=545;
	localparam fecha2v3_y_t = 235; 
	localparam fecha2v3_y_b = 315;
	wire  fecha2v3_on;
	assign fecha2v3_on = (fecha2v3_left<=pix_x) && (pix_x<=fecha2v3_right) &&
	(fecha2v3_y_t<=pix_y) && (pix_y<=fecha2v3_y_b);
//horizontal1
	localparam fecha1h3_left=482;
	localparam fecha1h3_right=542;
	localparam fecha1h3_y_t = 235; 
	localparam fecha1h3_y_b = 238;
	wire  fecha1h3_on;
	assign fecha1h3_on = (fecha1h3_left<=pix_x) && (pix_x<=fecha1h3_right) &&
	(fecha1h3_y_t<=pix_y) && (pix_y<=fecha1h3_y_b);
//horizontal2
	localparam fecha2h3_left=482;
	localparam fecha2h3_right=542;
	localparam fecha2h3_y_t = 312; 
	localparam fecha2h3_y_b = 315;
	wire  fecha2h3_on;
	assign fecha2h3_on = (fecha2h3_left<=pix_x) && (pix_x<=fecha2h3_right) &&
	(fecha2h3_y_t<=pix_y) && (pix_y<=fecha2h3_y_b);

//---------------------------------------------------------------------------
//-----------------------------------------------------------------
//***************************************************
//---------------------------------------------------------------
//CAJAS QUE VAN DENTRO DEL CRONOMETRO


//vertical1
	
	localparam crono1v_left=330;
	localparam crono1v_right=333;
	localparam crono1v_y_t = 370; 
	localparam crono1v_y_b = 440;
	wire  crono1v_on;
	assign crono1v_on = (crono1v_left<=pix_x) && (pix_x<=crono1v_right) &&
	(crono1v_y_t<=pix_y) && (pix_y<=crono1v_y_b);	
//vertial2
	
	localparam crono2v_left=390;
	localparam crono2v_right=393;
	localparam crono2v_y_t = 370; 
	localparam crono2v_y_b = 440;
	wire  crono2v_on;
	assign crono2v_on = (crono2v_left<=pix_x) && (pix_x<=crono2v_right) &&
	(crono2v_y_t<=pix_y) && (pix_y<=crono2v_y_b);
//horizontal1
	localparam crono1h_left=333;
	localparam crono1h_right=390;
	localparam crono1h_y_t = 370; 
	localparam crono1h_y_b = 373;
	wire  crono1h_on;
	assign crono1h_on = (crono1h_left<=pix_x) && (pix_x<=crono1h_right) &&
	(crono1h_y_t<=pix_y) && (pix_y<=crono1h_y_b);
//horizontal2
	localparam crono2h_left=333;
	localparam crono2h_right=390;
	localparam crono2h_y_t = 437; 
	localparam crono2h_y_b = 440;
	wire  crono2h_on;
	assign crono2h_on = (crono2h_left<=pix_x) && (pix_x<=crono2h_right) &&
	(crono2h_y_t<=pix_y) && (pix_y<=crono2h_y_b);

//segunda caja crono

//vertical1
	
	localparam crono1v2_left=405;
	localparam crono1v2_right=408;
	localparam crono1v2_y_t = 370; 
	localparam crono1v2_y_b = 440;
	wire  crono1v2_on;
	assign crono1v2_on = (crono1v2_left<=pix_x) && (pix_x<=crono1v2_right) &&
	(crono1v2_y_t<=pix_y) && (pix_y<=crono1v2_y_b);	
//vertial2
	
	localparam crono2v2_left=470;
	localparam crono2v2_right=473;
	localparam crono2v2_y_t = 370; 
	localparam crono2v2_y_b = 440;
	wire  crono2v2_on;
	assign crono2v2_on = (crono2v2_left<=pix_x) && (pix_x<=crono2v2_right) &&
	(crono2v2_y_t<=pix_y) && (pix_y<=crono2v2_y_b);
//horizontal1
	localparam crono1h2_left=408;
	localparam crono1h2_right=470;
	localparam crono1h2_y_t = 370; 
	localparam crono1h2_y_b = 373;
	wire  crono1h2_on;
	assign crono1h2_on = (crono1h2_left<=pix_x) && (pix_x<=crono1h2_right) &&
	(crono1h2_y_t<=pix_y) && (pix_y<=crono1h2_y_b);
//horizontal2
	localparam crono2h2_left=408;
	localparam crono2h2_right=470;
	localparam crono2h2_y_t = 437; 
	localparam crono2h2_y_b = 440;
	wire  crono2h2_on;
	assign crono2h2_on = (crono2h2_left<=pix_x) && (pix_x<=crono2h2_right) &&
	(crono2h2_y_t<=pix_y) && (pix_y<=crono2h2_y_b);

//tercera caja crono

//vertical1
	
	localparam crono1v3_left=485;
	localparam crono1v3_right=488;
	localparam crono1v3_y_t = 370; 
	localparam crono1v3_y_b = 440;
	wire  crono1v3_on;
	assign crono1v3_on = (crono1v3_left<=pix_x) && (pix_x<=crono1v3_right) &&
	(crono1v3_y_t<=pix_y) && (pix_y<=crono1v3_y_b);	
//vertial2
	
	localparam crono2v3_left=552;
	localparam crono2v3_right=555;
	localparam crono2v3_y_t = 370; 
	localparam crono2v3_y_b = 440;
	wire  crono2v3_on;
	assign crono2v3_on = (crono2v3_left<=pix_x) && (pix_x<=crono2v3_right) &&
	(crono2v3_y_t<=pix_y) && (pix_y<=crono2v3_y_b);
//horizontal1
	localparam crono1h3_left=488;
	localparam crono1h3_right=552;
	localparam crono1h3_y_t = 437; 
	localparam crono1h3_y_b = 440;
	wire  crono1h3_on;
	assign crono1h3_on = (crono1h3_left<=pix_x) && (pix_x<=crono1h3_right) &&
	(crono1h3_y_t<=pix_y) && (pix_y<=crono1h3_y_b);
//horizontal2
	localparam crono2h3_left=488;
	localparam crono2h3_right=552;
	localparam crono2h3_y_t = 370; 
	localparam crono2h3_y_b = 373;
	wire  crono2h3_on;
	assign crono2h3_on = (crono2h3_left<=pix_x) && (pix_x<=crono2h3_right) &&
	(crono2h3_y_t<=pix_y) && (pix_y<=crono2h3_y_b);


always@* 
	if(~video_on)
		rgbtext=3'b000;
	else begin
		if (grandec2h_on | grandec1h_on | grandec1v_on |grandec2v_on | grandef2h_on | grandef1h_on | grandef2v_on | grandef1v_on | grande2h_on | grande1h_on | grande2v_on | grande1v_on)
			rgbtext=1;
		else if (media1v_on | media2v_on | media1h_on | media2h_on |media1v2_on | media2v2_on|media1h2_on |media2h2_on |media1v3_on | media2v3_on|media1h3_on |media2h3_on)
			rgbtext=1;
		else if(fecha1v_on | fecha2v_on | fecha1h_on | fecha2h_on |fecha1v2_on | fecha2v2_on | fecha1h2_on | fecha2h2_on |fecha1v3_on | fecha2v3_on | fecha1h3_on | fecha2h3_on)
			rgbtext=1;
		else if(crono1v_on | crono2v_on | crono1h_on | crono2h_on |crono1v2_on | crono2v2_on | crono1h2_on | crono2h2_on |crono1v3_on | crono2v3_on | crono1h3_on | crono2h3_on)
			rgbtext=1;
		else
		rgbtext=3'b000;
	
			
	end


endmodule
