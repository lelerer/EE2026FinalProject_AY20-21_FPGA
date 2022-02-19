`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/30 03:26:18
// Design Name: 
// Module Name: Game2_concert
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

module Game2_concert(
input big_start,
input start,
input btnL,btnR,btnC,btnU,btnD,
input [11:0]mic_in,
input tord_on,
input clock_10hz,clock_100Mhz,clock_3P125Mhz,
output  [15:0]oled_data,
input [5:0]x,
input [6:0]y,
input [12:0]index,
output reg pass=0
    );
    parameter [5:0]ground1=63;
    parameter [5:0]ground2=51;
    parameter [5:0]ground3=26;
    parameter [5:0]ground4=18;
    
    wire [15:0]mario_unit_colour;
    wire [15:0]background_unit_colour;
    wire [15:0]music_hint_unit_colour;
    wire [15:0]moon_unit_colour;
    wire [15:0]door_unit_colour;
    wire [15:0]pipe_unit_colour;
    wire [15:0]tord_unit_colour;
    wire [15:0]square_unit_colour_no_moon;
    wire [15:0]square_unit_colour_got_moon;
    wire [15:0]congratulations_unit_colour;
    wire short;
    reg concert_got_moon=0;
    reg hint=0;
    reg tord=0;  
    reg [5:0]ground=ground1;
    
    reg [5:0] mario_x = 37; 
    reg [6:0] mario_y = 4;
    
    reg concert_show_moon=0;
    reg show_congras=0;
    
    parameter [5:0] moon_x = 3,pipe_x=50,door_x=3,square_x=0,tord_x=14;
    parameter [6:0]moon_y =40 ,pipe_y=3,door_y=81,square_y=0,tord_y=2;
    
//---------------control position--------------------------------------------------  
    always @(posedge clock_10hz)
    begin
    if(start && big_start) begin
     concert_show_moon=0;
     if (mic_in>=3072) concert_show_moon=1;
     
     ground = ground1;
     if (mario_y+5 >= 63  && mario_y <=95 && mario_x+13==ground2) begin mario_x=ground2-13; ground = ground2; end
     if (mario_y+5 >= 0  && mario_y <= 17 && mario_x+13==ground3) begin mario_x=ground3-13; ground = ground3; end 
     if (mario_y+8 >= 79  && mario_y <= 95 && mario_x+13==ground4) begin mario_x=ground4-13; ground = ground4; end 
     if (mario_y+5 >= 0   && mario_y <=95 && mario_x+13==ground1 &&~(mario_y+5 >= pipe_y && mario_y+5 <= pipe_y +11 && mario_x+13==pipe_x) ) begin mario_x=ground1-13; ground = ground1; end
     
     if (btnL && mario_y > 0)   mario_y = mario_y - 1;
     if (btnR && mario_y < 84 && ~(mario_x+13 == ground1 && mario_y  >=53 && mario_y <=63 )) mario_y = mario_y + 1;
    
     if ( ~(mario_x+13==pipe_x && mario_y +5 >= pipe_y && mario_y +5 <= pipe_y+10) && mario_x+14 <= ground) mario_x = mario_x+1;
              
     if (btnU && mario_x+13==ground && ~btnD) mario_x = (mario_x>=30)?  mario_x-30: 0;
     if (btnD && btnU && mario_x+13 == ground ) mario_x = ( mario_x >= 40)? mario_x - 40: 0;
     
     if (mario_x+5 >=moon_x &&  mario_x+5 <= moon_x+12 && mario_y >= moon_y && mario_y<= moon_y + 9) concert_got_moon = 1;
     
     tord=0;
     if (mario_x+5 >= tord_x && mario_x+5 <= tord_x+11 && btnC && (mario_y >= tord_y && mario_y <= tord_y + 10 || mario_y+9 >= tord_y && mario_y + 9 <= tord_y + 10) ) tord=1;   
           
     hint=0;
     if (btnC && tord) hint=1; 
     
     if(concert_got_moon && btnC && mario_x+7 >= door_x && mario_x+7 <= door_x + 14 && mario_y>= door_y && mario_y <= door_y+14 ) show_congras=1;
     
     if(show_congras==1 && btnC) pass=1;
end
end
//-------------------------------------------------------------------------------------


//------------------read mem files-----------------------------------------
        read_concert_background concert_background_read (clock_100Mhz,index,background_unit_colour); 
        read_forest_congras concert_congras_read (clock_100Mhz,index,congratulations_unit_colour); 
        read_concert_hint hint_read (clock_100Mhz,index,music_hint_unit_colour);
        
        read_mario mario_read (btnD,clock_100Mhz,x,y,mario_unit_colour,mario_x,mario_y,short);
        read_moon moon_read (clock_100Mhz,x,y,moon_unit_colour,moon_x,moon_y);
        read_door door_read (clock_100Mhz,x,y,door_unit_colour,door_x,door_y);
        read_pipe pipe_read (clock_100Mhz,x,y,pipe_unit_colour,pipe_x,pipe_y);
        read_tord tord_read (clock_100Mhz,x,y,tord_unit_colour,tord_x,tord_y);
        
        read_no_moon no_moon_read (clock_100Mhz,x,y,square_unit_colour_no_moon,square_x,square_y);
        read_got_moon got_moon_read (clock_100Mhz,x,y,square_unit_colour_got_moon,square_x,square_y);
    //----------------------------------------------------------------------------------------------------------
    
    //------------------------render--------------------------------------------------
         concert_render concert_render (
         show_congras,
         start,
         concert_show_moon,
         tord_on,
         hint,
         concert_got_moon,
         btnD,
         clock_100Mhz,
         
         mario_unit_colour,
         background_unit_colour,
         music_hint_unit_colour,
         moon_unit_colour,
         pipe_unit_colour,
         door_unit_colour,
         tord_unit_colour,
         square_unit_colour_no_moon,
         square_unit_colour_got_moon,
         congratulations_unit_colour,
         
         mario_x,mario_y,

         oled_data,
         x,y);
    //------------------------------------------------------------------------------------
    
endmodule
