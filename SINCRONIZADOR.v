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
//
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
	
	reg [2:0]modo4reg;	//contadores necesarios para realizar la 'division' de frecuencia a 25MHz, habilitadores de conteo
	wire [2:0]mode4next;
	
	reg [9:0] h_contador_reg, h_contador_siguiente; //contador horizontal
	reg [9:0] v_contador_reg, v_contador_siguiente;	//contador vertical
	//buffers para evitar algun tipo de glitch a la salida
	reg v_sync_reg,h_sync_reg;
	wire v_sync_next, h_sync_next;
	
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
			
			
	always @(posedge clk,posedge reset)
			if(reset)
				modo4reg<=0;
			else
				modo4reg<=modo4reg+1;		
	
	assign modo2_siguiente=~modo2_reg; 
	reg enable;
	reg enable2;
	wire enable2tick;
	assign enable2tick=enable2;
	assign pixel_tick=enable;
	
	
	always@(posedge clk) begin
		enable<=modo4reg[1];
		enable2<=modo4reg[0];
		end

	
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
