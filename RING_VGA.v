`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    22:15:12 09/19/2016
// Design Name:
// Module Name:    RING
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
//HECHO ṔOR: Joao Salas Ramirez
//////////////////////////////////////////////////////////////////////////////////
module RING(
	 input activar_alarma,
    input okmaquina,
    input [9:0] pix_y, pix_x,
    input wire video_on,
    input clk,reset,
    output wire [11:0] rgbtext
  );
  //SECCION GENERADOR DE numeros EN LA PANTALLA


	// CONSTANTES Y DECLARACIONES
  reg pixelbit;
	wire [2:0] lsbx;
	wire [3:0] lsby;
	reg [2:0] lsbx_reg;
	reg [3:0] lsby_reg;

  assign lsbx= lsbx_reg;
  assign lsby=lsby_reg;


	reg [3:0] sel_car;
	reg [11:0] letter_rgb;

	wire [7:0] Data;
	reg [1:0] AD;


	// limites de la pantalla


ROM FONT(reset,AD,lsby,Data,sel_car);//se instancia la ROM


//variables de activacion
	wire on_ring;
  wire bola_ring;

// ACTIVADORES DE numeros

//numeros de hora 32x128
	assign on_ring =(608<=pix_x) && (pix_x<=623) &&(320<=pix_y) && (pix_y<=383);
  assign bola_ring =(576<=pix_x) && (pix_x<=607) &&(320<=pix_y) && (pix_y<=383);

//deteccion y generacion de la señal para la direccion de la ROM
parameter h1=0,h2=1;
reg state;


always @(posedge clk) begin
	if(reset) begin
    		AD<=0;
    		sel_car<=0;

    		lsby_reg<=0;
    		lsbx_reg<=0;

	      end

	else if(okmaquina && activar_alarma) begin
      case(state)
      h1: begin
    		if (on_ring) begin
    			AD <= 2'h3;  //primeros 6 numeros
    			sel_car<=6;
    			lsby_reg<= pix_y[5:2];lsbx_reg<= pix_x[3:1];
          state<=h1;
    			end
        else if(~on_ring)
            state<=h2;
      end
        h2: begin
         if (bola_ring) begin
        			AD <= 2'h0;  //primeros 6 numeros
        			sel_car<=7;
        			lsby_reg<= pix_y[5:2];lsbx_reg<= pix_x[4:2];
              state<=h2;
        			end
          else if (~bola_ring)
            state<=h1;
        end

        default:  begin state<=h1;AD <= 2'h3;  //primeros 6 numeros
        			sel_car<=15;end
      endcase
	end
	else begin
    		AD<=1;
    		sel_car<=15;

    		lsby_reg<=0;
    		lsbx_reg<=0;

	      end

end



//CARGA DE DATOS DE LA ROM AL BIT DE SALIDA
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

//del registro al bit de salida final
always @(posedge clk)
  if(reset)
      letter_rgb<=12'hfff;
  else begin
		  if (pixelbit)
			   letter_rgb <= 12'hf00;  //morado claro
		  else
			    letter_rgb <= 0;end    //morado oscuro
//--------------------------------------------
//*********logica para SALIDA, aqui se multiplexa*******
//------------------------------------------------------
reg [11:0] rgbtext1;
always@(posedge clk)
		if(~video_on)
			rgbtext1<=12'hfff;
		else begin
  		if (on_ring|bola_ring)
  				rgbtext1 <= letter_rgb;
  		else
  				rgbtext1<=0;
		end
  assign rgbtext=rgbtext1;

endmodule
