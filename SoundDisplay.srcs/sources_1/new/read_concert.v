`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/30 03:36:03
// Design Name: 
// Module Name: read_concert_background
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


module read_concert_background(input clock_100Mhz,input [12:0]index, output reg [15:0]unit_colour=16'b0);
    reg [15:0] background_concert [0:6143];
    
    initial begin
       $readmemh("concert.mem",background_concert);
    end
    
    always @(posedge clock_100Mhz)
    begin
       unit_colour = background_concert[index];
    end
    
endmodule
