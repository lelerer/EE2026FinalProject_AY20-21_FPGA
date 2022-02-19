`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/28 16:10:12
// Design Name: 
// Module Name: Game1_forest
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


module Game1_forest(
    input big_start,
    input start,
    input btnL,btnR,btnC,btnU,btnD,
    input tord_on,
    input clock_10hz,clock_100Mhz,clock_3P125Mhz,
    output  [15:0]oled_data,
    input [5:0]x,
    input [6:0]y,
    input [12:0]index,
    output reg pass=0
    );
    parameter [5:0]ground1=63;
    parameter [5:0]ground2=43;
    parameter [5:0]ground3=19;
    parameter [6:0]celling1=51;
    parameter [6:0]celling2=28;
    
    wire [15:0]mario_unit_colour;
    wire [15:0]background_unit_colour;
    wire [15:0]btnD_hint_unit_colour;
    wire [15:0]moon_unit_colour;
    wire [15:0]door_unit_colour;
    wire [15:0]pipe_unit_colour;
    wire [15:0]tord_unit_colour;
    wire [15:0]square_unit_colour_no_moon;
    wire [15:0]square_unit_colour_got_moon;

    reg [5:0] mario_x = 37;
    reg [6:0] mario_y =81;
    reg [5:0]ground=ground1;
    wire short;
    reg got_moon=0;
    reg hint=0;
    reg tord=0;
    reg show_congras=0;
    reg celling=0;
    
    parameter [6:0] moon_y = 10,pipe_y=80,door_y=75,square_y=0,tord_y=15;
    parameter [5:0] moon_x = 29,pipe_x=50,door_x=5,square_x=0,tord_x=52;
    
//------------------------control position---------------------------------------------------   
    always @(posedge clock_10hz)
    begin
      if (big_start && start)begin
         ground = ground1;
         if (( mario_y >= 0  && mario_y <=41)  && mario_x+13==ground2) begin mario_x=ground2-13; ground = ground2; end
         if (  (  mario_y+10 >= 63 && mario_y<=95  )  && mario_x+13==ground3) begin mario_x=ground3-13; ground = ground3; end 
         if (mario_y >= 0  && mario_y <=95 && mario_x+13==ground1 &&~(mario_y+5 >= pipe_y && mario_y+5 <= pipe_y +11 && mario_x+13==pipe_x) ) begin mario_x=ground1-13; ground = ground1; end
         
         celling = 0;
         if (mario_y >=0 && mario_y <=40 && mario_x>=41 && mario_x <= 63) celling = celling1;
         if (mario_y+10 >=61 && mario_y+10 <= 95 && mario_x>=18 && mario_x <= 63) celling = celling2;
         
         
         if (btnL && mario_y>0 && ~(~short && mario_y-1>=0 && mario_y-1<=41 && mario_x>=42 && mario_x<=51))   mario_y = mario_y - 1;
         if (btnR && mario_y+10<94 &&  ~(~short && mario_y+1>=0 && mario_y+1<=41 && mario_x>=42 && mario_x<=51)) mario_y = mario_y + 1;
        
         if (~(mario_y+5 >= pipe_y && mario_y+5 <= pipe_y +11 && mario_x+13==pipe_x) &&  mario_x+13+1 <= ground) mario_x = mario_x+1;
         
         if (btnU && mario_x+13==ground && ~btnD) mario_x = ( mario_x>=25)? ( (mario_x-25 >= celling)? mario_x-25:celling) : 0;
         
         if (btnD && btnU && mario_x+13 == ground ) mario_x = ( mario_x >= 45)?  ( (mario_x-45 >= celling)? mario_x-45:celling) : 0;
         
         if(mario_x+5 >=29 &&  mario_x+5 <= 29+12 && mario_y >= 10 && mario_y <= 10 + 9) got_moon = 1;
         
         tord=0;
         if (mario_x+5 >= tord_x && mario_x+5 <= tord_x+11 && btnC && (mario_y >= tord_y && mario_y <= tord_y + 10 || mario_y+9 >= tord_y && mario_y <= tord_y + 10) ) tord=1;   
               
         hint=0;
         if (btnC && tord) hint=1;
         
         if(got_moon && btnC && mario_x+7 >= door_x && mario_x+7 <= door_x + 14 && mario_y>= door_y && mario_y <= door_y+14 ) show_congras=1;
         
         if(show_congras==1 && btnC) pass=1;
      end
    end
//---------------------------------------------------------------------------------------------------------
    
//------------------read mem files-----------------------------------------
    read_forest_background forest_read (clock_100Mhz,index,background_unit_colour);
    read_btnD_hint hint_read (clock_100Mhz,index,btnD_hint_unit_colour);
    
    read_mario mario_read (btnD,clock_100Mhz,x,y,mario_unit_colour,mario_x,mario_y,short);
    read_moon moon_read (clock_100Mhz,x,y,moon_unit_colour,29,10);
    read_door door_read (clock_100Mhz,x,y,door_unit_colour,5,75);
    read_pipe pipe_read (clock_100Mhz,x,y,pipe_unit_colour,50,80);
    read_tord tord_read (clock_100Mhz,x,y,tord_unit_colour,52,15);
    
    read_no_moon no_moon_read (clock_100Mhz,x,y,square_unit_colour_no_moon,0,0);
    read_got_moon got_moon_read (clock_100Mhz,x,y,square_unit_colour_got_moon,0,0);
//----------------------------------------------------------------------------------------------------------

//------------------------render--------------------------------------------------
     forest_render forest_render ( 
     show_congras,
     start,
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
     
     mario_x,mario_y,
     
     oled_data,
     x,y);
//------------------------------------------------------------------------------------
endmodule

