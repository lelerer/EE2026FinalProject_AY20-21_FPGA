`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/28 15:51:32
// Design Name: 
// Module Name: mario_game
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

module mario_game(
    input start,
    input sw0,sw2,sw9,
    input btnL,btnR,btnC,btnU,btnD,
    input tord_on,
    input clock_10hz,clock_30hz,clock_100Mhz,clock_3P125Mhz,
    output reg [15:0]oled_data,
    input [5:0]x,
    input [6:0]y,
    input [12:0]index,
    input [11:0]mic_in
    );
    wire forest_pass, forest;
    wire concert_pass,concert;
    wire xian_pass,xian;
    wire [15:0]oled_data1,oled_data2,oled_data3;
    wire [15:0]thank_you_unit_colour;
    
    Game1_forest game1(start,forest,btnL,btnR,btnC,btnU,btnD,tord_on,clock_10hz,clock_100Mhz,clock_3P125Mhz,oled_data1,x,y,index,forest_pass);
    Game2_concert game2(start,concert,btnL,btnR,btnC,btnU,btnD,mic_in,tord_on,clock_10hz,clock_100Mhz,clock_3P125Mhz,oled_data2,x,y,index,concert_pass);
    Game3_xian game3(start,xian,sw0,sw2,sw9,btnL,btnR,btnC,btnU,btnD,tord_on,clock_10hz,clock_100Mhz,clock_3P125Mhz,oled_data3,x,y,index,xian_pass);
    
    read_thank_you thank_you_read (clock_100Mhz,index,thank_you_unit_colour);
    
    assign forest = ~forest_pass;
    assign concert = forest_pass && ~concert_pass;
    assign xian = forest_pass && concert_pass && ~xian_pass;
    
    always @ (posedge clock_100Mhz)
    begin       
     if(start) begin 
        if (forest) oled_data = oled_data1;
        if (concert) oled_data = oled_data2;
        if (xian) oled_data = oled_data3;
        if (forest_pass && concert_pass && xian_pass) oled_data = thank_you_unit_colour;        
     end 
    end
    
endmodule
