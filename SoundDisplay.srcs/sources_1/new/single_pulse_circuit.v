`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/03/08 17:01:38
// Design Name: 
// Module Name: single_pulse_circuit
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


module single_pulse_circuit(
    input my_pb,
    input sp_clock,
    output my_sp
    );
    wire my_dff_out1, my_dff_out2;
    
    my_dff unit_1 (.D(my_pb), .dff_clock(sp_clock), .Q(my_dff_out1));
    my_dff unit_2 (.D(my_dff_out1), .dff_clock(sp_clock), .Q(my_dff_out2));
    
    assign my_sp = my_dff_out1 & ~my_dff_out2;
endmodule
