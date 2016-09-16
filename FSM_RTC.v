`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  Laboratorio Sistemas Digitales TEC
// Engineer: Danny Mejías, Joao Salas, Javier Cordero
// 
// Create Date:    15:18:49 09/12/2016 
// Design Name:    Ruta de Control
// Module Name:    FSM_RTC 
// Project Name:   Control RTC
// Target Devices: Nexsys 4
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
module FSM_RTC(
    input wire clock, reset, PFH, PT, doner, donew,
    output wire wrmuxseleco, wino, rino, datatypeo,
	 output wire [7:0]dataio, [7:0]addresso,
	 output wire [1:0] mstate, [3:0] Lstate, [2:0] PFHstate, [2:0] PTstate
    );

wire Endi,Endpfh,Endpt,OK;
	 
//Declaración de Estados Master FSM
localparam [1:0] m0 = 2'b00,
					  m1 = 2'b01,
					  m2 = 2'b10,
					  m3 = 2'b11;

//Declaración de Estados Inicio FSM
localparam [3:0] i0 = 4'b0000,
					  i1 = 4'b0001,
					  i2 = 4'b0010,
					  i3 = 4'b0011,
					  i4 = 4'b0100,
					  i5 = 4'b0101,
					  i6 = 4'b0110,
					  i7 = 4'b0111,
					  i8 = 4'b1000,
					  i9 = 4'b1001,
					  i10 = 4'b1010,
					  i11 = 4'b1011,
					  i12 = 4'b1100,
					  i13 = 4'b1101;
					  
//Declaración de Estados Lectura Standby FSM
localparam [3:0] L0 = 4'b0000,
					  L1 = 4'b0001,
					  L2 = 4'b0010,
					  L3 = 4'b0011,
					  L4 = 4'b0100,
					  L5 = 4'b0101,
					  L6 = 4'b0110,
					  L7 = 4'b0111,
					  L8 = 4'b1000,
					  L9 = 4'b1001,
					  L10 = 4'b1010;
					  
//Declaración de Estados Programar Fecha/Hora FSM
localparam [2:0] PFH0 = 3'b000,
					  PFH1 = 3'b001,
					  PFH2 = 3'b010,
					  PFH3 = 3'b011,
					  PFH4 = 3'b100,
					  PFH5 = 3'b101,
					  PFH6 = 3'b110,
					  PFH7 = 3'b111;	

//Declaración de Estados Programar Temporizador FSM
localparam [2:0] PT0 = 3'b000,
					  PT1 = 3'b001,
					  PT2 = 3'b010,
					  PT3 = 3'b011,
					  PT4 = 3'b100;			  					  
					  
//Declaración de señales
reg [1:0] estado_actual_m , estado_siguiente_m ;
reg [3:0] estado_actual_i , estado_siguiente_i ;
reg [3:0] estado_actual_L , estado_siguiente_L ;
reg [2:0] estado_actual_PFH , estado_siguiente_PFH ;
reg [2:0] estado_actual_PT , estado_siguiente_PT ;

assign mstate = estado_actual_m;
assign Lstate = estado_actual_L;
assign PFHstate = estado_actual_PFH;
assign PTstate = estado_actual_PT;


//Registro de Estados Master FSM 
always @(posedge clock, posedge reset)
	if (reset)
		estado_actual_m <= m0;
	else
		estado_actual_m <= estado_siguiente_m;

//Registro de Estados Inicio FSM
always @(posedge clock, posedge reset)
	if (reset)
		estado_actual_i <= i0;
	else
		estado_actual_i <= estado_siguiente_i;

//Registro de Estados Lectura Standby FSM
always @(posedge clock, posedge reset)
	if (reset)
		estado_actual_L <= L0;
	else
		estado_actual_L <= estado_siguiente_L;
		
//Registro de Estados Programar Fecha/Hora FSM
always @(posedge clock, posedge reset)
	if (reset)
		estado_actual_PFH <= PFH0;
	else
		estado_actual_PFH <= estado_siguiente_PFH;
		
//Registro de Estados Programar Temporizador FSM
always @(posedge clock, posedge reset)
	if (reset)
		estado_actual_PT <= PT0;
	else
		estado_actual_PT <= estado_siguiente_PT;		
		



//Lógica de Estado Siguiente Master FSM
always @*
	case (estado_actual_m)
		m0: if (Endi)
				estado_siguiente_m = m1;
			 else
				estado_siguiente_m = m0;
		m1: if (reset)
				estado_siguiente_m = m0;
			 else
				if (PFH && OK)
					estado_siguiente_m = m2;
				else
					if (PT && OK)
						estado_siguiente_m = m3;
					else
						estado_siguiente_m = m1;
		m2: if (Endpfh)
				estado_siguiente_m = m1;
			 else
				estado_siguiente_m = m2;
		m3: if (Endpt)
				estado_siguiente_m = m1;
			 else
				estado_siguiente_m = m3;
		default : estado_siguiente_m = m1;
	endcase
	
//Lógica de Estado Siguiente Inicio FSM
always @*
	case (estado_actual_i)
		i0: if (estado_actual_m == m0)
				estado_siguiente_i = i1;
			 else
				estado_siguiente_i = i0;
		i1: if (donew)
				estado_siguiente_i = i2;
			 else
				estado_siguiente_i = i1;
		i2: if (donew)
				estado_siguiente_i = i3;
			 else
				estado_siguiente_i = i2;
		i3: if (donew)
				estado_siguiente_i = i4;
			 else
				estado_siguiente_i = i3;
		i4: if (donew)
				estado_siguiente_i = i5;
			 else
				estado_siguiente_i = i4;
		i5: if (donew)
				estado_siguiente_i = i6;
			 else
				estado_siguiente_i = i5;
		i6: if (donew)
				estado_siguiente_i = i7;
			 else
				estado_siguiente_i = i6;
		i7: if (donew)
				estado_siguiente_i = i8;
			 else
				estado_siguiente_i = i7;
		i8: if (donew)
				estado_siguiente_i = i9;
			 else
				estado_siguiente_i = i8;
		i9: if (donew)
				estado_siguiente_i = i10;
			 else
				estado_siguiente_i = i9;
		i10: if (donew)
				estado_siguiente_i = i11;
			 else
				estado_siguiente_i = i10;
		i11: if (donew)
				estado_siguiente_i = i12;
			 else
				estado_siguiente_i = i11;
		i12: if (donew)
				estado_siguiente_i = i13;
			 else
				estado_siguiente_i = i12;
		i13: if (donew)
				estado_siguiente_i = i0;
			 else
				estado_siguiente_i = i13;
		default : estado_siguiente_i = i0;
	endcase


//Lógica de Estado Siguiente Lectura Standby FSM
always @*
	case (estado_actual_L)
		L0: if (estado_actual_m == m1)
				estado_siguiente_L = L1;
			 else
				estado_siguiente_L = L0;
		L1: if (doner)
				estado_siguiente_L = L2;
			 else
				estado_siguiente_L = L1;
		L2: if (doner)
				estado_siguiente_L = L3;
			 else
				estado_siguiente_L = L2;
		L3: if (doner)
				estado_siguiente_L = L4;
			 else
				estado_siguiente_L = L3;
		L4: if (doner)
				estado_siguiente_L = L5;
			 else
				estado_siguiente_L = L4;
		L5: if (doner)
				estado_siguiente_L = L6;
			 else
				estado_siguiente_L = L5;
		L6: if (doner)
				estado_siguiente_L = L7;
			 else
				estado_siguiente_L = L6;
		L7: if (doner)
				estado_siguiente_L = L8;
			 else
				estado_siguiente_L = L7;
		L8: if (doner)
				estado_siguiente_L = L9;
			 else
				estado_siguiente_L = L8;
		L9: if (doner)
				estado_siguiente_L = L10;
			 else
				estado_siguiente_L = L9;
		L10: if (doner)
				estado_siguiente_L = L0;
			 else
				estado_siguiente_L = L10;
		
		default : estado_siguiente_L = L0;
	endcase


//Lógica de Estado Siguiente Programar Fecha/Hora FSM
always @*
	case (estado_actual_PFH)
		PFH0: if (estado_actual_m == m2)
				estado_siguiente_PFH = PFH1;
			 else
				estado_siguiente_PFH = PFH0;
		PFH1: if (donew)
				estado_siguiente_PFH = PFH2;
			 else
				estado_siguiente_PFH = PFH1;
		PFH2: if (donew)
				estado_siguiente_PFH = PFH3;
			 else
				estado_siguiente_PFH = PFH2;
		PFH3: if (donew)
				estado_siguiente_PFH = PFH4;
			 else
				estado_siguiente_PFH = PFH3;
		PFH4: if (donew)
				estado_siguiente_PFH = PFH5;
			 else
				estado_siguiente_PFH = PFH4;
		PFH5: if (donew)
				estado_siguiente_PFH = PFH6;
			 else
				estado_siguiente_PFH = PFH5;
		PFH6: if (donew)
				estado_siguiente_PFH = PFH7;
			 else
				estado_siguiente_PFH = PFH6;
		PFH7: if (donew)
				estado_siguiente_PFH = PFH0;
			 else
				estado_siguiente_PFH = PFH7;
		default : estado_siguiente_PFH = PFH0;
	endcase


//Lógica de Estado Siguiente Programar Temporizador FSM
always @*
	case (estado_actual_PT)
		PT0: if (estado_actual_m == m3)
				estado_siguiente_PT = PT1;
			 else
				estado_siguiente_PT = PT0;
		PT1: if (donew)
				estado_siguiente_PT = PT2;
			 else
				estado_siguiente_PT = PT1;
		PT2: if (donew)
				estado_siguiente_PT = PT3;
			 else
				estado_siguiente_PT = PT2;
		PT3: if (donew)
				estado_siguiente_PT = PT4;
			 else
				estado_siguiente_PT = PT3;
		PT4: if (donew)
				estado_siguiente_PT = PT0;
			 else
				estado_siguiente_PT = PT4;
		default : estado_siguiente_PT = PT0;
	endcase




//-----------GENERADOR DE SALIDAS--------------

reg wrmuxselec;
reg win,rin,datatype;
reg [7:0]datai;
reg [7:0]addri;
reg [7:0]addrL;
reg [7:0]addrPFH;
reg [7:0]addrPT;
reg [7:0]address;

assign wrmuxseleco = wrmuxselec;
assign wino = win;
assign rino = rin;
assign datatypeo = datatype;
assign dataio = datai;
assign addresso = address;

//Transición de estados FSM
assign Endi = (estado_actual_i == i13);
assign Endpfh = (estado_actual_PFH == PFH7);
assign Endpt = (estado_actual_PT == PT4);
assign OK = (estado_actual_L == L10);


//Señal selectora de Mux A/D y Mux VGA
always @(posedge clock)
	case (estado_actual_m)
		m0: wrmuxselec = 1'b1;
		m1: wrmuxselec = 1'b0;
		m2: wrmuxselec = 1'b1;
		m3: wrmuxselec = 1'b1;
		default : wrmuxselec = 1'b0;
	endcase
	
//Señal selectora de Datai o Userdata
always @(posedge clock)
	case (estado_actual_m)
		m0: datatype = 1'b1;
		m1: datatype = 1'b0;
		m2: datatype = 1'b0;
		m3: datatype = 1'b0;
		default : datatype = 1'b1;
	endcase	

//Datos y Direcciones de Inicialización
always @(posedge clock)
	case (estado_actual_i)
		i0: {datai,addri} = {8'h00,8'h00};
		i1: {datai,addri} = {8'h10,8'h02};
		i2: {datai,addri} = {8'h00,8'h02};
		i3: {datai,addri} = {8'h00,8'h20};
		i4: {datai,addri} = {8'h00,8'h21};
		i5: {datai,addri} = {8'h00,8'h22};
		i6: {datai,addri} = {8'h00,8'h23};
		i7: {datai,addri} = {8'h00,8'h24};
		i8: {datai,addri} = {8'h00,8'h25};
		i9: {datai,addri} = {8'h00,8'h26};
		i10:{datai,addri} = {8'h00,8'h27};
		i11:{datai,addri} = {8'h00,8'h28};
		i12:{datai,addri} = {8'hF2,8'hF2}; 
		i13:{datai,addri} = {8'hF2,8'hF2};
		default : {datai,addri} = {8'h00,8'h21};	  
	endcase

//Direcciones de Standby (Lectura)
always @(posedge clock)
	case (estado_actual_L)
		L0: addrL = 8'h00;
		L1: addrL = 8'hF1;
		L2: addrL = 8'h26;
		L3: addrL = 8'h25;
		L4: addrL = 8'h24;
		L5: addrL = 8'h23;
		L6: addrL = 8'h22;
		L7: addrL = 8'h21;
		L8: addrL = 8'h43;
		L9: addrL = 8'h42;
		L10:addrL = 8'h41;
		default : addrL = 8'h21;	  
	endcase

//Direcciones para Programar Fecha/Hora
always @(posedge clock)
	case (estado_actual_PFH)
		PFH0: addrPFH = 8'h00;
		PFH1: addrPFH = 8'h26;
		PFH2: addrPFH = 8'h25;
		PFH3: addrPFH = 8'h24;
		PFH4: addrPFH = 8'h23;
		PFH5: addrPFH = 8'h22;
		PFH6: addrPFH = 8'h21;
		PFH7: addrPFH = 8'hF1;
		default : addrPFH = 8'h21;	  
	endcase

//Direcciones para Programar Temporizador
always @(posedge clock)
	case (estado_actual_PT)
		PT0: addrPT = 8'h00;
		PT1: addrPT = 8'h43;
		PT2: addrPT = 8'h42;
		PT3: addrPT = 8'h41;
		PT4: addrPT = 8'hF2;
		
		default : addrPT = 8'h41;	  
	endcase

//Enable de procesos escritura
always @(posedge clock)
	case (estado_actual_m)
		m0: if (estado_actual_i != i0)
				win = 1'b1;
			 else	
				win = 1'b0;
				
		m1: win = 1'b0;
		
		m2: if (estado_actual_PFH != PFH0)
				win = 1'b1;
			 else	
				win = 1'b0;
		m3: if (estado_actual_PT != PT0)
				win = 1'b1;
			 else	
				win = 1'b0;
		default : win = 1'b0;
	endcase

//Enable de procesos lectura
always @(posedge clock)
	case (estado_actual_m)
		m0: rin = 1'b0;
				
		m1: if (estado_actual_L != L0)
				rin = 1'b1;
			 else	
				rin = 1'b0;
		m2: rin = 1'b0;
		m3: rin = 1'b0;
		default : rin = 1'b0;
	endcase

//Multiplexor de Adress
always @(posedge clock)
	case (estado_actual_m)
		m0: address = addri;
		m1: address = addrL;
		m2: address = addrPFH;
		m3: address = addrPT;
		default : address = addrL;
	endcase

endmodule
