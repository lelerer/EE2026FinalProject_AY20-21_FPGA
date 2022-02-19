`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/15 16:39:41
// Design Name: 
// Module Name: convert_index
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


module convert_index(
    input [12:0]pixel_index,
    output [5:0]x,
    output [6:0]y
    );
    assign x= pixel_index / 96;
    assign y= pixel_index % 96;
    
endmodule
