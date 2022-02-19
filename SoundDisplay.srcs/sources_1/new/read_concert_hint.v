`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/30 14:29:40
// Design Name: 
// Module Name: read_concert_hint
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



module read_concert_hint(input clock_100Mhz,input [12:0]index, output reg [15:0]unit_colour=16'b0);
    reg [15:0] hint [0:6143];
    
    initial begin
       $readmemh("concert_hint.mem",hint);
    end
    
    always @(posedge clock_100Mhz)
    begin
       unit_colour = hint[index];
    end
    
endmodule