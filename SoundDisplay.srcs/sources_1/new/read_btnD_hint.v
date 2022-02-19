`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/30 00:31:19
// Design Name: 
// Module Name: read_btnD_hint
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


module read_btnD_hint(input clock_100Mhz,input [12:0]index, output reg [15:0]unit_colour=16'b0);
    reg [15:0] btnD_hint [0:6143];
    
    initial begin
       $readmemh("btnD_hint.mem",btnD_hint);
    end
    
    always @(posedge clock_100Mhz)
    begin
       unit_colour = btnD_hint[index];
    end
    
endmodule
