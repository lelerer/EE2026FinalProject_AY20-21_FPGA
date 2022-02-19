`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/01 22:48:21
// Design Name: 
// Module Name: moving_control
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


module moving_control(
input start,
input clk,
input flex_clock,
input enable,
input left_debounce,
input right_debounce,
output reg enable_out = 1,
output reg left,right
    );
    
    reg count;
    
    always @ (posedge clk) begin
    if(start)begin
    if ( right_debounce == 1) begin
    left = 0;
    right = 1;
    end
    
    else if (left_debounce == 1)begin
    left = 1;
    right = 0;
    end
    
    if (enable == 1) begin
    enable_out = 1;
    end
    
    if(count == 0 && flex_clock == 1) begin
    left = 0;
    right = 0;
    enable_out = 0;
    end
    count <= flex_clock;
    end
    end
    
endmodule

