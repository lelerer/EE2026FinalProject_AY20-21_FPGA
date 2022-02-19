`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/29 16:08:51
// Design Name: 
// Module Name: read_got_moon
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


module read_got_moon(input clock_100Mhz,input[5:0]x, input [6:0]y,output reg [15:0]unit_colour = 16'b0, input [5:0]got_moon_x,input [6:0]got_moon_y );
   
    reg [15:0]got_moon[0:69];
    reg [7:0]index;
    
    initial begin
       $readmemh("got_moon.mem",got_moon);
    end
    
    always @(posedge clock_100Mhz)
    begin
      if (x >= got_moon_x && x< got_moon_x+7 && y>= got_moon_y && y< got_moon_y + 10)
      begin
          index= (x-got_moon_x)*10+ y-got_moon_y;
          unit_colour = got_moon[index];
      end
    end
    
    
endmodule

