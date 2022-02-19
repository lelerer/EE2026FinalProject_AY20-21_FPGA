`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//
//  LAB SESSION DAY (Delete where applicable): MONDAY P.M, TUESDAY P.M, WEDNESDAY P.M, THURSDAY A.M., THURSDAY P.M
//
//  STUDENT A NAME: 
//  STUDENT A MATRICULATION NUMBER: 
//
//  STUDENT B NAME: 
//  STUDENT B MATRICULATION NUMBER: 
//
//////////////////////////////////////////////////////////////////////////////////

module Top_Student (
    input  J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
    output J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
    output J_MIC3_Pin4,    // Connect to this signal from Audio_Capture.v
    output pmodoledrgb_cs,pmodoledrgb_sdin,pmodoledrgb_sclk,pmodoledrgb_d_cn,pmodoledrgb_resn,pmodoledrgb_vccen,pmodoledrgb_pmoden,
    
    output reg [15:0]led,
    output  reg [7:0]seg,
    output  reg [3:0]an,

    
    input sw0,sw1,//sw[0] to choose modes
    input btnL,btnR,btnC,btnU,btnD,
    input tord_on, //controlled by sw[10]
    input clock_100Mhz,
    input boarder_on, //controlled by sw[15]
    input show_volumn,//controllled by sw[14]
    input show_other, //controlled by sw[13]
    input RGB,//controlled by sw[11]
    input thick_boarder,  //sw[12] will control this input, and 3 pixels when equal to 1, 1 pixel when equal to 0
    input sw2,sw9,
    input game_start,
    input sw7,sw6,sw5,sw4,sw3  //sw6-sw3 in constrains;
    );
    wire clock_6P25Mhz,clock_3P125Mhz,clock_30hz,clock_10hz,clk_20k,clk_10k,clk_381hz,clk_20hz;
    wire dbtnC,dbtnL,dbtnR,dbtnU,dbtnD;
    
    reg [15:0] oled_data= 16'h07E0;
    
    wire [11:0] vol_peak;
    wire [15:0] welcome_oled_data;
    wire [11:0] mic_in;
    
    wire frame_begin,sending_pixels,sample_pixel;
    wire [12:0] pixel_index;
    wire [4:0]teststate;
    
    wire [5:0]x;
    wire [6:0]y;
    
    wire [3:0]snake_an;
    wire [7:0]snake_seg;
    wire [15:0]snake_game_oled_data;

    wire [15:0] menu_oled_data;
    wire [15:0] menu;
    
    wire [3:0]vol_an;
    wire [7:0]vol_seg;
    wire [15:0] vol_oled_data;
    wire [15:0] vol_led;
    
    wire [15:0] mario_oled_data;
    
    wire snake_game_start;
    wire mario_game_start;
    wire vol_bar_start;

    wire [3:0] pw_an;
    wire [7:0] pw_seg;
    wire [15:0]pw_led;
   
    reg [2:0]btn;
    reg menu_on = 0;
    
    wire display_select = sw1;
    wire toggle_indicate = sw0;
    wire pass;    
    always @ (posedge clock_100Mhz)
    begin
        btn = {btnR,btnL,btnU};
        menu_on = 0;
        oled_data = 16'b0000000000000000;
        
        if (~pass)
        begin
              oled_data = welcome_oled_data;
              seg = {1'b0,pw_seg};
              an =  pw_an;
              led = pw_led;
        end
        
        if (pass)
        begin
            menu_on = 1;
            seg = 8'b11111111;
            an = 4'b1111;
            oled_data = menu_oled_data;
            led = 16'b0;
        end
        
        if ( (vol_bar_start && ~game_start) && pass)
        begin
            menu_on = 0;
            oled_data = vol_oled_data;
            seg = vol_seg;
            an =  vol_an;
            led = vol_led;
        end
        
        if ( (mario_game_start && ~game_start ) && pass)
        begin 
           menu_on = 0;
           oled_data = mario_oled_data;
           seg = 8'b11111111;
           an =  4'b1111;
           led = 16'b0;          
        end
        
        if ((snake_game_start && ~game_start) && pass)
                begin 
                   menu_on = 0;
                   seg = snake_seg;
                   an =  snake_an;
                   led = 16'b0; 
                   oled_data = snake_game_oled_data;      
                end  
                
        if (pass && ~snake_game_start && ~mario_game_start && ~vol_bar_start && game_start)
                begin
                    menu_on = 1;
                    seg = 8'b11111111;
                    an = 4'b1111;
                    oled_data = menu_oled_data;
                    led = 16'b0;
                end
       end

 random_num enter_pw(pw_an,pw_seg,
 {boarder_on,show_volumn,show_other,thick_boarder,RGB,tord_on,sw9,game_start,sw7,sw6,sw5,sw4,sw3,sw2,sw1,sw0},
 btnC,pw_led,clock_100Mhz,pass);
//---------------------------main stuff---------------------------------------------------------------------
 show_vol_bar  show_vol( display_select,toggle_indicate,clk_20k,clk_381hz,pixel_index,mic_in,vol_bar_start,vol_led,sw0,vol_seg,vol_an,clk_20hz, btnL,btnR,clock_100Mhz,boarder_on,show_volumn,show_other,RGB,thick_boarder,vol_oled_data,vol_peak);
 
 mario_game game_mario(.start(mario_game_start),.mic_in(mic_in),.sw0(sw0),.sw2(sw2),.sw9(sw9),.tord_on(tord_on),.clock_10hz(clock_10hz),.clock_100Mhz(clock_100Mhz),.clock_3P125Mhz(clock_3P125Mhz),.btnC(btnC),.btnL(btnL),.btnR(btnR),.btnU(btnU),.btnD(btnD),.oled_data(mario_oled_data),.x(x),.y(y),.index(pixel_index));
 snake unit_s (.start(snake_game_start),.clk(clock_100Mhz),.btn(btn),.pixel(pixel_index),.switch({sw6,sw5,sw4,sw3}),.anode(snake_an),.seg(snake_seg),.oled(snake_game_oled_data));
read_welcome welcome_read (clock_100Mhz,pixel_index,welcome_oled_data);
read_menu menu_read (clock_100Mhz,pixel_index,menu);
//------------------------------------------------------------------------------------------------

//---------------convert pixel value---------------
convert_index index_convert(pixel_index,x,y);
//--------------------------------------------------       

//------------generate clocks----------------
clock_divider clock_381hz(.basys_clock(clock_100Mhz),.new_clock(clk_381hz),.m(131233));
     clock_divider clock6P25Mhz (clock_100Mhz,clock_6P25Mhz,7); 
     clock_divider clock3P125Mhz (clock_100Mhz,clock_3P125Mhz,15); 
     clock_divider clock10hz (clock_100Mhz,clock_10hz,4999999); 
     clock_divider clock30hz(clock_100Mhz,clock_30hz,1666666);
     clock_divider clock20hz (clock_100Mhz,clk_20hz,2499999); 
     my_clock_divider_audio unit_clk_20k(.basys_clock(clock_100Mhz),.my_new_clock(clk_20k),.m_value(2499));
     my_clock_divider_audio unit_clk_100(.basys_clock(clock_100Mhz),.my_new_clock(clk_10k),.m_value(4999));
 //--------------------------------------------    

 //----------------instantiation-----------------
   Audio_Capture unit_my_audio_cap(.CLK(clock_100Mhz), .cs(clk_20k),.MISO(J_MIC3_Pin3),.clk_samp(J_MIC3_Pin1), .sclk(J_MIC3_Pin4),.sample(mic_in));
   Oled_Display  Oled_display (.clk(clock_6P25Mhz), .reset(0),.frame_begin(frame_begin), .sending_pixels(sending_pixels),.sample_pixel(sample_pixel),
     .pixel_index(pixel_index), .pixel_data(oled_data), .cs(pmodoledrgb_cs), .sdin(pmodoledrgb_sdin),.sclk(pmodoledrgb_sclk), .d_cn(pmodoledrgb_d_cn),
     .resn(pmodoledrgb_resn), .vccen(pmodoledrgb_vccen), .pmoden(pmodoledrgb_pmoden), .teststate(teststate));
 //--------------------------------------------------

//------------generate single pulse------------------
   single_pulse_circuit my_sp_module0 (.my_pb(btnL), .sp_clock(clock_30hz), .my_sp(dbtnL));
   single_pulse_circuit my_sp_module1 (.my_pb(btnR), .sp_clock(clock_30hz), .my_sp(dbtnR));
   single_pulse_circuit my_sp_module2 (.my_pb(btnC), .sp_clock(clock_30hz), .my_sp(dbtnC));
   single_pulse_circuit my_sp_module3 (.my_pb(btnU), .sp_clock(clock_30hz), .my_sp(dbtnU));
   single_pulse_circuit my_sp_module4 (.my_pb(btnD), .sp_clock(clock_30hz), .my_sp(dbtnD));
   
//---------------------------------------------------
show_menu menu_show (.menu_on(menu_on),.menu(menu),.clk(clock_100Mhz),.btnu(dbtnU),.btnc(dbtnC),.btnd(dbtnD),.oled_data(menu_oled_data),.snake_start(snake_game_start),.mario_start(mario_game_start),.volume_start(vol_bar_start),.x(x),.y(y));




endmodule
