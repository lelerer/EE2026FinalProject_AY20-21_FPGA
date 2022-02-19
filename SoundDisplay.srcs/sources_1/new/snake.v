`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/01 22:42:32
// Design Name: 
// Module Name: snake
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


module snake(
input start,
input clk,
input [12:0] pixel,
input [2:0] btn,
input [3:0] switch,
output [3:0] anode,
output [7:0] seg,
output [15:0] oled
    );
    
    wire [35:0] flex_clock;
    
    flexible_clock unit_fc (.clk(clk),.counter(flex_clock));
    
    wire left_debounce,right_debounce,reset;
    
    single_pulse_circuit d1(btn[0], flex_clock[15],reset);
    single_pulse_circuit d2(btn[1], flex_clock[15],left_debounce);
    single_pulse_circuit d3(btn[2], flex_clock[15],right_debounce);
    
    wire [5:0] score;
    wire switch_speed;
    wire enable_out, left,right;
    moving_control m_c (.start(start),.clk(clk),.flex_clock(switch_speed),.enable(reset),.left_debounce(left_debounce),.right_debounce(right_debounce),.enable_out(enable_out),.left(left),.right(right));
    
    snake_oled  s_o (.start(start),.flex_clock(switch_speed),.enable(enable_out),.left_debounce(left),.right_debounce(right),.pixel(pixel),.oled(oled),.score(score));
    
    snake_seg_display s_s_d (.start(start),.clk(flex_clock[15]),.score(score),.anode(anode),.seg(seg));
    
    assign switch_speed = (switch[4] == 1) ? flex_clock[21] :
                                (switch[3] == 1) ? flex_clock[22] :
                                (switch[2] == 1) ?flex_clock[23] :
                                (switch[1] == 1) ? flex_clock[24] :
                                0;
  
    
endmodule

