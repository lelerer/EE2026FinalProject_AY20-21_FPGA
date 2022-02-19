`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/30 18:12:21
// Design Name: 
// Module Name: forest_render
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

module forest_render(
input show_congras,
input start,
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

input [5:0]mario_x,
input [6:0]mario_y,

output reg [15:0]oled_data,
input [5:0]x,
input [6:0]y
);
parameter [6:0] moon_y = 10,pipe_y=80,door_y=75,square_y=0,tord_y=15;
parameter [5:0] moon_x = 29,pipe_x=50,door_x=5,square_x=0,tord_x=52;

always @(posedge clock_100Mhz)
begin
if (start)begin
if(~show_congras)begin
if (~hint)begin
   oled_data = background_unit_colour;
     
   if(x >= moon_x && x< moon_x+12 && y>= moon_y && y< moon_y+9 && ~got_moon) oled_data = moon_unit_colour;
   if(x >= pipe_x && x< pipe_x+14 && y>= pipe_y && y< pipe_y+11) oled_data = pipe_unit_colour;
   if (x >= door_x && x< door_x+15 && y>= door_y && y< door_y + 15) oled_data = door_unit_colour;
   if (x >= tord_x && x< tord_x+12 && y>= tord_y && y< tord_y + 11 && tord_on) oled_data = tord_unit_colour;
   
   if (x >= square_x && x< square_x+7 && y>= square_y && y< square_y + 10 && got_moon) oled_data = square_unit_colour_got_moon;
   if (x >= square_x && x< square_x+7 && y>= square_y && y< square_y + 10 && ~got_moon) oled_data = square_unit_colour_no_moon;
   
   if (btnD==0)
     if ( x >= mario_x && x< mario_x+14 && y>= mario_y && y< mario_y+10)  oled_data = mario_unit_colour;
   if (btnD==1)
     if (x >= mario_x+7 && x< mario_x+14 && y>= mario_y && y< mario_y+10)  oled_data = mario_unit_colour;
     
   if(oled_data == 16'hffff) oled_data = background_unit_colour;
end

else oled_data = btnD_hint_unit_colour;
end

end
end
endmodule

