`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2021 08:03:40 PM
// Design Name: 
// Module Name: digit_display_new_version
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


module digit_display_new_version(
input display_select,
input clk_for_seg,
input [11:0] selected_signal,
output reg [3:0] anode = {4{1'b1}},
output reg [7:0] seg = 8'b11111111
    );
    reg counter = 0;
    reg [7:0] seg_ten_digit;
    reg [7:0] seg_single_digit;
   // reg timer = 0;
    
    always @(posedge clk_for_seg) begin
   
   if(display_select == 0) begin
   
   //if(timer == 0) begin
   anode <=4'b0000;
 
   if( selected_signal <=2500) begin   
   seg <= 8'b11000111;
     // timer <= 1;
   end
   
else if (selected_signal >2500 && selected_signal <=3400) begin
seg <= 8'b11101010; 
 //timer <= 1;
end

else if (selected_signal > 3400) begin
seg <= 8'b10001001;
// timer <= 1;
end
   end
   //end
   
   else  begin//with display_select
   
  
   if(counter == 0) begin 
   anode <= 4'b1101;
    seg_ten_digit <= ( selected_signal>12'd3400) ?  8'b11111001: 8'b11000000; //check whether ten_digit should be 1 or 0
  
            counter <= 1;
            seg <= seg_ten_digit;
            end
            
            else begin 
          // anode <= 4'b1110;
            if(selected_signal<2048 ||  (selected_signal>3200 && selected_signal<=3328) ) begin // 0 \\ 10
            anode <= 4'b1110;
            seg_single_digit <=8'b11000000;
                    
                       counter <= 0;
            end
            
            else if ((selected_signal>2048 && selected_signal<=2176) || (selected_signal>3328 && selected_signal<=3456)) begin // 1 \\ 11
            anode <= 4'b1110;
            seg_single_digit <=8'b11111001;
           
              counter <= 0;
            end
            
            else if ((selected_signal>2176 && selected_signal<=2304) || (selected_signal>3456 && selected_signal<=3584)) begin // 2 \\ 12
            anode <= 4'b1110;
            seg_single_digit <= 8'b10100100;
            
            counter <= 0;
            end
            
            else if( (selected_signal>2304 && selected_signal<=2432) || (selected_signal>3584 && selected_signal<=3712) ) begin // 3 \\ 13
       anode <= 4'b1110;
        seg_single_digit <=8'b10110000;
        
         counter <= 0;
        end
        
        else if ((selected_signal>2432 && selected_signal<=2560)  || (selected_signal>3712 && selected_signal<=3840)) begin // 4 \\ 14
        anode <= 4'b1110;
        seg_single_digit <=  8'b10011001;
        
          counter <= 0;
        end
        
       
        else if ((selected_signal>2560 && selected_signal<=2688) ||  (selected_signal>3840 ) ) begin // 5 \\ 15
       anode <= 4'b1110;
        seg_single_digit <= 8'b10010010;
       
          counter <= 0;
        end
        
        else if ((selected_signal>2688 && selected_signal<=2816)) begin // 6
       anode <= 4'b1110;
        seg_single_digit <= 8'b10000010;
       
          counter <= 0;
        end
        
        else if ((selected_signal>2816 && selected_signal<=2944)) begin //7
        anode <= 4'b1110;
        seg_single_digit <= 8'b11111000;
       
           counter <= 0;
        end
        
        else if ((selected_signal>2944 && selected_signal<=3072)) begin //8
        anode <= 4'b1110;
        seg_single_digit <= 8'b10000000;
      
         counter <= 0;
        end
        
        else if ((selected_signal>3072 && selected_signal<=3200)) begin //9
        anode <= 4'b1110;
        seg_single_digit <= 8'b10010000;
        
          counter <= 0;
        end
        seg <= seg_single_digit;
        end
     end
     end
       
//        always @(posedge clk_for_seg) begin
//      counter <= ~counter; // counter <= counter + 1;
//        anode[1:0] <= ~(1<< counter);
//        seg <= counter ? seg_ten_digit : seg_single_digit;
//        end
endmodule
