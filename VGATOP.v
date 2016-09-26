
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    22:14:54 09/19/2016
// Design Name:
// Module Name:    VGATOP
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
//hecho por Joao Salas Ramirez
//////////////////////////////////////////////////////////////////////////////////
module VGATOP(
	input wire clk,reset,
	input activar_alarma,
  output wire hsync, vsync, /*video_on1,*/
  output wire [11:0] rgb,
  //output [9:0] pixX,pixY,
  input [7:0] hour_in1,hour_in2,hour_in3,
	input [7:0] fecha_in1,fecha_in2,fecha_in3,
  input [7:0] timer_in1,timer_in2,timer_in3

);




  wire [9:0] pixel_y,pixel_x;
  wire video_on , pixel_tick;
  reg [11:0] rgb_reg;
  wire [11:0] rgb_next;

  wire [11:0] rgb_ring,rgb_letra,rgb_bordes;
  reg [11:0] rgb_ring_reg;
  reg [11:0]rgb_letra_reg;
  reg [11:0]rgb_bordes_reg;
  wire [11:0] rgb_ring_next,rgb_letra_next,rgb_bordes_next;


  //para numeros
  wire [11:0] rgb_numero_hora;
  wire [11:0] rgb_numero_hora_next;
  reg [11:0] rgb_numero_hora_reg;

  wire [11:0] rgb_numero_fecha;
  wire [11:0] rgb_numero_fecha_next;
  reg [11:0] rgb_numero_fecha_reg;

  wire [11:0] rgb_numero_timer;
  wire [11:0] rgb_numero_timer_next;
  reg [11:0] rgb_numero_timer_reg;

	wire [11:0] rgb_simbolo;
	wire [11:0] rgb_simbolo_next;
	reg [11:0] rgb_simbolo_reg;




//assign video_on1=video_on;
wire okh,okf,okt,oksimbolo,okring;


SIMBOLOS simb(.okmaquina(oksimbolo),
.pix_y(pixel_y),.pix_x(pixel_x),
.video_on(video_on),
.clk(clk),.reset(reset),
.rgbtext(rgb_simbolo_next)
);


HOURNUMBERS horasvga(
 .okmaquina(okh),
 .pix_y(pixel_y), .pix_x(pixel_x),
 .video_on(video_on),
 .clk(clk),.reset(reset),
 .rgbtext(rgb_numero_hora_next),
 .hour_in1(hour_in1),.hour_in2(hour_in2),.hour_in3(hour_in3)

 );

 DATENUMBERS datevg(
	.okmaquina(okf),
  .pix_y(pixel_y), .pix_x(pixel_x),
  .video_on(video_on),
  .clk(clk),.reset(reset),
  .rgbtext(rgb_numero_fecha_next),
  .fecha_in1(fecha_in1),.fecha_in2(fecha_in2),.fecha_in3(fecha_in3)
  );


  TIMERNUMBERS cronovga(
		.okmaquina(okt),
   .pix_y(pixel_y), .pix_x(pixel_x),
   .video_on(video_on),
   .clk(clk),.reset(reset),
   .rgbtext(rgb_numero_timer_next),
   .timer_in1(timer_in1),.timer_in2(timer_in2),.timer_in3(timer_in3)

   );

SINCRONIZADOR sync(.clk(clk),
.reset(reset),
.hsync(hsync),
.vsync(vsync),
.video_activado(video_on),
.instante_pulso(pixel_tick),
.pixel_x(pixel_x),
.pixel_y(pixel_y)
);



RING finish(.activar_alarma(activar_alarma),
.okmaquina(okring),
.pix_y(pixel_y),
.pix_x(pixel_x),
.video_on(video_on),
.clk(clk),
.reset(reset),
.rgbtext(rgb_ring_next)
);

SQUARE sq(

.pix_y(pixel_y),.pix_x(pixel_x),
.video_on(video_on),
.reset(reset),
.rgbtext(rgb_bordes_next)
);

TEXTO texto(

.pix_y(pixel_y),.pix_x(pixel_x),
.video_on(video_on),
.clk(clk),.reset(reset),
.rgbtext(rgb_letra_next)

);



SELECCIONADOR_RGB selector(.clk(clk),.video_on(video_on),.reset(reset),.pix_x(pixel_x),.pix_y(pixel_y),
.rgb_numero_hora(rgb_numero_hora),.rgb_numero_fecha(rgb_numero_fecha),.rgb_numero_timer(rgb_numero_timer),
.rgb_ring(rgb_ring),.rgb_letra(rgb_letra),.rgb_simbolo(rgb_simbolo),
.rgb_bordes(rgb_bordes),.rgb_screen(rgb_next),
.okh(okh),.okf(okf),.okt(okt),.oksimbolo(oksimbolo),.okring(okring)
);



//assign pixX=pixel_x;
//assign pixY=pixel_y;

always @(posedge clk)
if(reset)begin
	rgb_reg <= 0;

  rgb_numero_hora_reg<=0;
  rgb_numero_fecha_reg<=0;
  rgb_numero_timer_reg<=0;

  rgb_ring_reg<=0;
  rgb_letra_reg<=0;
  rgb_bordes_reg<=0;
	rgb_simbolo_reg<=0;

end

else if(pixel_tick) begin
  rgb_reg <= rgb_next;

  rgb_numero_hora_reg<=rgb_numero_hora_next;
  rgb_numero_fecha_reg<=rgb_numero_fecha_next;
  rgb_numero_timer_reg<=rgb_numero_timer_next;

  rgb_ring_reg<=rgb_ring_next;
  rgb_letra_reg<=rgb_letra_next;
  rgb_bordes_reg<=rgb_bordes_next;
	rgb_simbolo_reg<=rgb_simbolo_next;
  end


assign rgb_simbolo=rgb_simbolo_reg;
assign rgb=rgb_reg;
assign rgb_numero_hora=rgb_numero_hora_reg;
assign rgb_numero_fecha=rgb_numero_fecha_reg;
assign rgb_numero_timer=rgb_numero_timer_reg;


assign rgb_ring=rgb_ring_reg;
assign rgb_letra=rgb_letra_reg;
assign rgb_bordes = rgb_bordes_reg;

endmodule
