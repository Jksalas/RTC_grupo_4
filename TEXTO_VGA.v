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
//Creador:
// Joao Salas Ramirez
//////////////////////////////////////////////////////////////////////////////////
module GENERADOR(

	 input [9:0] pix_y, pix_x,
	 input wire video_on,
	 input clk,reset,
	 output [11:0] rgbtext

    );

	//SECCION GENERADOR DE TEXTO EN LA PANTALLA

	// CONSTANTES Y DECLARACIONES

	wire [2:0] lsbx;
	wire [3:0] lsby;

	reg [2:0] lsbx_reg;
	reg [3:0] lsby_reg;
	assign lsbx = lsbx_reg;
	assign lsby = lsby_reg;

	reg [3:0] sel_car;
	reg [11:0] letter_rgb;



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


//este parte se utiliza para imprimir las letras de acuerdo a la coordenada, es una maquina de estados camuflada
always @(posedge clk,posedge reset) begin
	if(reset) begin
		AD<=0;
		sel_car<=0;
		lsbx_reg<=0;
		lsby_reg<=0;

	end
	else begin
	lsbx_reg<=pix_x[3:1];
	lsby_reg<=pix_y[4:1];
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
		else begin
			AD <= 2'h0;sel_car<=15;end
	    end
	end

	ROM FONT(reset,AD,lsby,Data,sel_car);


	reg pixelbit;


	always @*
	if(reset)
				pixelbit<=0;
	else begin
	case (lsbx)
		0: pixelbit <= Data[7];
		1: pixelbit <= Data[6];
		2: pixelbit <= Data[5];
		3: pixelbit <= Data[4];
		4: pixelbit <= Data[3];
		5: pixelbit <= Data[2];
		6: pixelbit <= Data[1];
		7: pixelbit <= Data[0];
		default:pixelbit<=0;
	endcase
	end

	always @*
	if(reset)
			letter_rgb<=0;
	else begin
		if (pixelbit)
			letter_rgb <= 12'hccc;
		else
			letter_rgb <= 0;end

	//**************************************************
	//*********SALIDAS , MULTIPLEXADO*********************************************************
	//**************************************************
	reg [11:0] rgbtext1;
	always@*
		if(~video_on)
			rgbtext1<=0;
		else begin
			if (Fon|Eon|Con|Hon|Aon|Ton|Ron|Oon|Ion|Mon)
				rgbtext1 <= letter_rgb;
			else if(~Fon|~Eon|~Con|~Hon|~Aon|~Ton|~Ron|~Oon|~Ion|~Mon)
				rgbtext1<=0;
			else
				rgbtext1<=12'b111111111111;
			end
assign rgbtext=rgbtext1;

endmodule
