`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:00:46 09/10/2016 
// Design Name: 
// Module Name:    Timer 
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



module Timer(clk, rst, tload, tsel, done) ;
//Entradas y Salidas
input clk, rst, tload;
input [1:0] tsel ;
output done;

//Variable de cueta y cuenta siguiente
reg [3:0] count ;
reg [3:0] next_count ;
reg done ;

//Definici�n de cantidad a contas
parameter [3:0] tADs = 4'd3;
parameter [3:0] tACC = 4'd7;
parameter [3:0] tW = 4'd12;



// L�gica de siguiente cuenta
always@(rst or tload or tsel or done or count) begin
casex({rst, tload, tsel, done})
5'b1xxxx: next_count = 4'b0;
5'b0101x: next_count = tADs;
5'b0110x: next_count = tACC;
5'b0111x: next_count = tW;
5'b00xx0: next_count = count - 1'b1;
5'b00xx1: next_count = count;
default: next_count = count;
endcase
end
//Asignaci�n de siguiente cuenta
always @(posedge clk) begin
	 count <= next_count;
end

always @* begin
	done = !(|count) ; //Se�al de cuenta terminada
end
	
endmodule