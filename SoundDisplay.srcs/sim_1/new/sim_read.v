`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/24 15:40:06
// Design Name: 
// Module Name: sim_read
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


module sim_read();
     reg [5:0]x;
     reg [6:0]y;
     wire [15:0]sim_unit_colour;
     
     readmem unit_test(x,y,sim_unit_colour);
     
     initial begin
       x=60;
       y=1;
     end
     
endmodule
