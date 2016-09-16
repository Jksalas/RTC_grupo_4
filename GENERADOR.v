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
// Description:
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
	 output reg [2:0] rgbtext,
	 output wire [5:0] adress1,
	 output wire Fono, Eono, Cono,Hono,Aono,Tono, Iono, Rono,Oono,Mono
    );



	//SECCION GENERADOR DE TEXTO EN LA PANTALLA


	// CONSTANTES Y DECLARACIONES

	wire [2:0] lsbx;
	wire [3:0] lsby;
	assign lsbx = pix_x[4:2];
	assign lsby = pix_y[6:3];

	reg [3:0] sel_car;
	reg [2:0] letter_rgb;

	wire caja1,caja2,caja3;
	assign caja1 =	(95<=pix_x) && (pix_x<=175) &&	(62<=pix_y) && (pix_y<=128);
	assign caja2 =	(95<=pix_x) && (pix_x<=175) &&	(62<=pix_y) && (pix_y<=128);
	assign caja3 =	(95<=pix_x) && (pix_x<=175) &&	(62<=pix_y) && (pix_y<=128);

	wire [7:0] Data;
	reg [1:0] AD;

	// x , y coordinates (0.0) to (639,479)
	localparam maxx = 640;
	localparam maxy = 480;

	// Letter boundaries
	localparam Fxl = 128;
	localparam Fxr = 159;
	localparam Exl = 160;localparam Exl2 = 224;
	localparam Exr = 191;localparam Exr2 = 255;
	localparam Cxl = 192;
	localparam Cxr = 223;
	localparam Hxl = 0;localparam Hxl2 = 224;
	localparam Hxr = 31;localparam Hxr2 = 255;
	localparam Axl = 96;localparam Axl2 = 256;
	localparam Axr = 127;localparam Axr2 = 287;

	localparam Txr = 128;
	localparam Txl = 159;
	localparam Ixr = 160;
	localparam Ixl = 191;
	localparam Rxr = 64;localparam Rxll = 256;
	localparam Rxl = 95;localparam Rxrr = 287;
	localparam Oxr = 32;
	localparam Oxl = 63;
	localparam Mxr = 192;
	localparam Mxl = 223;

	//limites verticales
	localparam yt = 0;
	localparam yb = 127;

	localparam ytt = 256;
	localparam ybb = 384;

	localparam yttt = 385;
	localparam ybbb = 512;


	// letter output signals

	// CUERPO

	wire Fon, Eon, Con,Hon,Aon,Ton, Ion, Ron,Oon,Mon;
	wire on_0,on_1,on_2,on_3,on_4,on_5,on_6, on_7,on_8,on_9;
	wire ring;
	assign  Fono=Fon;
 	assign	Eono=Eon;
	assign	Cono=Con;
	assign	Hono=Hon;
	assign	Aono=Aon;
	assign	Tono=Ton;
	assign	Iono=Ion;
 	assign  Rono=Ron;
	assign	Oono=Oon;
	assign	Mono=Mon;


//letras activacion
	assign Hon =((Hxl<=pix_x) && (pix_x<=Hxr) &&(yt<=pix_y) && (pix_y<=yb))|
	((Hxl2<=pix_x) && (pix_x<=Hxr2) &&(ytt<=pix_y) && (pix_y<=ybb));


	assign Fon =(Fxl<=pix_x) && (pix_x<=Fxr) &&(ytt<=pix_y) && (pix_y<=ybb);

	assign Eon =((Exl<=pix_x) && (pix_x<=Exr) && (ytt<=pix_y) && (pix_y<=ybb))|(
			(Exl2<=pix_x) && (pix_x<=Exr2) && (yttt<=pix_y) && (pix_y<=ybbb));

	assign Con =(Cxl<=pix_x) && (pix_x<=Cxr) &&(ytt<=pix_y) && (pix_y<=ybb);



	assign Aon =((Axl<=pix_x) && (pix_x<=Axr) &&	(yt<=pix_y) && (pix_y<=yb))|
	((Axl2<=pix_x) && (pix_x<=Axr2) &&(ytt<=pix_y) && (pix_y<=ybb));


	assign Ton =	(128<=pix_x) && (pix_x<=159) &&	(385<=pix_y) && (512<=ybbb);

	assign Ion =	(160<=pix_x) && (pix_x<=191) &&	(385<=pix_y) && (pix_y<=512);

	assign Ron =	((64<=pix_x) && (pix_x<=95) &&(yt<=pix_y) && (pix_y<=yb))|
	((Rxll<=pix_x) && (pix_x<=Rxrr) &&(yttt<=pix_y) && (pix_y<=ybbb));

	assign Oon =	(32<=pix_x) && (pix_x<=63) &&(0<=pix_y) && (pix_y<=127);

	assign Mon =	(192<=pix_x) && (pix_x<=223) &&(385<=pix_y) && (pix_y<=512);

	assign ring=  (575<=pix_x) && (pix_x<=606)&&(385<=pix_y) && (pix_y<=512);


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

	ROM1 FONT(AD,lsby,Data,adress1,sel_car);


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
			letter_rgb <= 1;
		else
			letter_rgb <= 0;

	//**************************************************
	//*********SALIDAS , MULTIPLEXADO*********************************************************
	//**************************************************
	always@*
		if(~video_on)
			rgbtext=3'b000;
		else begin


			if (Fon|Eon|Con|Hon|Aon|Ton|Ron|Oon|Ion|Mon)
				rgbtext = letter_rgb;
				else
				rgbtext=3'b000;
			end

endmodule
