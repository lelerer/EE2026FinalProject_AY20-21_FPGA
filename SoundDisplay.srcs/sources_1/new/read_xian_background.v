`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/30 14:17:13
// Design Name: 
// Module Name: read_xian_background
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


module read_xian_background(input clock_100Mhz,input [12:0]index, output reg [15:0]unit_colour=16'b0);
    reg [15:0]background[0:6143];
    
    initial begin
       $readmemh("xian.mem",background);
    end
    
    always @(posedge clock_100Mhz)
    begin
       unit_colour = background[index];
    end
    
endmodule