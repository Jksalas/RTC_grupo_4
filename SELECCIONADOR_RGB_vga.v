`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    00:50:24 09/18/2016
// Design Name:
// Module Name:    SELECCIONADOR_RGB
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
//hecho por: joao salas ramirez
//este modulo se encarga de seleccionar cual caracter, numero, simbolo... debe desplegarse en la pantalla
//de acuerdo a la coordenada actual
//////////////////////////////////////////////////////////////////////////////////
module SELECCIONADOR_RGB(
input clk,
    input wire video_on,reset,
    input wire [9:0] pix_x,pix_y,
    input wire [11:0] rgb_numero_hora,rgb_numero_fecha,rgb_numero_timer,
    input wire [11:0] rgb_ring,rgb_letra,rgb_bordes,rgb_simbolo,
    output wire [11:0] rgb_screen,
    output reg okh,okf,okt,oksimbolo,okring

    );

    //coordenadas de seleccion
//*************************************************
    //----------------para numeros-----------------
    wire hour1on,hour2on,hour3on;
    wire date1on,date2on,date3on;
    wire timer1on,timer2on,timer3on;

    assign hour1on=(192<=pix_x) && (pix_x<=255) &&(64<=pix_y) && (pix_y<=127);
    assign hour2on=(320<=pix_x) && (pix_x<=383) &&(64<=pix_y) && (pix_y<=127);
    assign hour3on=(448<=pix_x) && (pix_x<=511) &&(64<=pix_y) && (pix_y<=127);


    assign date1on=(160<=pix_x) && (pix_x<=223) &&(192<=pix_y) && (pix_y<=255);
    assign date2on=(320<=pix_x) && (pix_x<=383) &&(192<=pix_y) && (pix_y<=255);
    assign date3on=(480<=pix_x) && (pix_x<=543) &&(192<=pix_y) && (pix_y<=255);

    assign timer1on=(192<=pix_x) && (pix_x<=255) &&(320<=pix_y) && (pix_y<=383);
    assign timer2on=(320<=pix_x) && (pix_x<=383) &&(320<=pix_y) && (pix_y<=383);
    assign timer3on=(448<=pix_x) && (pix_x<=511) &&(320<=pix_y) && (pix_y<=383);

//----------------------------para puntos separadores de hora fecha y crono-------------------
  wire barrafecha_on;
  wire ruedaon1_on;
assign barrafecha_on=((416<=pix_x) && (pix_x<=423) && (192<=pix_y) && (pix_y<=255))|(
  (256<=pix_x) && (pix_x<=263) && (192<=pix_y) && (pix_y<=255));

assign ruedaon1_on= ((280<=pix_x) && (pix_x<=287) && ((64<=pix_y) && (pix_y<=127)|(320<=pix_y) && (pix_y<=383)))|
  ((416<=pix_x) && (pix_x<=423) && ((64<=pix_y) && (pix_y<=127)|(320<=pix_y) && (pix_y<=383)));



//*******************************************************
    //----------------para letras-----------------
    wire fecha_word,hora_word,timer_word;

    assign fecha_word=(48<=pix_x) && (pix_x<=127) &&(192<=pix_y) && (pix_y<=223);
    assign hora_word=(64<=pix_x) && (pix_x<=127) &&(64<=pix_y) && (pix_y<=95);
    assign timer_word=(64<=pix_x) && (pix_x<=143) &&(320<=pix_y) && (pix_y<=351);


    //----------------para RING-----------------
    wire ring_word;
    assign ring_word=(576<=pix_x) && (pix_x<=623) &&(320<=pix_y) && (pix_y<=383);


    //------------------PARA LOS BORDES ES EL ELSE------

    //multiplexado de salida

     reg [11:0] rgb_screenreg;


//input wire [11:0] rgb_numero_hora,rgb_numero_fecha,rgb_numero_timer,

always@(posedge clk)
    if(reset) begin
        rgb_screenreg<=0;
        okf<=0;
        oksimbolo<=0;
        okh<=0;
        okt<=0;
		  okring<=0;

    end
    else begin
		if(~video_on)
			rgb_screenreg<=0;
		else begin
  		if  (hour1on | hour2on | hour3on ) begin
  				rgb_screenreg <= rgb_numero_hora;
          okh<=1;end
      else if ( date1on | date2on | date3on )begin
  				rgb_screenreg <= rgb_numero_fecha;
          okf<=1;end
      else if ( timer1on | timer2on | timer3on) begin
  				rgb_screenreg <= rgb_numero_timer;
          okt<=1;end
  		else if(fecha_word | hora_word | timer_word)
  				rgb_screenreg <= rgb_letra;

      else if (barrafecha_on | ruedaon1_on ) begin
  				rgb_screenreg <= rgb_simbolo;oksimbolo<=1;end
      else if(ring_word) begin
      			rgb_screenreg <= rgb_ring;
            okring<=1;
            end
      else
        rgb_screenreg <= rgb_bordes;

		      end
    end
 assign rgb_screen=rgb_screenreg;

endmodule
