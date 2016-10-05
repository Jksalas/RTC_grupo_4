`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:57:14 09/10/2016 
// Design Name: 
// Module Name:    ReadCycle 
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


module ReadCycle(clk, rst, in, ad_mux, read_end, state, AD, CS, RD, WR, TS, reg_enable) ;
//Declaracion de entradas y salidas
	input clk, in, rst ; 
	output AD, CS, RD, WR, TS, ad_mux, read_end, reg_enable;
	output[2:0] state; 
	
	reg [2:0] next_state, state ; 
	reg [1:0] tsel ;//Selecciona valor de cuenta
	reg tload, reg_enable, read_end, AD, CS, RD, WR, TS, ad_mux;
	wire timer_end; //Cuenta terminada
	
parameter [2:0] R0 = 3'b000; //Hold State/ Espera se�al de la master
parameter [2:0] R1 = 3'b001; //Waits tADs Adress mode
parameter [2:0] R2 = 3'b010; //Waits tACC/tCS y Adress Detectda
parameter [2:0] R3 = 3'b011; //Waits tADt 
parameter [2:0] R4 = 3'b100; //Waits tW Para realizar otro proceso
parameter [2:0] R5 = 3'b101; //tCS y Data detectada
parameter [2:0] R6 = 3'b110; //Waits tw
parameter [2:0] R7 = 3'b111; //Salida y retorno
	
	
//Instancia el timer
Timer ReadTimer(clk, rst, tload, tsel, timer_end) ;
// L�gica de estado siguiente y salidas/control del timer
	always @(state or in or timer_end) begin
		case(state)
			R0: {tload, tsel, next_state} = {1'b1, 2'b10, in ? R1 : R0 } ;
			R1: {tload, tsel, next_state} = {1'b1, 2'b10, R2 } ;
			R2: {tload, tsel, next_state} = {timer_end, 2'b01, timer_end ? R3 : R2 } ;
			R3: {tload, tsel, next_state} = {timer_end, 2'b11, timer_end ? R4 : R3 } ;
			R4: {tload, tsel, next_state} = {timer_end, 2'b10, timer_end ? R5 : R4 } ;
			R5: {tload, tsel, next_state} = {timer_end, 2'b11, timer_end ? R6 : R5 } ;
			R6: {tload, tsel, next_state} = {timer_end, 2'b00, timer_end ? R7 : R6 } ;
			R7: {tload, tsel, next_state} = {1'b1, 2'b00, R0 } ;
			default: {tload, tsel, next_state} = {1'b0, 2'b00, R0 } ;
		endcase
	end
	//L�gica de salidas
	always @(state or in or timer_end) begin
		case(state)
			R0: {AD, CS, RD, WR, ad_mux, read_end, TS, reg_enable} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0 } ;
			R1: {AD, CS, RD, WR, ad_mux, read_end, TS, reg_enable} = {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0 } ;
			R2: {AD, CS, RD, WR, ad_mux, read_end, TS, reg_enable} = {1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0 } ;
			R3: {AD, CS, RD, WR, ad_mux, read_end, TS, reg_enable} = {1'b0, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0 } ;
			R4: {AD, CS, RD, WR, ad_mux, read_end, TS, reg_enable} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0 } ;
			R5: {AD, CS, RD, WR, ad_mux, read_end, TS, reg_enable} = {1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1 } ;
			R6: {AD, CS, RD, WR, ad_mux, read_end, TS, reg_enable} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0 } ;
			R7: {AD, CS, RD, WR, ad_mux, read_end, TS, reg_enable} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0 } ;
			default: {AD, CS, RD, WR, ad_mux, read_end, TS, reg_enable} = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b0 } ;
		endcase
	end
	//Siguiente estado
	always @(posedge clk, posedge rst) begin
		if (rst) begin
		state <= R0;
		end
		else begin
		state <= next_state;
		end
	end
	
endmodule
