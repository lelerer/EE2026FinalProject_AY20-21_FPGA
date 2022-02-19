`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/28 15:55:20
// Design Name: 
// Module Name: read_mario
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


module read_mario(input btnD, input clock_100Mhz,input[5:0]x, input [6:0]y,output reg [15:0]unit_colour = 16'b0, input [5:0]mario_x,input [6:0]mario_y,output reg short);
    reg [15:0]tall_mario[0:139];
    reg [15:0]short_mario[0:69];
    reg [5:0]short_index_x;
    reg [7:0]index;
   
    initial begin
        $readmemh("Mario.mem",tall_mario);
        $readmemh("short_mario.mem",short_mario);
    end
    
    always @(posedge clock_100Mhz)
    begin
    if(btnD==0)
    begin
      if (x >= mario_x && x< mario_x+14 && y>= mario_y && y< mario_y+10)
      begin
          index= (x-mario_x)*10+ y-mario_y;
          unit_colour = tall_mario[index];
          short=0;
      end
     end
     
    else 
    begin
      if (x >= mario_x+7 && x< mario_x+14 && y>= mario_y && y< mario_y+10)
      begin
        index= (x-mario_x-7)*10+ y-mario_y;
        unit_colour = short_mario[index];
        short=1;
      end     
    end
    
    end
    
    
endmodule
