`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/01 23:29:59
// Design Name: 
// Module Name: read_menu
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


module read_menu(input clock_100Mhz,input [12:0]index, output reg [15:0]unit_colour=16'b0);
    reg [15:0] menu [0:6143];
    
    initial begin
       $readmemh("menu.mem",menu);
    end
    
    always @(posedge clock_100Mhz)
    begin
       unit_colour = menu[index];
    end
    
endmodule
