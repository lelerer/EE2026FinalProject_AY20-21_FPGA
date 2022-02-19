`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/01 22:43:41
// Design Name: 
// Module Name: flexible_clock
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


module flexible_clock(
input clk,
output reg[35:0] counter = 0
    );
    
    always @(posedge clk) begin
    counter = counter + 1;
    end
endmodule

