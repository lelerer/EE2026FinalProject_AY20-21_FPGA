`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/29 01:58:58
// Design Name: 
// Module Name: read_forest_background
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


module read_forest_background(input clock_100Mhz,input [12:0]index, output reg [15:0]unit_colour=16'b0);
    reg [15:0] background_forest [0:6143];
    
    initial begin
       $readmemh("forest.mem",background_forest);
    end
    
    always @(posedge clock_100Mhz)
    begin
       unit_colour = background_forest[index];
    end
    
endmodule


