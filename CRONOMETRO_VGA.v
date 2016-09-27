`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    22:13:30 09/19/2016
// Design Name:
// Module Name:    TIMERNUMBERS
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
//hecho por: JOAO SALAS RAMIREZ
//Este modulo imprime los numeros correspondientes al cronometro
//////////////////////////////////////////////////////////////////////////////////
module TIMERNUMBERS(
      input okmaquina,
      input [9:0] pix_y, pix_x,
      input wire video_on,programar_on,
      input [3:0] direccion_actual_pantalla,
      input clk,reset,
      output [11:0] rgbtext,
      input [7:0] timer_in1,timer_in2,timer_in3

      );

wire enable; //enable para el decodificador
reg enablereg;

assign enable=enablereg;

reg pixelbit;
wire [2:0] lsbx;
wire [3:0] lsby;
reg [2:0] lsbx_reg;
reg [3:0] lsby_reg;

assign lsbx= lsbx_reg;
assign lsby=lsby_reg;

reg [11:0] letter_rgb;

//indicadores que se cayo en la coordenada de impresion

wire timer_1,timer_2,timer_3,timer_4,timer_5,timer_6;
 //NUMEROS PARA CRONOMETRO  64x32
      assign timer_1 =(192<=pix_x) && (pix_x<=223) && (320<=pix_y) && (pix_y<=383);
      assign timer_2 =(224<=pix_x) && (pix_x<=255) &&(320<=pix_y) && (pix_y<=383);

      assign timer_3 =(320<=pix_x) && (pix_x<=351) &&(320<=pix_y) && (pix_y<=383);
      assign timer_4 =(352<=pix_x) && (pix_x<=383) && (320<=pix_y) && (pix_y<=383);

      assign timer_5 =(448<=pix_x) && (pix_x<=479) &&(320<=pix_y) && (pix_y<=383);
      assign timer_6 =(480<=pix_x) && (pix_x<=511) && (320<=pix_y) && (pix_y<=383);

      //logica de salida

//para la rom

wire [7:0] Data_rom;

//para el decodificador
wire [1:0] AD_from_deco;
reg  [3:0] bcd_to_deco;
wire [3:0] sel_car_from_deco; //fila donde esta en el rom

DECODER deco(.enable(enable),
  .bcd_num(bcd_to_deco),
  .address_out_reg(AD_from_deco),
  .sel_address_out_reg(sel_car_from_deco));

ROM FONT(reset,AD_from_deco,lsby,Data_rom,sel_car_from_deco);

parameter  h1=1,h2=2,h3=3,h4=4,h5=5,h6=6;
reg [2:0] estado;


always @(posedge clk) begin

		if(reset) begin
			bcd_to_deco<=0;
			lsby_reg<=0;
			lsbx_reg<=0;
			enablereg<=0;end

		else if(okmaquina) begin
				case(estado)
						h1: begin
								if (timer_1)begin
								      bcd_to_deco<=timer_in1[7:4];
											enablereg<=1;
								      lsby_reg<= pix_y[5:2];lsbx_reg<= pix_x[4:2];
											estado<=h1;
											end
								else if(~timer_1)
										estado<=h2;end
							h2:begin
                  if (timer_2) begin
								      bcd_to_deco<=timer_in1[3:0];enablereg<=1;
								      lsby_reg<= pix_y[5:2];lsbx_reg<= pix_x[4:2];
											estado<=h2;
											end
								else if(~timer_2)
										estado<=h3;end
						h3:begin
								 if (timer_3)begin
								    bcd_to_deco<=timer_in2[7:4];enablereg<=1;
								    lsby_reg<= pix_y[5:2];lsbx_reg<= pix_x[4:2];
										estado<=h3;
										end
							else if(~timer_3)
									estado<=h4;end
						h4:begin
								if (timer_4)begin
								    bcd_to_deco<=timer_in2[3:0];enablereg<=1;
								    lsby_reg<= pix_y[5:2];lsbx_reg<= pix_x[4:2];
										estado<=h4;
										end
							else if(~timer_4)
									estado<=h5;end
						h5:begin
							 if (timer_5)begin
								   bcd_to_deco<=timer_in3[7:4];enablereg<=1;
								   lsby_reg<= pix_y[5:2];lsbx_reg<= pix_x[4:2];
									 estado<=h5;
			 						end
			 			else if(~timer_5)
			 					estado<=h6;end
						h6: begin
								 if (timer_6)begin
								    bcd_to_deco<=timer_in3[3:0];enablereg<=1;
								    lsby_reg<= pix_y[5:2];lsbx_reg<= pix_x[4:2];
										estado<=h6;
									 end
						 else if(~timer_6)
								 estado<=h1;
                 end
						default:  estado<=h1;

					endcase

    end
	 else begin

			bcd_to_deco<=0;
			lsby_reg<=0;
			lsbx_reg<=0;
			enablereg<=0;end
end




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
          parameter progra=0,noprogra=1;
          reg state;

          always @(posedge clk)
          if (reset) begin
              letter_rgb<=0;
              state<=0;
              end
          else begin
              case(state)
                    noprogra: begin
                        if(~programar_on)begin
                                state<=noprogra;
                                if (pixelbit)
                                  letter_rgb <=12'h0ff;
                                else
                                  letter_rgb <= 0; end
                        else if(programar_on)
                            state<=progra;
                    end
                    progra: begin
                        if(programar_on)begin
                              state<=progra;
                              if (pixelbit && (timer_1|timer_2))begin
                                    if(direccion_actual_pantalla==6)
                                        letter_rgb <=12'hf00;
                                    else letter_rgb <=12'h0ff;end
                              else if (pixelbit && (timer_3|timer_4))begin
                                    if(direccion_actual_pantalla==7)
                                        letter_rgb <=12'hf00;
                                    else letter_rgb <=12'h0ff;end
                              else if (pixelbit && (timer_5|timer_6))begin
                                    if(direccion_actual_pantalla==8)
                                        letter_rgb <=12'hf00;
                                    else letter_rgb <=12'h0ff;end
                              else
                                letter_rgb <= 0;
                        end
                        else if(~programar_on)
                              state<=noprogra;
                    end
              endcase
              end
          //--------------------------------------------
            //*********logica para SALIDA, aqui se multiplexa*******
          //------------------------------------------------------
reg [11:0] rgbtext1;

      always@*
        if(~video_on)
              rgbtext1<=0;
          else begin
                if ( timer_1  | timer_2  | timer_3 | timer_4 | timer_5 | timer_6)
                    rgbtext1 <= letter_rgb;
                else
                    rgbtext1<=0;
              end
assign rgbtext=rgbtext1;
endmodule
