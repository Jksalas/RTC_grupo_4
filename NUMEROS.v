`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    00:48:18 09/18/2016
// Design Name:
// Module Name:    NUMEROS
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
module NUMEROS(
    input [9:0] pix_y, pix_x,
    input wire video_on,
    input clk,reset,
    output reg [11:0] rgbtext
  );
  //SECCION GENERADOR DE numeros EN LA PANTALLA


	// CONSTANTES Y DECLARACIONES
  reg pixelbit;
	wire [2:0] lsbx;
	wire [3:0] lsby;
	reg [2:0] lsbx_reg;
	reg [3:0] lsby_reg;
	//assign lsbx = pix_x[4:2];
	//assign lsby = pix_y[6:3];

	reg [3:0] sel_car;
	reg [11:0] letter_rgb;

	wire [7:0] Data;
	reg [1:0] AD;


	// limites de la pantalla


ROM1 FONT(AD,lsby,Data,sel_car);//se instancia la ROM


//variables de activacion
	wire on_0,on_1,on_2,on_3,on_4,on_5,on_6, on_7,on_8,on_9;
  wire ruedaon1,ruedaon2,on2_0,on2_9;
  wire on0_0,on0_1,on0_2,barrafecha;
  wire on0_3,on0_4,on0_5;

// ACTIVADORES DE numeros
//-------------------------------------------------------------
//numeros de hora 64x32   //en c van de 192 a 447
	assign on_1 =(192<=pix_x) && (pix_x<=223) &&(64<=pix_y) && (pix_y<=127);
	assign on_2 =(224<=pix_x) && (pix_x<=255) && (64<=pix_y) && (pix_y<=127);
  //separacion
	assign on_3 =(320<=pix_x) && (pix_x<=351) &&(64<=pix_y) && (pix_y<=127);
	assign on_4 =(352<=pix_x) && (pix_x<=383) && (64<=pix_y) && (pix_y<=127);
  //separacion
	assign on_5 =(448<=pix_x) && (pix_x<=479) &&(64<=pix_y) && (pix_y<=127);
	assign on_6 =(480<=pix_x) && (pix_x<=511) &&(64<=pix_y) && (pix_y<=127);

  //puntos separadores de hora
  assign ruedaon1= ((280<=pix_x) && (pix_x<=287) && ((64<=pix_y) && (pix_y<=127)|(320<=pix_y) && (pix_y<=383)))|
  ((416<=pix_x) && (pix_x<=423) && ((64<=pix_y) && (pix_y<=127)|(320<=pix_y) && (pix_y<=383)));
//------------------------------------------------------
//numeros de fecha   64x32
	assign on_7 =(160<=pix_x) && (pix_x<=192) && (192<=pix_y) && (pix_y<=255);
	assign on_8 =(192<=pix_x) && (pix_x<=223) &&(192<=pix_y) && (pix_y<=255);
  //separacion
  assign on_9 =(320<=pix_x) && (pix_x<=351) &&(192<=pix_y) && (pix_y<=255);
  assign on_0 =(352<=pix_x) && (pix_x<=383) && (192<=pix_y) && (pix_y<=255);

  //auxiliares para mostrar fecha
  assign on2_9 =(480<=pix_x) && (pix_x<=511) &&(192<=pix_y) && (pix_y<=255);
  assign on2_0 =(512<=pix_x) && (pix_x<=543) && (192<=pix_y) && (pix_y<=255);

  assign barrafecha=((416<=pix_x) && (pix_x<=423) && (192<=pix_y) && (pix_y<=255))|(
      (256<=pix_x) && (pix_x<=263) && (192<=pix_y) && (pix_y<=255));

//NUMEROS PARA CRONOMETRO  64x32
  assign on0_0 =(192<=pix_x) && (pix_x<=223) && (320<=pix_y) && (pix_y<=383);
  assign on0_1 =(224<=pix_x) && (pix_x<=255) &&(320<=pix_y) && (pix_y<=383);
//separacion
  assign on0_2 =(320<=pix_x) && (pix_x<=351) &&(320<=pix_y) && (pix_y<=383);
  assign on0_3 =(352<=pix_x) && (pix_x<=383) && (320<=pix_y) && (pix_y<=383);

//auxiliares para mostrar fecha
  assign on0_4 =(448<=pix_x) && (pix_x<=479) &&(320<=pix_y) && (pix_y<=383);
  assign on0_5 =(480<=pix_x) && (pix_x<=511) && (320<=pix_y) && (pix_y<=383);

//  assign ruedaon2= ((280<=pix_x) && (pix_x<=287) && (384<=pix_y) && (pix_y<=447))|(
    //  (416<=pix_x) && (pix_x<=423) && (320<=pix_y) && (pix_y<=383));

//---------------------------------------------------------




//deteccion y generacion de la señal para la direccion de la ROM

always @(posedge clk, posedge reset) begin
	if(reset) begin
		AD<=0;
		sel_car<=0;
	end
	else begin
		if (on_1) begin
			AD <= 2'h1;  //primeros 6 numeros
			sel_car<=4;
			lsby_reg= pix_y[5:2];lsbx_reg= pix_x[4:2];
				end
		else if (on_2)begin
			AD <= 2'h2;
			sel_car<=4;
			lsby_reg= pix_y[5:2];lsbx_reg= pix_x[4:2];
				end
		else if (on_3)begin
			AD <= 2'h3;
			lsby_reg= pix_y[5:2];lsbx_reg= pix_x[4:2];
			sel_car<=4;end
		else if (on_4)begin
			AD <= 2'h0;
			lsby_reg= pix_y[5:2];lsbx_reg= pix_x[4:2];
			sel_car<=5;end
		else if (on_5)begin
			AD <= 2'h1;
      			lsby_reg= pix_y[5:2];lsbx_reg= pix_x[4:2];
			sel_car<=5;end
		else if (on_6)begin
			AD <= 2'h2;
      			lsby_reg= pix_y[5:2];lsbx_reg= pix_x[4:2];
			sel_car<=5;end //fin de primeros 6 numeros
		else if (on_7)begin
			AD <= 2'h3;
     			lsby_reg= pix_y[5:2];lsbx_reg= pix_x[4:2];
			sel_car<=5;end
		else if (on_8)begin
			AD <= 2'h0;
      lsby_reg= pix_y[5:2];lsbx_reg= pix_x[4:2];
			sel_car<=6;end
		else if (on_9)begin
			AD <= 2'h1;
      lsby_reg= pix_y[5:2];lsbx_reg= pix_x[4:2];
			sel_car<=6;end
    else if (on_0)begin
  			AD <= 2'h0;
        lsby_reg= pix_y[5:2];lsbx_reg= pix_x[4:2];
  			sel_car<=4;end
    else if (on2_9)begin
  			AD <= 2'h1;
        lsby_reg= pix_y[5:2];lsbx_reg= pix_x[4:2];
        sel_car<=6;end
    else if (on2_0)begin
      	AD <= 2'h0;
        lsby_reg= pix_y[5:2];lsbx_reg= pix_x[4:2];
      	sel_car<=4;end
    else if (ruedaon1)begin
    			AD <= 2'h2;
          lsby_reg= pix_y[5:2];lsbx_reg= pix_x[2:0];
      		sel_car<=6;end
    else if (ruedaon2)begin
            AD <= 2'h2;
            lsby_reg= pix_y[5:2];lsbx_reg= pix_x[3:1];
            sel_car<=6;end
    else if (barrafecha)begin
            AD <= 2'h0;
            lsby_reg= pix_y[5:2];lsbx_reg= pix_x[2:0];
            sel_car<=3;end
    else if (on0_0 | on0_1 | on0_2 | on0_3 | on0_4 | on0_5)begin
          AD <= 2'h0;
          lsby_reg= pix_y[5:2];lsbx_reg= pix_x[4:2];
          sel_car<=4;end
		else
			AD <= 2'h0;
	    end
	end
/*
wire on0_0,on0_1,on0_2,barrafecha;
wire on0_3,on0_4,on0_5;
*/
  assign lsbx= lsbx_reg;
  assign lsby=lsby_reg;

//CARGA DE DATOS DE LA ROM AL BIT DE SALIDA
always @*
	case (lsbx)
		3'h00: pixelbit <= Data[7];
		3'h01: pixelbit <= Data[6];
		3'h02: pixelbit <= Data[5];
		3'h03: pixelbit <= Data[4];
		3'h04: pixelbit <= Data[3];
		3'h05: pixelbit <= Data[2];
		3'h06: pixelbit <= Data[1];
		3'h07: pixelbit <= Data[0];

	endcase
//del registro al bit de salida final
always @*
		if (pixelbit)
			letter_rgb <= 12'h0ff;
		else
			letter_rgb <= 0;
//--------------------------------------------
//*********logica para SALIDA, aqui se multiplexa*******
//------------------------------------------------------

always@*
		if(~video_on)
			rgbtext=0;
		else begin
  		if (on0_0 | on0_1 | on0_2 | on0_3 | on0_4 | on0_5| barrafecha |on2_0|on2_9|on_0|on_1|on_2|on_3|on_4|on_5|on_6|on_7|on_8|on_9|ruedaon1|ruedaon2)
  				rgbtext = letter_rgb;
  		else
  				rgbtext=0;
		end

endmodule
