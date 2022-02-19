`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/30 17:11:48
// Design Name: 
// Module Name: read_monster
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


module read_monster(input clock_100Mhz,input[5:0]x, input [6:0]y,output reg [15:0]unit_colour = 16'b0, input [5:0]monster_x,input [6:0]monster_y );
    reg [15:0]monster[0:87];
    reg [7:0]index;
    
    initial begin
       $readmemh("monster.mem",monster);
    end
    
    always @(posedge clock_100Mhz)
    begin
      if (x >= monster_x && x< monster_x+8 && y>= monster_y && y< monster_y + 11)
      begin
          index= (x-monster_x)*11+ y-monster_y;
          unit_colour = monster[index];
      end
    end
    
    
endmodule
