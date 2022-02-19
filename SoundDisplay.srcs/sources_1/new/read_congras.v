`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/30 03:04:56
// Design Name: 
// Module Name: read_congras
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


module read_forest_congras(input clock_100Mhz,input [12:0]index, output reg [15:0]unit_colour=16'b0);
    reg [15:0] congras [0:6143];
    
    initial begin
       $readmemh("congras_forest.mem",congras);
    end
    
    always @(posedge clock_100Mhz)
    begin
       unit_colour = congras[index];
    end
    
endmodule

