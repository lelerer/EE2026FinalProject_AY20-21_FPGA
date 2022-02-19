`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/30 00:24:10
// Design Name: 
// Module Name: read_tord
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module read_tord(input clock_100Mhz,input[5:0]x, input [6:0]y,output reg [15:0]unit_colour = 16'b0, input [5:0]tord_x,input [6:0]tord_y );
    reg [15:0]tord[0:131];
    reg [7:0]index;
    
    initial begin
       $readmemh("tord.mem",tord);
    end
    
    always @(posedge clock_100Mhz)
    begin
      if (x >= tord_x && x< tord_x+12 && y>= tord_y && y< tord_y+ 11)
      begin
          index= (x-tord_x)*11+ y-tord_y;
          unit_colour = tord[index];
      end
    end
    
    
endmodule

