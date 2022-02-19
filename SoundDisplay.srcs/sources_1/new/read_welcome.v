`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/01 23:29:03
// Design Name: 
// Module Name: read_welcome
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


module read_welcome(input clock_100Mhz,input [12:0]index, output reg [15:0]unit_colour=16'b0);
    reg [15:0] welcome [0:6143];
    
    initial begin
       $readmemh("welcome.mem",welcome);
    end
    
    always @(posedge clock_100Mhz)
    begin
       unit_colour = welcome[index];
    end
    
endmodule
