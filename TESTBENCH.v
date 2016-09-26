`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:34:16 09/22/2016
// Design Name:   VGATOP
// Module Name:   /home/joao/Documents/PROJECTS ISE/proyectosVGAfinales/VGA_END/TESTBENCH.v
// Project Name:  VGA_END
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: VGATOP
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module TESTBENCH;

	// Inputs
	reg activar_alarma;
	reg clk;
	reg reset;
	reg [7:0] timer_in1;
	reg [7:0] timer_in2;
	reg [7:0] timer_in3;
	reg [7:0] hour_in1;
	reg [7:0] hour_in2;
	reg [7:0] hour_in3;
	reg [7:0] fecha_in1;
	reg [7:0] fecha_in2;
	reg [7:0] fecha_in3;

	// Outputs
	wire hsync;
	wire vsync;
	wire video_on1;
	wire [11:0] rgb;
	wire [9:0] pixX;
	wire [9:0] pixY;

	// Instantiate the Unit Under Test (UUT)
	VGATOP uut (
	.activar_alarma(activar_alarma),
		.clk(clk),
		.reset(reset),
		.hsync(hsync),
		.vsync(vsync),
		.video_on1(video_on1),
		.rgb(rgb),
		.pixX(pixX),
		.pixY(pixY),
		.timer_in1(timer_in1),
		.timer_in2(timer_in2),
		.timer_in3(timer_in3),
		.hour_in1(hour_in1),
		.hour_in2(hour_in2),
		.hour_in3(hour_in3),
		.fecha_in1(fecha_in1),
		.fecha_in2(fecha_in2),
		.fecha_in3(fecha_in3)
	);

	always #5 clk=~clk;
	integer i;
	integer j;


	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		timer_in1 = 0;
		timer_in2 = 0;
		timer_in3 = 0;
		hour_in1 = 0;
		hour_in2 = 0;
		hour_in3 = 0;
		fecha_in1 = 0;
		fecha_in2 = 0;
		fecha_in3 = 0;

		// Wait 100 ns for global reset to finish
		//PRIMERA PANTALLA
		#100
		reset=1;
		#10
		reset=0;
    #10
		reset = 1;

		//arranca la primer pantalla
		
		#50
		activar_alarma=1;
		reset = 0;
		timer_in1 = 8'b00000111;
		timer_in2 = 8'b00010011;
		timer_in3 = 8'b00010111;
		hour_in1 = 8'b00110011;
		hour_in2 = 8'b00010101;
		hour_in3 = 8'b01100000;
		fecha_in1 = 8'b01100011;
		fecha_in2 = 8'b10010111;
		fecha_in3 = 8'b01000000;
		    //archivo txt para observar los bits, simulando una pantalla
		    i = $fopen("joaoVGA.txt","w");
		    for(j=0;j<383520;j=j+1) begin
		      #40
		      if(video_on1) begin
		        $fwrite(i,"%h",rgb);
		      end
		      else if(pixX==641)
		        $fwrite(i,"\n");
		    end
		    #16800000
		    $fclose(i);
		   // $stop;
				#100
				//SEGUNDA PANTALLA
				reset=1;
		#10
		reset=0;
				activar_alarma=0;
				reset = 0;
				timer_in1 = 8'b00000001;
				timer_in2 = 8'b00010001;
				timer_in3 = 8'b00010011;
				hour_in1 = 8'b00110111;
				hour_in2 = 8'b00010001;
				hour_in3 = 8'b00100000;
				fecha_in1 = 8'b01000011;
				fecha_in2 = 8'b10010111;
				fecha_in3 = 8'b00000000;

				//archivo txt para observar los bits, simulando una pantalla

				i = $fopen("joaoVGA2.txt","w");
				for(j=0;j<383520;j=j+1) begin
					#40
					if(video_on1) begin
						$fwrite(i,"%h",rgb);
					end
					else if(pixX==641)
						$fwrite(i,"\n");
				end


				#16800000


				$fclose(i);
			//	$stop;
				#100
				reset=1;
		#10
		reset=0;
				
				
				//tercera pantalla
				activar_alarma=1;
				reset = 0;
				timer_in1 = 8'b01100101;
				timer_in2 = 8'b00010101;
				timer_in3 = 8'b0110011;
				hour_in1 = 8'b00110111;
				hour_in2 = 8'b00010001;
				hour_in3 = 8'b00100110;
				fecha_in1 = 8'b01000011;
				fecha_in2 = 8'b10010111;
				fecha_in3 = 8'b00100011;

				//archivo txt para observar los bits, simulando una pantalla

				i = $fopen("joaoVGA3.txt","w");
				for(j=0;j<383520;j=j+1) begin
					#40
					if(video_on1) begin
						$fwrite(i,"%h",rgb);
					end
					else if(pixX==641)
						$fwrite(i,"\n");
				end


				#16800000
				reset=0;
				$fclose(i);
				$stop;
		end




endmodule
