`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/28 13:47:55
// Design Name: 
// Module Name: read_oled_background
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

module read_oled_background(
    input clock100Mhz,
    input [12:0]index, 
    output reg [15:0]unit_colour = 16'b0
);
     reg [15:0] background[0:6143];
     
   initial begin
      $readmemh("oled_background.mem",background);
   end
   
   always @(posedge clock100Mhz)
   begin
       unit_colour <= background[index];
   end

endmodule
