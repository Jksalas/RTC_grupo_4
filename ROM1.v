`timescale 1ns / 1ps
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    00:49:43 09/18/2016
// Design Name:
// Module Name:    ROM1
// Project Name:
// Target Devices:
// Tool versions:
// Description: memoria que contiene los caracteres a imprimir
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
module ROM1(
input wire [1:0]AD,
input wire [3:0]lsby,
output reg [7:0]data,
input wire [3:0] sel_caracter
);

reg [7:0]adress;

assign adress1=adress;

always @*
adress <= {AD,lsby};

always @*
//LETRAS
if (sel_caracter==1) begin
	case (adress)
		6'h10: data = 8'b00000000;  //la F
		6'h11: data = 8'b00111110;
		6'h12: data = 8'b01000000;
		6'h13: data = 8'b01000000;
		6'h14: data = 8'b01000000;
		6'h15: data = 8'b01000000;
		6'h16: data = 8'b01000000;
		6'h17: data = 8'b00111110;
		6'h18: data = 8'b01000000;
		6'h19: data = 8'b01000000;
		6'h1a: data = 8'b01000000;
		6'h1b: data = 8'b01000000;
		6'h1c: data = 8'b01000000;
		6'h1d: data = 8'b01000000;
		6'h1e: data = 8'b00000000;
		6'h1f: data = 8'b00000000;



		6'h20: data = 8'b00000000;//E
		6'h21: data = 8'b00111110;
		6'h22: data = 8'b01000000;
		6'h23: data = 8'b01000000;
		6'h24: data = 8'b01000000;
		6'h25: data = 8'b01000000;
		6'h26: data = 8'b01000000;
		6'h27: data = 8'b00111110;
		6'h28: data = 8'b01000000;
		6'h29: data = 8'b01000000;
		6'h2a: data = 8'b01000000;
		6'h2b: data = 8'b01000000;
		6'h2c: data = 8'b01000000;
		6'h2d: data = 8'b00111110;
		6'h2e: data = 8'b00000000;
		6'h2f: data = 8'b00000000;

		6'h30: data = 8'b00000000;//C
		6'h31: data = 8'b00111110;
		6'h32: data = 8'b01000000;
		6'h33: data = 8'b01000000;
		6'h34: data = 8'b01000000;
		6'h35: data = 8'b01000000;
		6'h36: data = 8'b01000000;
		6'h37: data = 8'b01000000;
		6'h38: data = 8'b01000000;
		6'h39: data = 8'b01000000;
		6'h3a: data = 8'b01000000;
		6'h3b: data = 8'b01000000;
		6'h3c: data = 8'b01000000;
		6'h3d: data = 8'b00111110;
		6'h3e: data = 8'b00000000;
		6'h3f: data = 8'b00000000;
	default : data = 8'b00000000;
	endcase
	end

else if(sel_caracter==2)begin
	case (adress)

		6'h00: data = 8'b00000000;//H
		6'h01: data = 8'b01000010;
		6'h02: data = 8'b01000010;
		6'h03: data = 8'b01000010;
		6'h04: data = 8'b01000010;
		6'h05: data = 8'b01000010;
		6'h06: data = 8'b01000010;
		6'h07: data = 8'b00111100;
		6'h08: data = 8'b01000010;
		6'h09: data = 8'b01000010;
		6'h0a: data = 8'b01000010;
		6'h0b: data = 8'b01000010;
		6'h0c: data = 8'b01000010;
		6'h0d: data = 8'b01000010;
		6'h0e: data = 8'b00000000;
		6'h0f: data = 8'b00000000;


		6'h10: data = 8'b00000000;//A
		6'h11: data = 8'b00111100;
		6'h12: data = 8'b01000010;
		6'h13: data = 8'b01000010;
		6'h14: data = 8'b01000010;
		6'h15: data = 8'b01000010;
		6'h16: data = 8'b01000010;
		6'h17: data = 8'b01111110;
		6'h18: data = 8'b01000010;
		6'h19: data = 8'b01000010;
		6'h1a: data = 8'b01000010;
		6'h1b: data = 8'b01000010;
		6'h1c: data = 8'b01000010;
		6'h1d: data = 8'b01000010;
		6'h1e: data = 8'b00000000;
		6'h1f: data = 8'b00000000;



		6'h20: data = 8'b00000000;//T
		6'h21: data = 8'b01111110;
		6'h22: data = 8'b00010000;
		6'h23: data = 8'b00010000;
		6'h24: data = 8'b00010000;
		6'h25: data = 8'b00010000;
		6'h26: data = 8'b00010000;
		6'h27: data = 8'b00010000;
		6'h28: data = 8'b00010000;
		6'h29: data = 8'b00010000;
		6'h2a: data = 8'b00010000;
		6'h2b: data = 8'b00010000;
		6'h2c: data = 8'b00010000;
		6'h2d: data = 8'b00010000;
		6'h2e: data = 8'b00000000;
		6'h2f: data = 8'b00000000;


		6'h30: data = 8'b00000000;//I
		6'h31: data = 8'b01111110;
		6'h32: data = 8'b00010000;
		6'h33: data = 8'b00010000;
		6'h34: data = 8'b00010000;
		6'h35: data = 8'b00010000;
		6'h36: data = 8'b00010000;
		6'h37: data = 8'b00010000;
		6'h38: data = 8'b00010000;
		6'h39: data = 8'b00010000;
		6'h3a: data = 8'b00010000;
		6'h3b: data = 8'b00010000;
		6'h3c: data = 8'b00010000;
		6'h3d: data = 8'b01111110;
		6'h3e: data = 8'b00000000;
		6'h3f: data = 8'b00000000;

		default : data = 8'b00000000;
		endcase

	end


else if (sel_caracter==3) begin
	case (adress)
		6'h30: data = 8'b00000000;//R
		6'h31: data = 8'b00111100;
		6'h32: data = 8'b01000010;
		6'h33: data = 8'b01000010;
		6'h34: data = 8'b01000010;
		6'h35: data = 8'b01000010;
		6'h36: data = 8'b01000010;
		6'h37: data = 8'b00111100;
		6'h38: data = 8'b01001100;
		6'h39: data = 8'b01000110;
		6'h3a: data = 8'b01000010;
		6'h3b: data = 8'b01000010;
		6'h3c: data = 8'b01000010;
		6'h3d: data = 8'b01000010;
		6'h3e: data = 8'b00000000;
		6'h3f: data = 8'b00000000;


		6'h10: data = 8'b00000000;//O
		6'h11: data = 8'b01111110;
		6'h12: data = 8'b01000010;
		6'h13: data = 8'b01000010;
		6'h14: data = 8'b01000010;
		6'h15: data = 8'b01000010;
		6'h16: data = 8'b01000010;
		6'h17: data = 8'b01000010;
		6'h18: data = 8'b01000010;
		6'h19: data = 8'b01000010;
		6'h1a: data = 8'b01000010;
		6'h1b: data = 8'b01000010;
		6'h1c: data = 8'b01000010;
		6'h1d: data = 8'b01111110;
		6'h1e: data = 8'b00000000;
		6'h1f: data = 8'b00000000;

		6'h20: data = 8'b00000000;//M
		6'h21: data = 8'b01000010;
		6'h22: data = 8'b01100110;
		6'h23: data = 8'b01011010;
		6'h24: data = 8'b01011010;
		6'h25: data = 8'b01000010;
		6'h26: data = 8'b01000010;
		6'h27: data = 8'b01000010;
		6'h28: data = 8'b01000010;
		6'h29: data = 8'b01000010;
		6'h2a: data = 8'b01000010;
		6'h2b: data = 8'b01000010;
		6'h2c: data = 8'b01000010;
		6'h2d: data = 8'b01000010;
		6'h2e: data = 8'b00000000;
		6'h2f: data = 8'b00000000;

		6'h00: data = 8'b00000100;//BARRA PARA DIVIDIR FECHA
		6'h01: data = 8'b00000100;
		6'h02: data = 8'b00001100;
		6'h03: data = 8'b00001000;
		6'h04: data = 8'b00001000;
		6'h05: data = 8'b00011000;
		6'h06: data = 8'b00010000;
		6'h07: data = 8'b00010000;
		6'h08: data = 8'b00110000;
		6'h09: data = 8'b00100000;
		6'h0a: data = 8'b00100000;
		6'h0b: data = 8'b01100000;
		6'h0c: data = 8'b01100000;
		6'h0d: data = 8'b01000000;
		6'h0e: data = 8'b01000000;
		6'h0f: data = 8'b01000000;

		default : data = 8'b00000000;
		endcase

		end
//NUMEROS

else if(sel_caracter==4)begin
	case (adress)

		6'h00: data = 8'b00000000;//0
		6'h01: data = 8'b00111100;
		6'h02: data = 8'b01000010;
		6'h03: data = 8'b01000010;
		6'h04: data = 8'b01000010;
		6'h05: data = 8'b01000010;
		6'h06: data = 8'b01000010;
		6'h07: data = 8'b01000010;
		6'h08: data = 8'b01000010;
		6'h09: data = 8'b01000010;
		6'h0a: data = 8'b01000010;
		6'h0b: data = 8'b01000010;
		6'h0c: data = 8'b01000010;
		6'h0d: data = 8'b00111100;
		6'h0e: data = 8'b00000000;
		6'h0f: data = 8'b00000000;


		6'h10: data = 8'b00000000;//1
		6'h11: data = 8'b00010000;
		6'h12: data = 8'b00010000;
		6'h13: data = 8'b00010000;
		6'h14: data = 8'b00010000;
		6'h15: data = 8'b00010000;
		6'h16: data = 8'b00010000;
		6'h17: data = 8'b00010000;
		6'h18: data = 8'b00010000;
		6'h19: data = 8'b00010000;
		6'h1a: data = 8'b00010000;
		6'h1b: data = 8'b00010000;
		6'h1c: data = 8'b00010000;
		6'h1d: data = 8'b00010000;
		6'h1e: data = 8'b00000000;
		6'h1f: data = 8'b00000000;



		6'h20: data = 8'b00000000;//2
		6'h21: data = 8'b01111100;
		6'h22: data = 8'b00000010;
		6'h23: data = 8'b00000010;
		6'h24: data = 8'b00000010;
		6'h25: data = 8'b00000010;
		6'h26: data = 8'b00000010;
		6'h27: data = 8'b00111100;
		6'h28: data = 8'b01000000;
		6'h29: data = 8'b01000000;
		6'h2a: data = 8'b01000000;
		6'h2b: data = 8'b01000000;
		6'h2c: data = 8'b01000000;
		6'h2d: data = 8'b00111110;
		6'h2e: data = 8'b00000000;
		6'h2f: data = 8'b00000000;


		6'h30: data = 8'b00000000;//3
		6'h31: data = 8'b01111100;
		6'h32: data = 8'b00000010;
		6'h33: data = 8'b00000010;
		6'h34: data = 8'b00000010;
		6'h35: data = 8'b00000010;
		6'h36: data = 8'b00000010;
		6'h37: data = 8'b01111100;
		6'h38: data = 8'b00000010;
		6'h39: data = 8'b00000010;
		6'h3a: data = 8'b00000010;
		6'h3b: data = 8'b00000010;
		6'h3c: data = 8'b00000010;
		6'h3d: data = 8'b01111100;
		6'h3e: data = 8'b00000000;
		6'h3f: data = 8'b00000000;

		default : data = 8'b00000000;
		endcase

	end


else if(sel_caracter==5)begin
	case (adress)

		6'h00: data = 8'b00000000;//4
		6'h01: data = 8'b01000010;
		6'h02: data = 8'b01000010;
		6'h03: data = 8'b01000010;
		6'h04: data = 8'b01000010;
		6'h05: data = 8'b01000010;
		6'h06: data = 8'b01000010;
		6'h07: data = 8'b00111100;
		6'h08: data = 8'b00000010;
		6'h09: data = 8'b00000010;
		6'h0a: data = 8'b00000010;
		6'h0b: data = 8'b00000010;
		6'h0c: data = 8'b00000010;
		6'h0d: data = 8'b00000010;
		6'h0e: data = 8'b00000000;
		6'h0f: data = 8'b00000000;


		6'h10: data = 8'b00000000;//5
		6'h11: data = 8'b00111110;
		6'h12: data = 8'b01000000;
		6'h13: data = 8'b01000000;
		6'h14: data = 8'b01000000;
		6'h15: data = 8'b01000000;
		6'h16: data = 8'b01000000;
		6'h17: data = 8'b00111100;
		6'h18: data = 8'b00000010;
		6'h19: data = 8'b00000010;
		6'h1a: data = 8'b00000010;
		6'h1b: data = 8'b00000010;
		6'h1c: data = 8'b00000010;
		6'h1d: data = 8'b01111100;
		6'h1e: data = 8'b00000000;
		6'h1f: data = 8'b00000000;



		6'h20: data = 8'b00000000;//6
		6'h21: data = 8'b00111110;
		6'h22: data = 8'b01000000;
		6'h23: data = 8'b01000000;
		6'h24: data = 8'b01000000;
		6'h25: data = 8'b01000000;
		6'h26: data = 8'b01000000;
		6'h27: data = 8'b00111100;
		6'h28: data = 8'b01000010;
		6'h29: data = 8'b01000010;
		6'h2a: data = 8'b01000010;
		6'h2b: data = 8'b01000010;
		6'h2c: data = 8'b01000010;
		6'h2d: data = 8'b00111100;
		6'h2e: data = 8'b00000000;
		6'h2f: data = 8'b00000000;


		6'h30: data = 8'b00000000;//7
		6'h31: data = 8'b01111100;
		6'h32: data = 8'b00000010;
		6'h33: data = 8'b00000010;
		6'h34: data = 8'b00000010;
		6'h35: data = 8'b00000010;
		6'h36: data = 8'b00000010;
		6'h37: data = 8'b00000010;
		6'h38: data = 8'b00000010;
		6'h39: data = 8'b00000010;
		6'h3a: data = 8'b00000010;
		6'h3b: data = 8'b00000010;
		6'h3c: data = 8'b00000010;
		6'h3d: data = 8'b00000010;
		6'h3e: data = 8'b00000000;
		6'h3f: data = 8'b00000000;

		default : data = 8'b00000000;
		endcase

	end

else if(sel_caracter==6)begin
	case (adress)

		6'h00: data = 8'b00000000;//8
		6'h01: data = 8'b00111100;
		6'h02: data = 8'b01000010;
		6'h03: data = 8'b01000010;
		6'h04: data = 8'b01000010;
		6'h05: data = 8'b01000010;
		6'h06: data = 8'b01000010;
		6'h07: data = 8'b00111100;
		6'h08: data = 8'b01000010;
		6'h09: data = 8'b01000010;
		6'h0a: data = 8'b01000010;
		6'h0b: data = 8'b01000010;
		6'h0c: data = 8'b01000010;
		6'h0d: data = 8'b00111100;
		6'h0e: data = 8'b00000000;
		6'h0f: data = 8'b00000000;


		6'h10: data = 8'b00000000;//9
		6'h11: data = 8'b00111100;
		6'h12: data = 8'b01000010;
		6'h13: data = 8'b01000010;
		6'h14: data = 8'b01000010;
		6'h15: data = 8'b01000010;
		6'h16: data = 8'b01000010;
		6'h17: data = 8'b00111100;
		6'h18: data = 8'b00000010;
		6'h19: data = 8'b00000010;
		6'h1a: data = 8'b00000010;
		6'h1b: data = 8'b00000010;
		6'h1c: data = 8'b00000010;
		6'h1d: data = 8'b00000010;
		6'h1e: data = 8'b00000000;
		6'h1f: data = 8'b00000000;


		6'h20: data = 8'b00000000;// puntos para separaracion
		6'h21: data = 8'b00000000;
		6'h22: data = 8'b00000000;
		6'h23: data = 8'b00000000;
		6'h24: data = 8'b00000000;
		6'h25: data = 8'b00110000;
		6'h26: data = 8'b00000000;
		6'h27: data = 8'b00000000;
		6'h28: data = 8'b00000000;
		6'h29: data = 8'b00000000;
		6'h2a: data = 8'b00000000;
		6'h2b: data = 8'b00110000;
		6'h2c: data = 8'b00000000;
		6'h2d: data = 8'b00000000;
		6'h2e: data = 8'b00000000;
		6'h2f: data = 8'b00000000;

		6'h30: data = 8'b00000000;// RING !!!
		6'h31: data = 8'b00000000;
		6'h32: data = 8'b00000000;
		6'h33: data = 8'b00000000;
		6'h34: data = 8'b00000000;
		6'h35: data = 8'b10010010;
		6'h36: data = 8'b10010010;
		6'h37: data = 8'b10010010;
		6'h38: data = 8'b00000000;
		6'h39: data = 8'b10010010;
		6'h3a: data = 8'b00000000;
		6'h3b: data = 8'b00000000;
		6'h3c: data = 8'b00000000;
		6'h3d: data = 8'b00000000;
		6'h3e: data = 8'b00000000;
		6'h3f: data = 8'b00000000;




		default : data = 8'b00000000;
		endcase

	end
//PARA EL RING

else if(sel_caracter==7)begin
	case (adress)

		6'h00: data = 8'b00000000;//BOLA PARA RING
		6'h01: data = 8'b00000000;
		6'h02: data = 8'b00000000;
		6'h03: data = 8'b00000000;
		6'h04: data = 8'b00111000;
		6'h05: data = 8'b01111100;
		6'h06: data = 8'b11111110;
		6'h07: data = 8'b11111110;
		6'h08: data = 8'b11111110;
		6'h09: data = 8'b01111100;
		6'h0a: data = 8'b00111000;
		6'h0b: data = 8'b00000000;
		6'h0c: data = 8'b00000000;
		6'h0d: data = 8'b00000000;
		6'h0e: data = 8'b00000000;
		6'h0f: data = 8'b00000000;







		default : data = 8'b00000000;
		endcase

	end


endmodule
