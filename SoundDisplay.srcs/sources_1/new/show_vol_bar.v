`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/01 23:48:27
// Design Name: 
// Module Name: show_vol_bar
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


module show_vol_bar(
input display_select,
input toggle_indicate,
input clk_20k,
input clk_for_seg,
       input [12:0]pixel_index,
       input [11:0]mic_in,
       input vol_bar_start,
       output [15:0]led,
       input sw0,//sw[0] to choose modes
       output [7:0]seg,
       output [3:0]an,
      // input HML,
       input clk_for_led,
       input btnL,btnR,
       input clock_100Mhz,
      
       input boarder_on, //controlled by sw[15]
       input show_volumn,//controllled by sw[14]
       input show_other, //controlled by sw[13]
       input RGB,//controlled by sw[11]
       input thick_boarder, //sw[12] will control this input, and 3 pixels when equal to 1, 1 pixel when equal to 0
       output reg [15:0] oled_data,
       output [11:0] vol_peak
);
   wire [5:0]x;
   wire [6:0]y;

   reg [6:0]right_volumn_bar=58;
   reg [6:0]left_volumn_bar=38;

   wire [15:0]oled_background_unit_colour;
   wire [15:0]bg2_unit_colour;
   reg [15:0]red_boarder [0:6143];
   
   wire clock_10hz;
   wire clock_30hz;
   wire clock_3P125Mhz;
    
          initial
          begin
               $readmemh ("boarder.mem",red_boarder);
           end 
    
          always @ (posedge clock_30hz)
          begin
            if (btnL==1) 
            if (left_volumn_bar > 3  && btnL==1) 
              begin 
                left_volumn_bar = left_volumn_bar-1; right_volumn_bar = right_volumn_bar-1; 
              end
              
            if (btnR==1)
             if (left_volumn_bar < 72 && btnR==1) 
                begin 
                  left_volumn_bar = left_volumn_bar+1; right_volumn_bar = right_volumn_bar+1; 
                end
          end
         
          always @ (posedge clock_3P125Mhz)
            begin
                if(show_other && RGB) oled_data=oled_background_unit_colour;
                else if(show_other && ~RGB) oled_data=bg2_unit_colour;
                else oled_data=16'b0;      
                
                if(thick_boarder  &&  boarder_on )
                begin
                   if( x<3 || x>60 || y<3 || y>92)
                     if (RGB) oled_data = red_boarder[pixel_index];
                     else oled_data = ~red_boarder[pixel_index];
                end
                
                if(~thick_boarder && boarder_on)
                begin
                   if( x<1 || x> 62 || y<1 || y>94 )
                      if (RGB) oled_data=16'b1111111111111111;
                      else oled_data=16'b0000011111100000;
                end
                
                if(show_volumn && RGB)
                begin
                      if(  y>=left_volumn_bar &&  y<= right_volumn_bar)
                      begin
                          if ( x>=8 && x <=9 && led>=16'b1111111111111111) oled_data=16'b1111100000000000;
                          if ( x>=11 && x <=12 && led>=16'b0111111111111111 ) oled_data=16'b1111100000000000;
                          if ( x>=14 && x <=15 && led>=16'b0011111111111111 ) oled_data=16'b1111100000000000;
                          if ( x>=17 && x <=18 && led>=16'b0001111111111111 ) oled_data=16'b1111100000000000;
                          if ( x>=20 && x <=21 && led>=16'b0000111111111111 ) oled_data=16'b1111100000000000;
                          
                          if ( x>=23 && x <=24 && led>=16'b0000011111111111 ) oled_data=16'b1111111111100000;
                          if ( x>=26 && x <=27 && led>=16'b0000001111111111 ) oled_data=16'b1111111111100000;
                          if ( x>=29 && x <=30 && led>=16'b0000000111111111 ) oled_data=16'b1111111111100000;
                          if ( x>=32 && x <=33 && led>=16'b0000000011111111 ) oled_data=16'b1111111111100000;
                          if ( x>=35 && x <=36 && led>=16'b0000000001111111 ) oled_data=16'b1111111111100000;
                          
                          if ( x>=38 && x <=39 && led>=16'b0000000000111111) oled_data=16'b0000011111100000;                      
                          if ( x>=41 && x <=42 && led>=16'b0000000000011111) oled_data=16'b0000011111100000;
                          if ( x>=44 && x <=45 && led>=16'b0000000000001111) oled_data=16'b0000011111100000;
                          if ( x>=47 && x <=48 && led>=16'b0000000000000111) oled_data=16'b0000011111100000;
                          if ( x>=50 && x <=51 && led>=16'b0000000000000011) oled_data=16'b0000011111100000;
                          if ( x>=53 && x <=54 && led>=16'b0000000000000001) oled_data=16'b0000011111100000;                     
                      end
                end
                
                if (show_volumn && ~RGB)
                begin
                      if(  y>=left_volumn_bar &&  y<= right_volumn_bar)
                      begin
                          if ( x>=8 && x <=9 && led>=16'b1111111111111111) oled_data=16'b0000000000001111;
                          if ( x>=11 && x <=12 && led>=16'b0111111111111111) oled_data=16'b0000000000001111;
                          if ( x>=14 && x <=15 && led>=16'b0011111111111111) oled_data=16'b0000000000001111;
                          if ( x>=17 && x <=18 && led>=16'b0001111111111111) oled_data=16'b0000000000001111;
                          if ( x>=20 && x <=21 && led>=16'b0000111111111111) oled_data=16'b0000000000001111;
                          
                          if ( x>=23 && x <=24 && led>=16'b0000011111111111) oled_data=16'b0000000000011111;
                          if ( x>=26 && x <=27 && led>=16'b0000001111111111) oled_data=16'b0000000000011111;
                          if ( x>=29 && x <=30 && led>=16'b0000000111111111) oled_data=16'b0000000000011111;
                          if ( x>=32 && x <=33 && led>=16'b0000000011111111) oled_data=16'b0000000000011111;
                          if ( x>=35 && x <=36 && led>=16'b0000000001111111) oled_data=16'b0000000000011111;
                          
                          if ( x>=38 && x <=39 && led>=16'b0000000000111111) oled_data=16'b111111111111111; 
                          if ( x>=41 && x <=42 && led>=16'b0000000000011111) oled_data=16'b111111111111111;
                          if ( x>=44 && x <=45 && led>=16'b0000000000001111) oled_data=16'b111111111111111;
                          if ( x>=47 && x <=48 && led>=16'b0000000000000111) oled_data=16'b111111111111111;
                          if ( x>=50 && x <=51 && led>=16'b0000000000000011) oled_data=16'b111111111111111;
                          if ( x>=53 && x <=54 && led>=16'b0000000000000001) oled_data=16'b111111111111111;                        
                      end
                end
            end  
          
//------------------------load pictures---------------------------------------------------------    
  read_oled_background oled_background(clock_100Mhz,pixel_index,oled_background_unit_colour);
 //---------------------------------------------------------------------------------------------
 
 //----------------------mic intensity--------------------------------
read_bg2 bg2_read (clock_100Mhz,pixel_index,bg2_unit_colour);
 intensity_new unit_in (.clk_for_led(clk_for_led),.display_select(display_select),.clk(clk_20k),.clk_for_seg(clk_for_seg),.toggle_indicate(toggle_indicate),.mic_in(mic_in),.led(led),.anode(an),.seg(seg),.vol_peak(vol_peak));
 //intensity unit_in (.HML(HML),.clock_100Mhz(clock_100Mhz),.toggle_indicator(sw),.mic_in(mic_in),.led(led),.an(an),.seg(seg) );
 //------------------------------------------------------------------  
 
//---------------convert pixel value---------------
convert_index index_convert(pixel_index,x,y);
//--------------------------------------------------            

clock_divider clock3P125Mhz (clock_100Mhz,clock_3P125Mhz,15); 
clock_divider clock10hz (clock_100Mhz,clock_10hz,4999999); 
clock_divider clock30hz(clock_100Mhz,clock_30hz,1666666);
 
   
endmodule
