`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/01 22:50:34
// Design Name: 
// Module Name: snake_seg_display
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


module snake_seg_display(
input start,
input clk,
input [5:0] score,
output [3:0] anode,
output [7:0] seg
    );
    
    reg mode = 0;
    reg [3:0] anode_new;
    reg [7:0] seg_new;
    wire [6:0] seg_for_single_digit,seg_for_ten_digit;
    
    snake_score_display(.score(score),.seg_for_single_digit(seg_for_single_digit),.seg_for_ten_digit(seg_for_ten_digit));
    
    always @ (posedge clk) begin
    if (start)begin
    case (mode)
    
    0: begin 
    anode_new <= 4'b0001;
    seg_new<= seg_for_single_digit;
    mode <= ~mode;
    end
    
    1: begin
    anode_new <= 4'b0010;
    seg_new <= seg_for_ten_digit;
    mode <= ~mode;
    end
    
    endcase
    end
    end
    
    
    assign seg = seg_new;
    assign anode = ~anode_new;

endmodule

