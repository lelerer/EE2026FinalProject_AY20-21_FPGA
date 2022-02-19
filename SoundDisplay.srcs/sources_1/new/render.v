`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/28 16:14:21
// Design Name: 
// Module Name: render
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


module render(
    input start,
    input bonus_display,
    input bonus_find,
    input show_moon,
    input tord_on,
    input hint,
    input got_moon,
    input btnD,
    input clock_100Mhz,
    
    input [15:0]mario_unit_colour,
    input [15:0]background_unit_colour,
    input [15:0]btnD_hint_unit_colour,
    input [15:0]moon_unit_colour,    
    input [15:0]pipe_unit_colour,
    input [15:0]door_unit_colour,
    input [15:0]tord_unit_colour,
    input [15:0]square_unit_colour_no_moon,
    input [15:0]square_unit_colour_got_moon,
    input [15:0]monster_unit_colour,
    input [15:0]bonus_unit_colour,
    
    input [5:0]mario_x,
    input [6:0]mario_y,

    output reg [15:0]oled_data,
    input [5:0]x,
    input [6:0]y
    );
    
    parameter [5:0]monster_x=6, moon_x = 30,tord_x=12,pipe_x=48,square_x=0,door_x=46;
    parameter [6:0]monster_y=83,moon_y = 80,tord_y=59,pipe_y=2,square_y=0,door_y=78;   
    
    always @(posedge clock_100Mhz)
    begin
    if (start) begin
       oled_data = background_unit_colour;
       if(x >= moon_x && x< moon_x+12 && y>= moon_y && y< moon_y+9 && ~got_moon && show_moon) oled_data = moon_unit_colour;
       if(x >= pipe_x && x< pipe_x+14 && y>= pipe_y && y< pipe_y+11) oled_data = pipe_unit_colour;
       if (x >= door_x && x< door_x+15 && y>= door_y && y< door_y + 15) oled_data = door_unit_colour;
       if (x >= tord_x && x< tord_x+12 && y>= tord_y && y< tord_y + 11 && tord_on) oled_data = tord_unit_colour;
       
       if (x >= square_x && x< square_x+7 && y>= square_y && y< square_y + 10 && got_moon) oled_data = square_unit_colour_got_moon;
       if (x >= square_x && x< square_x+7 && y>= square_y && y< square_y + 10 && ~got_moon) oled_data = square_unit_colour_no_moon;
       if (x >= monster_x && x< monster_x+8 && y>= monster_y && y< monster_y + 11 && bonus_find) oled_data = monster_unit_colour;
      
       if ( x >= mario_x && x< mario_x+14 && y>= mario_y && y< mario_y+10 && ~btnD)  oled_data = mario_unit_colour;
       if (x >= mario_x+7 && x< mario_x+14 && y>= mario_y && y< mario_y+10 && btnD)  oled_data = mario_unit_colour;

       if(oled_data == 16'hffff) oled_data = background_unit_colour;
       
       if (hint) oled_data = btnD_hint_unit_colour;
       if (bonus_display) oled_data = bonus_unit_colour;
    end
    end
endmodule
