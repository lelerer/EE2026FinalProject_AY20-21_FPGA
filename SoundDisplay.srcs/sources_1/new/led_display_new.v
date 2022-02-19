`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2021 08:04:56 PM
// Design Name: 
// Module Name: led_display_new
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


module led_display_new(
input clk_for_led,
input [11:0] selected_signal,
output reg [15:0] led = 0
    );
    always@(posedge clk_for_led) begin
    
          if(selected_signal<2048) begin //0
          led = 16'b0;
          end
          
          else if (selected_signal>2048 && selected_signal<=2176) begin //1
          led = 16'b1;
          end
          
          else if(selected_signal>2176 && selected_signal<=2304) begin //2
          led = 16'd3;
          end
          
          else if (selected_signal>2304 && selected_signal<=2432) begin //3
           led = 16'd7;
           end 
           
          else if (selected_signal>2432 && selected_signal<=2560) begin //4
                     led = 16'd15;
                     end 
           
           else if (selected_signal>2560 && selected_signal<=2688) begin //5
                      led = 16'd31;
                      end 
                      
            else if (selected_signal>2688 && selected_signal<=2816) begin //6
                                led = 16'd63;
                                end 
           
            else if (selected_signal>2816 && selected_signal<=2944) begin //7
                          led = 16'd127;
                           end 
                           
          else if (selected_signal>2944 && selected_signal<=3072) begin //8
                                     led = 16'd255;
                                     end 
                                     
           else if (selected_signal>3072 && selected_signal<=3200) begin //9
                                               led = 16'd511;
                                               end 
          else if (selected_signal>3200 && selected_signal<=3328) begin //10
                                                         led = 16'd1023;
                                                         end       
         else if (selected_signal>3328 && selected_signal<=3456) begin //11
                           led = 16'd2047;
                          end   
         else if (selected_signal>3456 && selected_signal<=3584) begin //12
                                    led = 16'd4095;
                                    end 
        else if (selected_signal>3584 && selected_signal<=3712) begin //13
                                      led = 16'd8191;
                                       end       
         else if (selected_signal>3712 && selected_signal<=3840) begin //14
                                                 led = 16'd16383;
                                                 end
           else if (selected_signal>3840 ) begin //15
                         led = 16'd32767;
                         end
                                                                                                                                                                                                    
            end
endmodule
