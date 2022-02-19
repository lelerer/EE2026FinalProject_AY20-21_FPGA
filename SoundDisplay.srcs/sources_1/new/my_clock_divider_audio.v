`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/15 09:30:36
// Design Name: 
// Module Name: my_clock_divider_audio
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


module my_clock_divider_audio(
    input basys_clock,
    output reg my_new_clock = 0,
    input [31:0]m_value
    );// set a clock divider to give a new clock of 20kHz (this is just the demo during lab session, may
    //not be what project needs
    reg [31:0] count = 0;//remember to give initial value, make sure 
    // that the size you give is enough for stop value of count
    always @ (posedge basys_clock)//perform the following operations once in each cycle of basys clock
    begin
    count <= (count == m_value) ? 0:count + 1;
    my_new_clock <= (count == 0) ? ~my_new_clock:my_new_clock;
    end
endmodule

