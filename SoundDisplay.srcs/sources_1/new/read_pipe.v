`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/28 23:40:54
// Design Name: 
// Module Name: read_pipe
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

module read_pipe(input clock_100Mhz,input[5:0]x, input [6:0]y,output reg [15:0]unit_colour = 16'b0, input [5:0]pipe_x,input [6:0]pipe_y );
    reg [15:0]pipe[0:153];
    reg [7:0]index;
    
    initial begin
       $readmemh("pipe.mem",pipe);
    end
    
    always @(posedge clock_100Mhz)
    begin
      if (x >= pipe_x && x< pipe_x+14 && y>= pipe_y && y< pipe_y+11)
      begin
          index= (x-pipe_x)*11+ y-pipe_y;
          unit_colour = pipe[index];
      end
    end
    
    
endmodule
