`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/29 14:38:36
// Design Name: 
// Module Name: read_door
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


module read_door(input clock_100Mhz,input[5:0]x, input [6:0]y,output reg [15:0]unit_colour = 16'b0, input [5:0]door_x,input [6:0]door_y );
    reg [15:0]door[0:224];
    reg [7:0]index;
    
    initial begin
       $readmemh("door.mem",door);
    end
    
    always @(posedge clock_100Mhz)
    begin
      if (x >= door_x && x< door_x+15 && y>= door_y && y< door_y + 15)
      begin
          index= (x-door_x)*15+ y-door_y;
          unit_colour = door[index];
      end
    end
    
    
endmodule

