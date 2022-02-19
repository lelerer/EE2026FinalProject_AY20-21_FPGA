`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/02 22:44:38
// Design Name: 
// Module Name: read_bg2
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

module read_bg2(
    input clock100Mhz,
    input [12:0]index, 
    output reg [15:0]unit_colour = 16'b0
);
     reg [15:0] bg2[0:6143];
     
   initial begin
      $readmemh("bg2.mem",bg2);
   end
   
   always @(posedge clock100Mhz)
   begin
       unit_colour <= bg2[index];
   end

endmodule