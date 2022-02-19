`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/01 22:49:52
// Design Name: 
// Module Name: random
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


module random(
input clk,
input eat,
input start,
output [6:0]point_x,
output [6:0]point_y
    );
    
    reg [199:0] random_number = 200'b0100100111110000011100001100101111101001111001101101001010000100110100111110001110010110111000011111011011100000011100110001101110100000100001100101100100101001010011101110111010111000110111100100010;
    reg ref;
    always @(posedge clk) begin
    if (eat || start)
    begin
    ref = random_number[199];
    random_number = random_number << 1;
    random_number = random_number + ref;
    end
    end
    
    assign point_x = (random_number [86:80] %30) *2 +18;
    assign point_y = (random_number [36:30] %30) *2 + 2;
    
    
endmodule

