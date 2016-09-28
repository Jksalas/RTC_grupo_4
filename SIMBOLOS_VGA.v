`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    20:02:45 09/20/2016
// Design Name:
// Module Name:    SIMBOLOS
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
//hecho por : JOAO SALAS RAMIREZ
//Este modulo imprime los simbolos en la pantalla, los simbolos son: los puntos que separan las horas y las barras que separan
//la fecha
//////////////////////////////////////////////////////////////////////////////////
module SIMBOLOS(
input okmaquina,
input [9:0] pix_y, pix_x,
input wire video_on,
input clk,reset,
output wire [11:0] rgbtext
);

reg pixelbit;

wire ruedaon1;
wire [2:0] lsbx;
wire [3:0] lsby;
reg [2:0] lsbx_reg;
reg [3:0] lsby_reg;

assign lsbx= lsbx_reg;
assign lsby=lsby_reg;

reg [11:0] letter_rgb;

wire barrafecha;



//para la rom
wire [7:0] Data_rom;

//para el decodificador
   reg [1:0] AD;

   reg [3:0] sel_car;

// fecha_in1,fecha_in2,fecha_in3

ROM FONT(reset,AD,lsby,Data_rom,sel_car);

parameter h0=0,h1=1;
reg state;

always @(posedge clk) begin
      if(reset) begin
          AD<=0;
          sel_car<=0;
        	 lsby_reg<= 0;
          lsbx_reg<= 0;
        end
      else if (okmaquina) begin
        case(state)
        		h0: begin
            		if (ruedaon1)begin
            				  AD <=2'h2;
            				  lsby_reg<= pix_y[5:2];lsbx_reg<= pix_x[2:0];
            				  sel_car<=6;
            				  state<=h0;end

            		else if (~ruedaon1)
            				state<=h1;end
        		h1: begin
            		if (barrafecha)begin
            				  AD <=2'h0 ;
            				  lsby_reg<= pix_y[5:2];lsbx_reg<= pix_x[2:0];
            				  sel_car<=3;
            				  state<=h1;
            				  end
            		else if (~barrafecha)
            			state<=h0;
      			   	end
              default: begin  state<=h0;sel_car<=15;AD <=2'h3; end

        		endcase
				end
		else begin
		    AD<=1;
          sel_car<=15;
        	 lsby_reg<= 0;
          lsbx_reg<= 0;
			 end

end



//------------------------------------------------------


  //-----------------------------------------------------
//COORDENADAS DONDE SE PIENSA IMPRIMIR
//-------------------------------------------------------------
  //puntos separadores de hora y timer
  assign ruedaon1= ((280<=pix_x) && (pix_x<=287) && ((64<=pix_y) && (pix_y<=127)|(320<=pix_y) && (pix_y<=383)))|
  ((416<=pix_x) && (pix_x<=423) && ((64<=pix_y) && (pix_y<=127)|(320<=pix_y) && (pix_y<=383)));

  assign barrafecha=((416<=pix_x) && (pix_x<=423) && (192<=pix_y) && (pix_y<=255))|(
      (256<=pix_x) && (pix_x<=263) && (192<=pix_y) && (pix_y<=255));

//logica de salida

    always @*
    if(reset)
        pixelbit<=0;
    else begin
      case (lsbx)
        0: pixelbit <= Data_rom[7];
        1: pixelbit <= Data_rom[6];
        2: pixelbit <= Data_rom[5];
        3: pixelbit <= Data_rom[4];
        4: pixelbit <= Data_rom[3];
        5: pixelbit <= Data_rom[2];
        6: pixelbit <= Data_rom[1];
        7: pixelbit <= Data_rom[0];
        default:pixelbit<=0;
      endcase
      end
    //del registro al bit de salida final
    always @(posedge clk)
    if(reset)
        letter_rgb<=12'hfff;
    else begin
        if (pixelbit)
          letter_rgb <= 12'h0ff;
        else
          letter_rgb <= 12'h000;end
    //--------------------------------------------
      //*********logica para SALIDA, aqui se multiplexa*******
    //------------------------------------------------------

reg [11:0]rgbtext1;
always@(posedge clk)
  if(~video_on)
        rgbtext1<=12'hfff;
   else begin
          if (barrafecha | ruedaon1)
              rgbtext1 <= letter_rgb;
          else
              rgbtext1<=0;
        end
  assign rgbtext=rgbtext1;
endmodule
