`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/01 11:31:31
// Design Name: 
// Module Name: random_num
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

module random_num(
     output reg [3:0] an = 4'b1111,
     output reg [6:0] seg = 7'b1111111,
     input [15:0]sw,
     input btnC,
     output [15:0]led,
     input clock_100Mhz,
     output reg pass=0
    );
   //reg pass=0;
   reg [15:0]seed = 16'b0000000000000000;
   wire dbtnC;
   wire clock_30hz;
  
   reg [15:0]random_num1=16'b0110011011101101;
   reg [15:0]random_num2=16'b1010010110001111;
   reg [15:0]random_num3=16'b0011110101001010;
   
   reg [1:0]count=0,count2=0;
   wire clock_381hz;
   
   assign led = seed;
   
   always @ (posedge dbtnC)
   begin
     if(~pass) begin
       seed = (random_num1 + random_num2 + random_num3)+ 100000000;
       random_num1 <= random_num1 + 1000000;
       random_num2 <= random_num2 + 1222222;
       random_num3 <= random_num3 + 3999999;
     end

     if(pass)  seed = 16'b0;
   end

   always @ (posedge clock_100Mhz)
   begin
        if  (led == sw && ~(led==16'b0) )  pass = 1;
   end
   
   always @ (posedge clock_381hz)
   begin
       if (~pass)
       begin
          count <= count+1;
          case (count)
             2'b00: begin an <= 4'b0111; seg <= 7'b1000111; end
             2'b01: begin an <= 4'b1011; seg <= 7'b1000000; end
             2'b10: begin an <= 4'b1101; seg <= 7'b1000110; end
             2'b11: begin an <= 4'b1110; seg <= 7'b0001001; end
          endcase
      end
      
       if (pass) //show 'PASS'
       begin
           count2 <=count2+1;
           case (count2)
              2'b00: begin an <= 4'b0111; seg <= 7'b0001100; end
              2'b01: begin an <= 4'b1011; seg <= 7'b0001000; end
              2'b10: begin an <= 4'b1101; seg <= 7'b0010010; end
              2'b11: begin an <= 4'b1110; seg <= 7'b0010010; end
           endcase
       end
    end
    
clock_divider clock30hz(clock_100Mhz,clock_30hz,1666666);
clock_divider clock381hz (clock_100Mhz,clock_381hz,131232); 
single_pulse_circuit my_sp_module2 (.my_pb(btnC), .sp_clock(clock_30hz), .my_sp(dbtnC));
endmodule
