`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:03:53 09/13/2016 
// Design Name: 
// Module Name:    WriteCycle 
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

module WriteCycle(clk, rst, in, ad_mux, write_end, state, AD, CS, RD, WR, TS) ;
//Declaracion de entradas  salidas
	input clk, in, rst ; 
	output AD, CS, RD, WR, TS, ad_mux, write_end; 
	output[2:0] state; 
	
	reg [2:0] next_state, state ; 
	reg [1:0] tsel ; //Selecciona valor de cuenta
	reg tload, write_end, AD, CS, RD, WR, TS, ad_mux;
	wire timer_end; //Termina la cuenta
	
parameter [2:0] W0 = 3'b000; //Hold State/ Espera señal de la master
parameter [2:0] W1 = 3'b001; //Waits tADs Adress mode
parameter [2:0] W2 = 3'b010; //Waits tACC/tCS y Adress Detectda
parameter [2:0] W3 = 3'b011; //Waits tADt 
parameter [2:0] W4 = 3'b100; //Waits tW Para realizar otro proceso
parameter [2:0] W5 = 3'b101; //tCS y Data detectada
parameter [2:0] W6 = 3'b110; //Salida y retorno
	
	
// Instanciar el timer
Timer WriteTimer(clk, rst, tload, tsel, timer_end) ;
// Lógica de siguiente estado y salidas  al timer
	always @(state or in or timer_end) begin
		case(state)
			W0: {tload, tsel, next_state} = {1'b1, 2'b10, in ? W1 : W0} ;
			W1: {tload, tsel, next_state} = {1'b1, 2'b10, W2 } ;
			W2: {tload, tsel, next_state} = {timer_end, 2'b01, timer_end ? W3 : W2 } ;
			W3: {tload, tsel, next_state} = {timer_end, 2'b11, timer_end ? W4 : W3 } ;
			W4: {tload, tsel, next_state} = {timer_end, 2'b10, timer_end ? W5 : W4 } ;
			W5: {tload, tsel, next_state} = {timer_end, 2'b00, timer_end ? W6 : W5 } ;
			W6: {tload, tsel, next_state} = {1'b1, 2'b00, W0 } ;
			default: {tload, tsel, next_state} = {1'b0, 2'b00, W0 } ;
		endcase
	end
	//Salidas de estado de control RTC y otros
	always @(state or in or timer_end) begin
		TS = 1'b0; 
		case(state)
			W0: {AD, CS, RD, WR, ad_mux, write_end} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0 } ;
			W1: {AD, CS, RD, WR, ad_mux, write_end} = {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0 } ;
			W2: {AD, CS, RD, WR, ad_mux, write_end} = {1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0 } ;
			W3: {AD, CS, RD, WR, ad_mux, write_end} = {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0 } ;
			W4: {AD, CS, RD, WR, ad_mux, write_end} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0 } ;
			W5: {AD, CS, RD, WR, ad_mux, write_end} = {1'b1, 1'b0, 1'b1, 1'b0, 1'b1, 1'b0 } ;
			W6: {AD, CS, RD, WR, ad_mux, write_end} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1 } ;
			default: {AD, CS, RD, WR, ad_mux, write_end} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0 } ;
		endcase
	end
	//Asignación de siguiente estado
	always @(posedge clk) begin
		if (rst) begin
		state <= W0;
		end
		else begin
		state <= next_state;
		end
	end
	
endmodule

