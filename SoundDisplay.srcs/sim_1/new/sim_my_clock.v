`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/08 14:33:54
// Design Name: 
// Module Name: sim_my_clock
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


module sim_my_clock();
      reg sim_basys_clock;
      wire sim_new_clock;
      
      clock_divider f0 (sim_basys_clock, sim_new_clock);
      
      initial 
      begin
        sim_basys_clock = 0;
      end
      
      always
      begin
       #5 sim_basys_clock = ~sim_basys_clock;
      end
      
endmodule
