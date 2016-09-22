`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    22:35:36 09/19/2016
// Design Name:
// Module Name:    DECODER
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
module DECODER(
  input enable,
  input [3:0] bcd_num,
  output  reg [1:0] address_out_reg,//address_out2,
  output   reg [3:0] sel_address_out_reg //sel_address_out2
    );

always@* begin
   if(enable) begin
          case(bcd_num)
             4'b0000 :begin
                  address_out_reg = 2'h0;
                  sel_address_out_reg=4;end
             4'b0001 :begin
                  address_out_reg = 2'h1;
                 sel_address_out_reg=4;end
             4'b0010 :begin
					        address_out_reg = 2'h2;
                  sel_address_out_reg=4;end
             4'b0011 :begin
                    address_out_reg = 2'h3;
                    sel_address_out_reg=4;end
             4'b0100 :begin
                   address_out_reg = 2'h0;
                   sel_address_out_reg=5;end
             4'b0101 : begin
                   address_out_reg = 2'h1;
                   sel_address_out_reg=5;end
             4'b0110 : begin
                    address_out_reg = 2'h2;
                    sel_address_out_reg=5;end
             4'b0111 : begin
                   address_out_reg = 2'h3;
                   sel_address_out_reg=5;end
             4'b1000 : begin
                   address_out_reg = 2'h0;
                   sel_address_out_reg=6;end
             4'b1001 : begin
                   address_out_reg = 2'h1;
                   sel_address_out_reg=6;end

             default:  begin address_out_reg = 0;sel_address_out_reg=0;end
        	endcase
		  end
		end


endmodule
