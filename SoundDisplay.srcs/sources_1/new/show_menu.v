`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/02 04:03:49
// Design Name: 
// Module Name: show_menu
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
module show_menu(
input menu_on,
input [5:0]x,
input [6:0]y,
input [15:0]menu,
input clk,
input btnu,btnc,btnd,
output reg [15:0] oled_data,
output reg snake_start=0, mario_start=0, volume_start=0
    );
    reg  [1:0] counter = 2'b0 ;
    wire [2:0] mode;
    
    assign mode[0] = (x>=23 && x<=31)&& (y>=0 && y<=96); 
    assign mode[1] = (x>=35 && x<=43)&& (y>=0 && y<=96); 
    assign mode[2] = (x>=47 && x<=55)&& (y>=0 && y<=96); 

    always@(posedge clk) begin
     if (menu_on)begin
       oled_data=menu;
    
    if(btnd && counter <2 ) 
    begin
      counter = counter + 1;
    end
    
    else if(btnd && counter == 2)
    begin
      counter = 0;
    end
    
    else if(btnu && counter >0) begin
    counter = counter - 1;
    end
    
    else if (btnu && counter == 0) begin
    counter = 2;
    end
    
    case(counter)
    
    0: begin 
    oled_data = mode[0]? ~menu : menu;
    
    if(btnc) begin
     mario_start = 1;
     snake_start=0;
     volume_start=0;
     end
     end
     
    1: begin
    oled_data = mode[1]? ~menu : menu;
    if(btnc) begin
    mario_start = 0;
    volume_start = 0;
    snake_start = 1;
    end
    end
    
    2: begin
    oled_data = mode[2]? ~menu : menu;
    if(btnc) begin
    mario_start = 0;
    snake_start=0;
    volume_start = 1;
    end
    end
    endcase
    end
    end

endmodule





