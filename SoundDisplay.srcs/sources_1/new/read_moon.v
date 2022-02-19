`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/28 23:20:29
// Design Name: 
// Module Name: read_moon
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


module read_moon(input clock_100Mhz,input[5:0]x, input [6:0]y,output reg [15:0]unit_colour = 16'b0, input [5:0]moon_x,input [6:0]moon_y );
    reg [15:0]moon[0:107];
    reg [7:0]index;
    
    initial begin
       $readmemh("moon.mem",moon);
    end
    
    always @(posedge clock_100Mhz)
    begin
      if (x >= moon_x && x< moon_x+12 && y>= moon_y && y< moon_y+9)
      begin
          index= (x-moon_x)*9+ y-moon_y;
          unit_colour = moon[index];
      end
    end
    
    
endmodule

