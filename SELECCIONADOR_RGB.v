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
//
//////////////////////////////////////////////////////////////////////////////////
module SELECCCIONADOR_RGB(
    input wire video_on,
    input wire [9:0] pix_x,pix_y,
    input wire [11:0] rgb_numero,rgb_ring,rgb_letra,rgb_bordes,
    output wire [11:0] rgb_screen

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



always@*
		if(~video_on)
			rgb_screenreg=0;
		else begin
  		if (ruedaon1_on | barrafecha_on | hour1on | hour2on | hour3on | date1on | date2on | date3on | timer1on | timer2on | timer3on)
  				rgb_screenreg = rgb_numero;
  		else if(fecha_word | hora_word | timer_word)
  				rgb_screenreg = rgb_letra;
      else if(ring_word)
      			rgb_screenreg = rgb_ring;
      else
        rgb_screenreg = rgb_bordes;

		end

 assign rgb_screen=rgb_screenreg;

endmodule
