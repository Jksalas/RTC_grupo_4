`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    23:46:54 09/14/2016
// Design Name:
// Module Name:    GENERADOR
// Project Name:
// Target Devices:
// Tool versions:
// Description: ESTE MODULO ES PARA IMPRIMIR LAS LETRAS EN LA PANTALLA
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module GENERADOR(
	 input [9:0] pix_y, pix_x,
	 input wire video_on,
	 input clk,reset,
	 output reg [11:0] rgbtext

    );

	//SECCION GENERADOR DE TEXTO EN LA PANTALLA

	// CONSTANTES Y DECLARACIONES

	wire [2:0] lsbx;
	wire [3:0] lsby;
	assign lsbx = pix_x[3:1];
	assign lsby = pix_y[4:1];

	reg [3:0] sel_car;
	reg [11:0] letter_rgb;

	wire caja1,caja2,caja3;
	assign caja1 =	(95<=pix_x) && (pix_x<=175) &&	(62<=pix_y) && (pix_y<=128);
	assign caja2 =	(95<=pix_x) && (pix_x<=175) &&	(62<=pix_y) && (pix_y<=128);
	assign caja3 =	(95<=pix_x) && (pix_x<=175) &&	(62<=pix_y) && (pix_y<=128);

	wire [7:0] Data;
	reg [1:0] AD;

	wire Fon, Eon, Con,Hon,Aon,Ton, Ion, Ron,Oon,Mon;

//letras activacion
	assign Hon =((64<=pix_x) && (pix_x<=79) &&(64<=pix_y) && (pix_y<=95))|
	((96<=pix_x) && (pix_x<=111) &&(192<=pix_y) && (pix_y<=223));

	assign Fon =(48<=pix_x) && (pix_x<=63) &&(192<=pix_y) && (pix_y<=223);

	assign Eon =((64<=pix_x) && (pix_x<=79) && (192<=pix_y) && (pix_y<=223))|(
		(112<=pix_x) && (pix_x<=127) && (320<=pix_y) && (pix_y<=351));

	assign Con =(80<=pix_x) && (pix_x<=95) &&(192<=pix_y) && (pix_y<=223);

	assign Aon =((112<=pix_x) && (pix_x<=127) &&	(64<=pix_y) && (pix_y<=95))|
	((112<=pix_x) && (pix_x<=127) &&(192<=pix_y) && (pix_y<=223));

	assign Ton =	(64<=pix_x) && (pix_x<=79) &&	(320<=pix_y) && (pix_y<=351);

	assign Ion =	(80<=pix_x) && (pix_x<=95) &&	(320<=pix_y) && (pix_y<=351);

	assign Ron =	((96<=pix_x) && (pix_x<=111) &&(64<=pix_y) && (pix_y<=95))|
	((128<=pix_x) && (pix_x<=143) &&(320<=pix_y) && (pix_y<=351));

	assign Oon =	(80<=pix_x) && (pix_x<=95) &&(64<=pix_y) && (pix_y<=95);

	assign Mon =	(96<=pix_x) && (pix_x<=111) &&(320<=pix_y) && (pix_y<=351);




	always @(posedge clk,posedge reset) begin
	if(reset) begin
		AD<=0;
		sel_car<=0;
	end
	else begin
		if (Fon) begin
			AD <= 2'h1;
			sel_car<=1;end
		else if (Eon)begin
			AD <= 2'h2;
			sel_car<=1;end
		else if (Con)begin
			AD <= 2'h3;
			sel_car<=1;end
		else if (Hon)begin
			AD <= 2'h0;
			sel_car<=2;end
		else if (Aon)begin
			AD <= 2'h1;
			sel_car<=2;end
		else if (Ton)begin
			AD <= 2'h2;
			sel_car<=2;end
		else if (Ion)begin
			AD <= 2'h3;
			sel_car<=2;end
		else if (Ron)begin
			AD <= 2'h3;
			sel_car<=3;end
		else if (Oon)begin
			AD <= 2'h1;
			sel_car<=3;end
		else if (Mon)begin
			AD <= 2'h2;
			sel_car<=3;end
		else
			AD <= 2'h0;
	    end
	end

	ROM1 FONT(AD,lsby,Data,sel_car);


	reg pixelbit;


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

	always @*
		if (pixelbit)
			letter_rgb <= 12'hfff;
		else
			letter_rgb <= 0;

	//**************************************************
	//*********SALIDAS , MULTIPLEXADO*********************************************************
	//**************************************************
	always@*
		if(~video_on)
			rgbtext=0;
		else begin


			if (Fon|Eon|Con|Hon|Aon|Ton|Ron|Oon|Ion|Mon)
				rgbtext = letter_rgb;
				else
				rgbtext=0;
			end

endmodule
