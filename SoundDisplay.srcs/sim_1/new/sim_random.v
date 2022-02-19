`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/01 22:21:44
// Design Name: 
// Module Name: sim_random
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


module sim_random(
    );
    wire [3:0] an;
    wire [6:0] seg;
    reg [15:0]sw=0;
    reg btnC=0;
    wire [15:0]led;
    reg clock_100Mhz;

    random_num test_unit (an,seg,sw,btnC,led,clock_100Mhz);
    
initial begin
        clock_100Mhz = 1;
        #500 btnC=1;
        #1500 sw=16'h4a2a;
end

always begin
    #5 clock_100Mhz= ~clock_100Mhz;
end
endmodule
