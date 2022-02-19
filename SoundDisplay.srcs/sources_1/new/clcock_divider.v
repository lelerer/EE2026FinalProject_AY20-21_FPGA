`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/08 14:30:22
// Design Name: 
// Module Name: clcock_divider
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


module clock_divider(input basys_clock, output reg new_clock=0,input [31:0] m);

      reg [31:0] count=0;
      
      always @ (posedge basys_clock)
      begin
      count <= (count == m)? 0 : count+1;
      new_clock <= (count == 0)? ~new_clock : new_clock;
      end
      
endmodule
