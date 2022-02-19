`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/08 17:00:04
// Design Name: 
// Module Name: my_dff
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


module my_dff(
    input D,
    input dff_clock,
    output reg Q
    );
    always @ (posedge dff_clock)
    begin
        Q <= D;
    end
endmodule
