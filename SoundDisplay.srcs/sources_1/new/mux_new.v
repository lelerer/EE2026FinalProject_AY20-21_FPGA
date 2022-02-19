`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2021 08:16:15 PM
// Design Name: 
// Module Name: mux_new
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


module mux_new(
input toggle_indicate,
input [11:0] mic_in,
input [11:0] vol_peak,
output [11:0] selected_signal
//output [15:0] led
    );
    assign selected_signal = toggle_indicate ? mic_in : vol_peak;
endmodule