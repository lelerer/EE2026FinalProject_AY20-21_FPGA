`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2021 08:00:24 PM
// Design Name: 
// Module Name: intensity_new
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


module intensity_new(
input clk_for_led,
input display_select,
input clk,
input clk_for_seg, // clock for segment display
input toggle_indicate, //signal from sw[0]
input [11:0] mic_in,
output [15:0] led,
output [3:0] anode,
output  [7:0] seg,
//output reg [3:0] vol_num //volume ranges from 0 to 15
output reg [11:0] vol_peak
    );
    
 reg [11:0] vol_max = 0;
   
       wire [11:0] selected_signal;
       reg [13:0] counter = 0;
       wire [15:0] led_show_peak; //indicate which led will be used to display peak
       wire clk_20k;
       
    //   assign seg[7] = 1; //do not show decimal point
       
       
       
       always@(posedge clk) begin
       counter <= (counter == 14'd5000)? 0 : counter + 1;
       
       vol_max <= ( counter == 0) ? mic_in : ( (mic_in > vol_max) ? mic_in: vol_max); //get the sampe data (this is peak algo)
       
       //vol_num <= (vol_max[11]) ? vol_max[10:7] : 0; //take first four bits of vol_max
       
       vol_peak <= vol_max; //vol_peak is the data from peak alogorithm
       end
       
       //my_clock_divider unit_clk_20k_1(.basys_clock(clk),.my_new_clock(clk_20k),.m_value(2499)); //set a 20khz clk
       
       digit_display_new_version unit_dd (.display_select(display_select),.clk_for_seg(clk_for_seg),.anode(anode),.selected_signal(selected_signal),.seg(seg));
       
      // led_display unit_ld (.vol_num(vol_num),.led(led_show_peak));
       led_display_new unit_ld (.selected_signal(selected_signal),.led(led),.clk_for_led(clk_for_led));
       
       mux_new unit_mux (.toggle_indicate(toggle_indicate),.mic_in(mic_in),.vol_peak(vol_peak),.selected_signal(selected_signal));
       //prof said  {4'b0, mic_in} should not be used !!!!!
   endmodule

