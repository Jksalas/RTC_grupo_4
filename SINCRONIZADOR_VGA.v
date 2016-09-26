`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:46:46 09/14/2016 
// Design Name: 
// Module Name:    SINCRONIZADOR 
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
//Sincronizador para generar vsync y hsync a 25MHz a partir de un clock de 100MHz
module SINCRONIZADOR( 
	input wire clk, reset, //entradas del sincronizador
	output wire hsync, vsync, video_activado, instante_pulso, //salidas del sincronizador
	output wire [9:0] pixel_x, pixel_y //senales de coordenadas
   );
	//parametros de sincronizacion horizontal
	localparam Horizontal_Display = 640; 
	localparam Horizontal_front_border=48; //front porch
	localparam Horizontal_back_border=16; //back porch
	localparam Hor_retrace=96; //pulso bajo
	//parametros de sincronizacion vertical
	localparam Ver_Display = 480; 
	localparam Ver_left_border= 10; //front porch
	localparam Ver_right_border=30; //back porch
	localparam Ver_retrace= 2; //pulso bajo
	
	reg modo2_reg; //contadores necesarios para realizar la 'division' de frecuencia, habilitadores de conteo
	wire modo2_siguiente;
	
	
	
	reg [9:0] h_contador_reg, h_contador_siguiente; //contador horizontal
	reg [9:0] v_module SIMBOLOS(
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
    always @*
    if(reset)
        letter_rgb<=0;
    else begin
        if (pixelbit)
          letter_rgb <= 12'h0ff;
        else
          letter_rgb <= 0;end
    //--------------------------------------------
      //*********logica para SALIDA, aqui se multiplexa*******
    //------------------------------------------------------

reg [11:0]rgbtext1;
always@*
  if(~video_on)
        rgbtext1<=0;
   else begin
          if (barrafecha | ruedaon1)
              rgbtext1 <= letter_rgb;
          else
              rgbtext1<=0;
        end
  assign rgbtext=rgbtext1;
endmodule
	wire h_final,v_final,pixel_tick; //senales para estado del recorrido
	
	
	//logica secuencial
	always @(posedge clk, posedge reset)  //en los flancos positivos de reloj y reset
		if (reset)
			begin
			modo2_reg <=1'b0; //todas la senales en 0 al darse un reset
			v_contador_reg <= 0;
			h_contador_reg <= 0;
			v_sync_reg <= 1'b0;
			h_sync_reg <= 1'b0;
			end
		else
			begin //asignaciones de los valores anteriores a la senales siguientes de los registros cada flanco positivo de reloj
			modo2_reg <= modo2_siguiente;
			v_contador_reg <= v_contador_siguiente;
			h_contador_reg <= h_contador_siguiente;
			v_sync_reg <= v_sync_next ;
			h_sync_reg <= h_sync_next;
			end
			
	reg [1:0]modo4reg;	//contadores necesarios para realizar la 'division' de frecuencia a 25MHz, habilitadores de conteo
	wire [1:0]mode4next;
	
	always @(posedge clk,posedge reset)
			if(reset)
				modo4reg<=0;
			else
				modo4reg<=modo4reg+1;		
	
	assign modo2_siguiente=~modo2_reg; 
	wire enable;
	wire enable2;
	wire enable2tick;
	
	assign enable2tick=enable2;
	assign pixel_tick=enable;
	assign enable=modo4reg[1];
	assign enable2=modo4reg[0];
	
	
	
	assign h_final=(h_contador_reg==(Hor_retrace+Horizontal_Display+Horizontal_front_border+Horizontal_back_border-1));
	assign v_final=(v_contador_reg==(Ver_left_border+Ver_right_border+Ver_retrace+Ver_Display-1));

//logica para generar los conteos
	always@* //horizontaless
		if (pixel_tick & enable2tick) //cuenta solo en el pulso de habilitacion
			if(h_final) 
				h_contador_siguiente=0;
			else
				h_contador_siguiente=h_contador_reg+1;
		else
			h_contador_siguiente=h_contador_reg;
	
	//verticales
	always@*
		if ((pixel_tick) & (enable2tick) & (h_final)) //cuenta solo si se da el pulso de habilitacion
			if(v_final)
				v_contador_siguiente=0;
			else
				v_contador_siguiente= v_contador_reg+1;
		else
			v_contador_siguiente=v_contador_reg;
			
			
			
	
			
	//buffers para evitar fallas, recomendacion de Pong Chu
	assign h_sync_next=(h_contador_reg>=(Horizontal_Display+Horizontal_back_border) && h_contador_reg<=(Horizontal_Display+Horizontal_back_border+Hor_retrace-1));
	assign v_sync_next=(v_contador_reg>=(Ver_Display+Ver_right_border) && v_contador_reg<=(Ver_Display+Ver_right_border+Ver_retrace-1));
	
	//asignacion a las salidas
	
	assign video_activado=(h_contador_reg<Horizontal_Display) && (v_contador_reg<Ver_Display);
	
	assign hsync= ~h_sync_reg;
	assign vsync= ~v_sync_reg;
	assign pixel_x= h_contador_reg;
	assign pixel_y= v_contador_reg;
	assign instante_pulso=pixel_tick;
	
endmodule
