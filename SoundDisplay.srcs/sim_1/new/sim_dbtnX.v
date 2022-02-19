`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/24 00:25:29
// Design Name: 
// Module Name: sim_dbtnX
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


module sim_dbtnX(
    );
    reg sim_pb=0;
    reg sp_clock;
    wire sp;
    
    single_pulse_circuit test_unit(sim_pb,sp_clock,sp);
    
    initial begin
      sp_clock=0;
      #100; sim_pb = 1;
      #100; sim_pb = 0;
    end
    
    always begin
        #5; sp_clock = ~sp_clock;
    end
endmodule
