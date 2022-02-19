`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/01 22:51:24
// Design Name: 
// Module Name: snake_score_display
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



module snake_score_display(
input [5:0] score,
output [6:0] seg_for_single_digit,
output [6:0] seg_for_ten_digit
    );


assign seg_for_single_digit = (score == 31) ? 7'b1111001 :
                    (score == 30) ? 7'b1000000 :
                    (score == 29) ? 7'b0010000 : 
                    (score == 28) ? 7'b0000000 :
                    (score == 27) ? 7'b1111000 :
                    (score == 26) ? 7'b0000010 :
                    (score == 25) ? 7'b0010010 : 
                    (score == 24) ? 7'b0011001 :
                    (score == 23) ? 7'b0110000 :
                    (score == 22) ? 7'b0100100 : 
                    (score == 21) ? 7'b1111001 :
                    (score == 20) ? 7'b1000000 :
                    (score == 19) ? 7'b0010000 : 
                    (score == 18) ? 7'b0000000 :
                    (score == 17) ? 7'b1111000 :
                    (score == 16) ? 7'b0000010 :
                    (score == 15) ? 7'b0010010 : 
                    (score == 14) ? 7'b0011001 :
                    (score == 13) ? 7'b0110000 :
                    (score == 12) ? 7'b0100100 : 
                    (score == 11) ? 7'b1111001 :
                    (score == 10) ? 7'b1000000 :
                    (score == 9) ? 7'b0010000 : 
                    (score == 8) ? 7'b0000000 :
                    (score == 7) ? 7'b1111000 :
                    (score == 6) ? 7'b0000010 :
                    (score == 5) ? 7'b0010010 : 
                    (score == 4) ? 7'b0011001 :
                    (score == 3) ? 7'b0110000 :
                    7'b0100100;
  
  assign seg_for_ten_digit = (score >= 30) ? 7'b0110000 :
                                        (score >= 20) ? 7'b0100100 :
                                        (score >= 10) ? 7'b1111001 :
                                        7'b1000000;
  
    
endmodule
