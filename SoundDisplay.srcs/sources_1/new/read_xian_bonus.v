`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/30 16:22:56
// Design Name: 
// Module Name: read_xian_bonus
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


module read_xian_bonus(input clock_100Mhz,input [12:0]index, output reg [15:0]unit_colour=16'b0);
    reg [15:0]bonus[0:6143];

initial begin
   $readmemh("bonus.mem",bonus);
end

always @(posedge clock_100Mhz)
begin
   unit_colour = bonus[index];
end

endmodule
