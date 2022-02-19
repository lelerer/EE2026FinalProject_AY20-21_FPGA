`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/31 12:59:14
// Design Name: 
// Module Name: read_thank_you
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


module read_thank_you(input clock_100Mhz,input [12:0]index, output reg [15:0]unit_colour=16'b0);
    reg [15:0] thank_you [0:6143];

initial begin
   $readmemh("thank_you.mem",thank_you);
end

always @(posedge clock_100Mhz)
begin
   unit_colour = thank_you[index];
end

endmodule
