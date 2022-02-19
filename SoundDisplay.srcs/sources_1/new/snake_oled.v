`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/01 22:49:13
// Design Name: 
// Module Name: snake_oled
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




module snake_oled(
input start,
input flex_clock,
input enable,
input left_debounce, right_debounce,
input [12:0] pixel,
output [15:0] oled,
output [5:0] score
    );
    
    reg [6:0] snake_hori [0:31];
    reg [6:0] snake_verti [0:31];
    reg [1:0] direction = 0;
    reg found, hit_body;
    reg [6:0] pixel_x,pixel_y;
    reg [5:0] score_new;
    reg head,body,point,border, die, eat;
    
    integer c1,c2,c3,c4;
    
    wire [6:0] point_x,point_y;
    
    random rand(.clk(flex_clock),.start(enable),.eat(eat),.point_x(point_x),.point_y(point_y));
    
    always @(posedge flex_clock) begin
    if(start) begin
    eat = 0;
    if(left_debounce == 1)
    begin
    direction = direction - 1;
    end
    
    else if (right_debounce == 1) 
    begin
    direction = direction + 1;
    end
    
    if(enable) begin
    
    for(c1 = 0; c1<32; c1 = c1+1) begin
    snake_hori[c1] = 32;
    snake_verti[c1] = 60 + c1*2;
    score_new = 3;
    end
    direction = 0;
    end
    
    else if (~enable && ~die) begin
                for(c2 = 31; c2 > 0; c2 =c2  - 1) begin
                    snake_hori[c2] = snake_hori[c2 - 1];
                    snake_verti[c2] = snake_verti[c2 - 1];
                end
    
    case(direction)
  0: snake_verti[0] = (snake_verti[0] - 2);
  1: snake_hori[0] = (snake_hori[0] + 2);
  2: snake_verti[0] = (snake_verti[0] + 2);
  3: snake_hori[0] = (snake_hori[0] - 2);
endcase
end

 hit_body = 0;

  for(c4 = 1; c4 < score_new; c4 = c4 + 1) begin
            if (~hit_body)           
                hit_body = (snake_hori[0] == snake_hori[c4] && snake_verti[0] == snake_verti[c4]);
        end

 if (snake_hori[0] == 16 || snake_hori[0] == 78 || snake_verti[0] == 0 || snake_verti[0] == 62 || hit_body)
                    die = 1;
                else
                    die = 0;
                    
                if (snake_hori[0] == point_x && snake_verti[0] == point_y) begin
                    eat = 1;
                    if (score_new < 31)
                        score_new = score_new + 1;
                end
                else
                    eat = 0;
            end
    end
    
    always @ (*) begin
    if(start) begin
                    found = 0;
                    pixel_x = pixel%96;
                    pixel_y = pixel/96;
                    
                    for(c3 = 1; c3 < score_new; c3 = c3 + 1) begin
                        if (~found) begin                
                           body = ((pixel_x == snake_hori[c3] || pixel_x == snake_hori[c3] + 1) && (pixel_y == snake_verti[c3] || pixel_y == snake_verti[c3] + 1));
                            found = body;
                        end
                    end
                    
                    border = (pixel_x == 16 || pixel_x == 17 || pixel_x == 78 || pixel_x == 79 || ((pixel_y == 0 || pixel_y == 1 || pixel_y == 62 || pixel_y == 63) && (pixel_x > 16 && pixel_x < 78)));
                    head = ((pixel_x== snake_hori[0] || pixel_x == snake_hori[0] + 1) && (pixel_y == snake_verti[0] || pixel_y == snake_verti[0] + 1));
                    point = ((pixel_x == point_x || pixel_x == point_x + 1) && (pixel_y == point_y || pixel_y == point_y + 1));
                end
                end
                
                assign oled =  border ? 16'b0000000000011111 :
                                    (body || head) ? (die ? 16'b1111111111111111 : 16'b0000011111100000) :
                                    point ? 16'b1111100000000000 : 16'b0;
                assign score = score_new;
         
                
endmodule

