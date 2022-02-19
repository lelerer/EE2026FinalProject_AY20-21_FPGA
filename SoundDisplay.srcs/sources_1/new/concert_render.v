`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/30 18:12:33
// Design Name: 
// Module Name: concert_render
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


module concert_render(
input show_congras,
input start,
input concert_show_moon,
input tord_on,
input hint,
input concert_got_moon,
input btnD,
input clock_100Mhz,

input [15:0]mario_unit_colour,
input [15:0]background_unit_colour,
input [15:0]music_hint_unit_colour,
input [15:0]moon_unit_colour,    
input [15:0]pipe_unit_colour,
input [15:0]door_unit_colour,
input [15:0]tord_unit_colour,
input [15:0]square_unit_colour_no_moon,
input [15:0]square_unit_colour_got_moon,
input [15:0]congratulations_unit_colour,

input [5:0]mario_x,
input [6:0]mario_y,

output reg [15:0]oled_data,
input [5:0]x,
input [6:0]y
);
    parameter [5:0] moon_x = 3,pipe_x=50,door_x=3,square_x=0,tord_x=14;
    parameter [6:0] moon_y =40 ,pipe_y=3,door_y=81,square_y=0,tord_y=2;

always @(posedge clock_100Mhz)
begin

if(start) begin
if(~show_congras) begin

if (~hint)
begin
   oled_data = background_unit_colour;
     
   if(x >= moon_x && x< moon_x+12 && y>= moon_y && y< moon_y+9 && ~concert_got_moon && concert_show_moon) oled_data = moon_unit_colour;
   if(x >= pipe_x && x< pipe_x+14 && y>= pipe_y && y< pipe_y+11) oled_data = pipe_unit_colour;
   if (x >= door_x && x< door_x+15 && y>= door_y && y< door_y + 15) oled_data = door_unit_colour;
   if (x >= tord_x && x< tord_x+12 && y>= tord_y && y< tord_y + 11 && tord_on) oled_data = tord_unit_colour;
   
   if (x >= square_x && x< square_x+7 && y>= square_y && y< square_y + 10 && concert_got_moon) oled_data = square_unit_colour_got_moon;
   if (x >= square_x && x< square_x+7 && y>= square_y && y< square_y + 10 && ~concert_got_moon) oled_data = square_unit_colour_no_moon;
   
   if (btnD==0)
     if ( x >= mario_x && x< mario_x+14 && y>= mario_y && y< mario_y+10)  oled_data = mario_unit_colour;
   if (btnD==1)
     if (x >= mario_x+7 && x< mario_x+14 && y>= mario_y && y< mario_y+10)  oled_data = mario_unit_colour;
     
   if(oled_data == 16'hffff) oled_data = background_unit_colour;
   
end

else oled_data = music_hint_unit_colour;
end

if (show_congras) oled_data= ~congratulations_unit_colour;
end

end
endmodule
