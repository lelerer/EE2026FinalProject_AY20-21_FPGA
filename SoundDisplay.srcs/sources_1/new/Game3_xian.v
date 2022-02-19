`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/30 03:26:31
// Design Name: 
// Module Name: Game3_xian
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


module Game3_xian(
input big_start,
input start,
input sw0,sw2,sw9,
input btnL,btnR,btnC,btnU,btnD,
input tord_on,
input clock_10hz,clock_100Mhz,clock_3P125Mhz,
output  [15:0]oled_data,
input [5:0]x,
input [6:0]y,
input [12:0]index,
output reg pass=0
    );
    parameter [5:0]ground1=60;
    parameter [5:0]ground2=35;
    parameter [5:0]ground3=29;
    parameter [5:0]ground4=23;
    parameter [5:0]ground5=17;
    
    wire [15:0]mario_unit_colour;
    wire [15:0]background_unit_colour;
    wire [15:0]btnD_hint_unit_colour;
    wire [15:0]moon_unit_colour;
    wire [15:0]door_unit_colour;
    wire [15:0]pipe_unit_colour;
    wire [15:0]tord_unit_colour;
    wire [15:0]bonus_unit_colour;
    wire [15:0]square_unit_colour_no_moon;
    wire [15:0]square_unit_colour_got_moon;
    wire [15:0]monster_unit_colour;
    
    reg [5:0] mario_x = 33;
    
    reg [6:0] mario_y = 3;
    reg [5:0]ground=ground1;
    
    parameter [5:0] moon_x = 30,pipe_x=48,door_x=46,square_x=0,tord_x=12,monster_x=6;
    parameter [6:0] moon_y = 80,pipe_y=2,door_y=78,square_y=0,tord_y=59,monster_y=83;
    
    wire short;
    reg got_moon=0;
    reg hint=0;
    reg tord=0;  
    wire show_moon;
    reg bonus_find=0;
    reg bonus_display=0;
    assign show_moon = sw0 && sw2 && sw9;
    
    
//--------------------------position control----------------------------------
    always @(posedge clock_10hz)
    begin
    if(start && big_start) begin
     ground = ground1;
     if (mario_y+10 >= 30  && mario_y <=37 && mario_x+13==ground2) begin mario_x=ground2-13; ground = ground2; end
     if (mario_y+8 >= 39  && mario_y <=56  && mario_x+13==ground3) begin mario_x=ground3-13; ground = ground3; end 
     if (mario_y+8 >= 57  && mario_y <= 74 && mario_x+13==ground4) begin mario_x=ground4-13; ground = ground4; end 
     if (mario_y+8 >= 75  && mario_y <= 95 && mario_x+13==ground5) begin mario_x=ground5-13; ground = ground5; end 
     if (mario_y+5 >= 0   && mario_y <=95 && mario_x+13==ground1 &&~(mario_y+5 >= pipe_y && mario_y+5 <= pipe_y +11 && mario_x+13==pipe_x) ) begin mario_x=ground1-13; ground = ground1; end
     
     if (btnL && mario_y > 0)   mario_y = mario_y - 1;
     if (btnR && mario_y < 84 && ~(mario_x == 22  && mario_y >= 27 ) && ~(mario_x==16 && mario_y>= 47) && ~(mario_x==10 && mario_y >= 65) ) mario_y = mario_y + 1;
    
     if (~(mario_y+5 >= pipe_y && mario_y+5 <= pipe_y +11 && mario_x+13==pipe_x) &&  mario_x+13+1 <= ground) mario_x = mario_x+1;
     
     if (btnU && mario_x+13==ground && ~btnD) mario_x = (mario_x>=25)?  mario_x-27: 0;
     
     if (btnD && btnU && mario_x+13 == ground ) mario_x = ( mario_x >= 30)? mario_x - 30: 0;
     
     if (mario_x+5 >=moon_x &&  mario_x+5 <= moon_x+12 && mario_y+4 >= moon_y && mario_y +4 <= moon_y + 9) got_moon = 1;
     
     tord=0;
     if (mario_x+5 >= tord_x && mario_x+5 <= tord_x+11 && btnC && (mario_y >= tord_y && mario_y <= tord_y + 10 || mario_y+9 >= tord_y && mario_y + 9 <= tord_y + 10) ) tord=1;   
           
     hint=0;
     if (btnC && tord) hint=1; 
     
     if (show_moon) bonus_find=1;
     
     if(got_moon && btnC && mario_x+7 >= door_x && mario_x+7 <= door_x + 14 && mario_y>= door_y && mario_y <= door_y+14 ) pass=1;
     
     bonus_display=0;
     if( mario_x+8 >= monster_x && mario_x+5 <= monster_x + 11 && btnC && (mario_y >= monster_y && mario_y <= monster_y + 9 || mario_y + 9 >= monster_y && mario_y +9 <= monster_y + 8) && show_moon ) bonus_display=1; 
end
end
//--------------------------------------------------------------------------------    
    
//------------------read mem files-----------------------------------------
        read_xian_background xian_background_read (clock_100Mhz,index,background_unit_colour);
        read_xian_hint hint_read (clock_100Mhz,index,btnD_hint_unit_colour);
        read_xian_bonus bonus_read (clock_100Mhz,index,bonus_unit_colour);
        
        read_mario mario_read (btnD,clock_100Mhz,x,y,mario_unit_colour,mario_x,mario_y,short);
        read_moon moon_read (clock_100Mhz,x,y,moon_unit_colour,moon_x,moon_y);
        read_monster monster_read (clock_100Mhz,x,y,monster_unit_colour,monster_x,monster_y);
        read_door door_read (clock_100Mhz,x,y,door_unit_colour,door_x,door_y);
        read_pipe pipe_read (clock_100Mhz,x,y,pipe_unit_colour,pipe_x,pipe_y);
        read_tord tord_read (clock_100Mhz,x,y,tord_unit_colour,tord_x,tord_y);
        
        read_no_moon no_moon_read (clock_100Mhz,x,y,square_unit_colour_no_moon,square_x,square_y);
        read_got_moon got_moon_read (clock_100Mhz,x,y,square_unit_colour_got_moon,square_x,square_y);
    //----------------------------------------------------------------------------------------------------------
    
    //------------------------render--------------------------------------------------
         render xian_render (
         start,
         bonus_display,
         bonus_find,
         show_moon,
         tord_on,
         hint,
         got_moon,
         btnD,
         clock_100Mhz,
         
         mario_unit_colour,
         background_unit_colour,
         btnD_hint_unit_colour,
         moon_unit_colour,
         pipe_unit_colour,
         door_unit_colour,
         tord_unit_colour,
         square_unit_colour_no_moon,
         square_unit_colour_got_moon,
         monster_unit_colour,
         bonus_unit_colour,
         
         mario_x,mario_y,

         oled_data,
         x,y);
    //------------------------------------------------------------------------------------
    
endmodule
