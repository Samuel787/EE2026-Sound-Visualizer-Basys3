`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2019 02:36:13
// Design Name: 
// Module Name: theme_selector
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


module theme_selector(input clk_80hz, input btnU, input btnD, input btnL, input btnR, input btnC, 
    input sw2,
    input sw3,
    input sw4,
    input sw5,
    input sw6,
    input sw_e,
    input sw11,
    input sw15,
    input sw14,
    input sw13,
    input [11:0] max_wave,
    output reg [3:0] wave_red,
    output reg [3:0] wave_green,
    output reg [3:0] wave_blue,
    output reg [3:0] sub_grid_red,
    output reg [3:0] sub_grid_green,
    output reg [3:0] sub_grid_blue,
    output reg [3:0] ticks_red,
    output reg [3:0] ticks_green,
    output reg [3:0] ticks_blue,
    output reg [3:0] main_grid_red,
    output reg [3:0] main_grid_green,
    output reg [3:0] main_grid_blue,
    output reg [3:0] bg_red,
    output reg [3:0] bg_green,
    output reg [3:0] bg_blue);
    
    /* 
        |MAPPING
        |BTN | FUNCTION
        ===   ========
        |U   | WAVE
        |R   | SUB GRID
        |D   | TICKS
        |L   | MAIN GRID
        |C   | BACKGROUND 
    */
    wire btn_u, btn_r, btn_l, btn_c, btn_d;
    single_pulse pulse_up(clk_80hz, btnU, btn_u);
    single_pulse pulse_down(clk_80hz, btnD,btn_d);
    single_pulse pulse_left(clk_80hz, btnL, btn_l);
    single_pulse pulse_right(clk_80hz, btnR, btn_r);
    single_pulse pulse_center(clk_80hz, btnC, btn_c);
    
    
    reg[2:0] count_main_grid, count_sub_grid, count_ticks, count_bg, count_wave;
    initial begin
        count_main_grid = 0;
        count_sub_grid = 0;
        count_ticks = 0;
        count_bg = 0;
        count_wave = 0;
    end
    always @(posedge clk_80hz) begin
        if(btn_u && !sw2 && !sw11) count_wave = (count_wave == 4) ? 0 : count_wave + 1;
        if(btn_r && !sw2 && !sw11) count_sub_grid = (count_sub_grid == 4) ? 0 : count_sub_grid + 1;
        if(btn_d && !sw2 && !sw11) count_ticks = (count_ticks == 4) ? 0 : count_ticks + 1;
        if(btn_l && !sw2 && !sw11) count_main_grid = (count_main_grid == 4) ? 0 : count_main_grid + 1;
        if(btn_c && !sw2 && !sw11) count_bg = (count_bg == 4) ? 0 : count_bg + 1;
               
         //MUX FOR WAVE COLOR
               if(sw15 && sw14 && !sw13 && !sw2)
                    begin
                        if(max_wave <= 2000)
                                       begin //blue
                                           wave_red = 4'h0;
                                           wave_green = 4'h0;
                                           wave_green = 4'hF;    
                                       end
                                    else if(max_wave <= 2100)
                                       begin //purple
                                           wave_red = 4'hB;
                                           wave_green = 4'h6;
                                           wave_blue = 4'hF;
                                       end
                                    else if(max_wave <= 2200)
                                       begin
                                                           wave_red = 4'hC;
                                       wave_green = 4'hD;
                                       wave_blue = 4'hE;     
                                       end
                                    else if(max_wave <=2400)
                                       begin
                                                           wave_red = 4'hF;
                                       wave_green = 4'h6;
                                       wave_blue = 4'h3;
                                       end
                                    else if(max_wave <= 2560)
                                       begin
                                                           wave_red = 4'h0;
                                       wave_green = 4'h7;
                                       wave_blue = 4'ha;
                                       end
                                    else if(max_wave <= 2700)
                                       begin
                                                           wave_red = 4'h1;
                                       wave_green = 4'h6;
                                       wave_blue = 4'hd;
                                       end
                                    else if(max_wave <=3000)
                                       begin
                                                           wave_red = 4'h4;
                                       wave_green = 4'h7;
                                       wave_blue = 4'h0;
                                       end
                    end
               else if(sw_e)
                   begin //current background color
                       wave_red = bg_red;
                       wave_green = bg_green;
                       wave_blue = bg_blue;
                   end 
               else if(count_wave == 0)
                   begin //white 
                       wave_red = 4'hB;
                       wave_green = 4'h6;
                       wave_blue = 4'hF;
                   end
               else if(count_wave == 1)
                   begin //yellow
                       wave_red = 4'hF;
                       wave_green = 4'hF;
                       wave_blue = 4'h6;
                   end
               else if(count_wave == 2)
                   begin //magenta
                       wave_red = 4'h2;
                       wave_green = 4'hF;
                       wave_blue = 4'h6;
                   end
               else if(count_wave == 3)
                   begin //blue
                       wave_red = 4'hF;
                       wave_green = 4'hF;
                       wave_blue = 4'hF;
                   end
               else if(count_wave == 4)
                   begin //Pink
                       wave_red = 4'h4;
                       wave_green = 4'hC;
                       wave_blue = 4'hF;
                   end
               else 
                   begin //Red
                       wave_red = 4'hF;
                       wave_green = 4'h0;
                       wave_blue = 4'h0;
                   end 
               
               
              //MUX FOR SUB GRID
              
              if(sw3)
                  begin //current background color
                      sub_grid_red = bg_red;
                      sub_grid_green = bg_green;
                      sub_grid_blue = bg_blue;
                  end 
              else if(count_sub_grid == 0)
                              begin  //Blue (not light enough)
                  sub_grid_red = 4'h2;
                  sub_grid_green = 4'hF;
                  sub_grid_blue = 4'hF;
                   end
              else if(count_sub_grid == 1)
                              begin //Green(bright green)
                  sub_grid_red = 4'hF;
                  sub_grid_green = 4'hF;
                  sub_grid_blue = 4'h5;
              end
              else if(count_sub_grid == 2)
                              begin //Yellow (bright yellow)
                  sub_grid_red = 4'hF;
                  sub_grid_green = 4'hF;
                  sub_grid_blue = 4'hF;
              end
              else if(count_sub_grid == 3)
                              begin //Black(Camouflages with black background)
                  sub_grid_red = 4'hF;
                  sub_grid_green = 4'h8;
                  sub_grid_blue = 4'h0;
              end
              else if(count_sub_grid == 4)
                              begin //White
                  sub_grid_red = 4'hF;
                  sub_grid_green = 4'h0;
                  sub_grid_blue = 4'hE;
              end
              else 
                  begin //Red
                      sub_grid_red = 4'hF;
                      sub_grid_green = 4'h0;
                      sub_grid_blue = 4'h0;
                  end 
              
              
              //MUX FOR TICKS
       
              if(sw4)
                  begin //current background color
                      ticks_red = bg_red;
                      ticks_green = bg_green;
                      ticks_blue = bg_blue;
                  end 
              else if(count_ticks == 0)
                              begin // Red
                  ticks_red = 4'h0;
                  ticks_green = 4'h9;
                  ticks_blue = 4'h1;
              end
              else if(count_ticks == 1)
                              begin //Green
                  ticks_red = 4'hF;
                  ticks_green = 4'h0;
                  ticks_blue = 4'h0;
              end
              else if(count_ticks == 2)
                              begin //Lime
                  ticks_red = 4'hF;
                  ticks_green = 4'h7;
                  ticks_blue = 4'h0;
              end
              else if(count_ticks == 3)
                              begin //Purple
                  ticks_red = 4'hE;
                  ticks_green = 4'hF;
                  ticks_blue = 4'h4;
              end
              else if(count_ticks == 4)
                  begin //Cyan
                  ticks_red = 4'hC;
                  ticks_green = 4'h4;
                  ticks_blue = 4'hF;
              end
              else 
                              begin //red
                  ticks_red = 4'hF;
                  ticks_green = 4'h0;
                  ticks_blue = 4'h0;
              end  

             //MUX FOR MAIN GRID
             
               if(sw5)
                      begin //current background color
                          main_grid_red = bg_red;
                          main_grid_green = bg_green;
                          main_grid_blue = bg_blue;
                      end 
                  else if(count_main_grid == 0)
                             begin //Blue (good)
                      main_grid_red = 4'h1;
                      main_grid_green = 4'hB;
                      main_grid_blue = 4'h1;
                  end
                  else if(count_main_grid == 1)
                             begin //Green 
                      main_grid_red = 4'hF;
                      main_grid_green = 4'h9;
                      main_grid_blue = 4'h1;
                  end
                  else if(count_main_grid == 2)
                             begin //Yellow
                      main_grid_red = 4'h1;
                      main_grid_green = 4'h1;
                      main_grid_blue = 4'hF;
                  end
                  else if(count_main_grid == 3)
                             begin //Magenta
                      main_grid_red = 4'hE;
                      main_grid_green = 4'hF;
                      main_grid_blue = 4'h0;
                  end
                  else if(count_main_grid == 4)
                             begin //Nice pink
                      main_grid_red = 4'hF;
                      main_grid_green = 4'h0;
                      main_grid_blue = 4'hE;
                  end
                  else 
                     begin
                      main_grid_red = 4'hF;
                      main_grid_green = 4'h0;
                      main_grid_blue = 4'h0;
                  end  
                  
               
                    
                    
              //MUX FOR BACKGROUND   
              if(sw6)
                begin
                                                      bg_red = 4'h0;
                bg_green = 4'h0;
                bg_blue = 4'h0;
                end   
              else if(count_bg == 0)
                 begin
                                                      bg_red = 4'h0;
                 bg_green = 4'h0;
                 bg_blue = 4'h0;
                 end
              else if(count_bg == 1)
                begin
                                                      bg_red = 4'hF;
                bg_green = 4'h8;
                bg_blue = 4'h4;
                end
              else if(count_bg == 2)
                begin
                                                      bg_red = 4'h1;
                bg_green = 4'h6;
                bg_blue = 4'h0;
                end
              else if(count_bg == 3)
                begin
                                                      bg_red = 4'h0;
                bg_green = 4'h1;
                bg_blue = 4'h6;
                end
              else if(count_bg == 4)
                begin
                                                      bg_red = 4'h6;
                bg_green = 4'h1;
                bg_blue = 4'h1;
                end
              else
                begin
                                                      bg_red = 4'h0;
bg_green = 4'h0;
bg_blue = 4'h0;                
                end
               
               /*
              case(count_bg)
                          0:
                              begin //Black
                                  bg_red = 4'h0;
                                  bg_green = 4'h0;
                                  bg_blue = 4'h0;
                              end
                          1:
                              begin //Magenta
                                  bg_red = 4'hF;
                                  bg_green = 4'h8;
                                  bg_blue = 4'h4;
                              end
                          2:  
                              begin //dullish cyan
                                  bg_red = 4'h1;
                                  bg_green = 4'h6;
                                  bg_blue = 4'h0;
                              end
                          3:
                              begin //Blue
                                  bg_red = 4'h0;
                                  bg_green = 4'h1;
                                  bg_blue = 4'h6;
                              end
                          4:
                              begin //Grey
                                  bg_red = 4'h6;
                                  bg_green = 4'h1;
                                  bg_blue = 4'h1;
                              end
                          default:
                              begin //
                                  bg_red = 4'hF;
                                  bg_green = 4'h0;
                                  bg_blue = 4'h0;
                              end     
                     endcase
        */

        
        
        

        
        
        /*
        //MUX FOR WAVE COLOR
        if(sw6)
            begin //current background color
                wave_red = bg_red;
                wave_green = bg_green;
                wave_blue = bg_blue;
            end 
        else if(count_wave == 0)
            begin //white 
                wave_red = 4'hF;
                wave_green = 4'hF;
                wave_blue = 4'hF;
            end
        else if(count_wave == 1)
            begin //yellow
                wave_red = 4'hF;
                wave_green = 4'hF;
                wave_blue = 4'h0;
            end
        else if(count_wave == 2)
            begin //magenta
                wave_red = 4'hF;
                wave_green = 4'h0;
                wave_blue = 4'hF;
            end
        else if(count_wave == 3)
            begin //blue
                wave_red = 4'h3;
                wave_green = 4'h2;
                wave_blue = 4'hF;
            end
        else if(count_wave == 4)
            begin //Pink
                wave_red = 4'hF;
                wave_green = 4'h5;
                wave_blue = 4'hF;
            end
        else 
            begin //Red
                wave_red = 4'hF;
                wave_green = 4'h0;
                wave_blue = 4'h0;
            end 
        
        
        
        case(count_wave)
            0:
                begin //white
                    wave_red = 4'hF;
                    wave_green = 4'hF;
                    wave_blue = 4'hF;
                end
            1:
                begin //yellow
                    wave_red = 4'hF;
                    wave_green = 4'hF;
                    wave_blue = 4'h0;
                end
            2:  
                begin  //Magenta
                    wave_red = 4'hF;
                    wave_green = 4'h0;
                    wave_blue = 4'hF;
                end
            3:
                begin //Blue
                    wave_red = 4'h3;
                    wave_green = 4'h2;
                    wave_blue = 4'hF;
                end
            4:
                begin //Pink
                    wave_red = 4'hF;
                    wave_green = 4'h5;
                    wave_blue = 4'hF;
                end
            default:
                begin //Red
                    wave_red = 4'hF;
                    wave_green = 4'h0;
                    wave_blue = 4'h0;
                end     
       endcase
       
       //MUX FOR SUB GRID
       
       if(sw3)
           begin //current background color
               sub_grid_red = bg_red;
               sub_grid_green = bg_green;
               sub_grid_blue = bg_blue;
           end 
       else if(count_sub_grid == 0)
                       begin  //Blue (not light enough)
           sub_grid_red = 4'h0;
           sub_grid_green = 4'h0;
           sub_grid_blue = 4'hD;
            end
       else if(count_sub_grid == 1)
                       begin //Green(bright green)
           sub_grid_red = 4'h0;
           sub_grid_green = 4'hD;
           sub_grid_blue = 4'h0;
       end
       else if(count_sub_grid == 2)
                       begin //Yellow (bright yellow)
           sub_grid_red = 4'hD;
           sub_grid_green = 4'hD;
           sub_grid_blue = 4'h0;
       end
       else if(count_sub_grid == 3)
                       begin //Black(Camouflages with black background)
           sub_grid_red = 4'h0;
           sub_grid_green = 4'h0;
           sub_grid_blue = 4'h0;
       end
       else if(count_sub_grid == 4)
                       begin //White
           sub_grid_red = 4'hF;
           sub_grid_green = 4'hF;
           sub_grid_blue = 4'hF;
       end
       else 
           begin //Red
               sub_grid_red = 4'hF;
               sub_grid_green = 4'h0;
               sub_grid_blue = 4'h0;
           end 
       
       
       
       case(count_sub_grid)
                   0:
                       begin  //Blue (not light enough)
                           sub_grid_red = 4'h0;
                           sub_grid_green = 4'h0;
                           sub_grid_blue = 4'hD;
                       end
                   1:
                       begin //Green(bright green)
                           sub_grid_red = 4'h0;
                           sub_grid_green = 4'hD;
                           sub_grid_blue = 4'h0;
                       end
                   2:  
                       begin //Yellow (bright yellow)
                           sub_grid_red = 4'hD;
                           sub_grid_green = 4'hD;
                           sub_grid_blue = 4'h0;
                       end
                   3:
                       begin //Black(Camouflages with black background)
                           sub_grid_red = 4'h0;
                           sub_grid_green = 4'h0;
                           sub_grid_blue = 4'h0;
                       end
                   4:
                       begin //White
                           sub_grid_red = 4'hF;
                           sub_grid_green = 4'hF;
                           sub_grid_blue = 4'hF;
                       end
                   default:
                       begin //
                           sub_grid_red = 4'hF;
                           sub_grid_green = 4'h0;
                           sub_grid_blue = 4'h0;
                       end     
              endcase
       
       //MUX FOR TICKS

       if(sw3)
           begin //current background color
               ticks_red = bg_red;
               ticks_green = bg_green;
               ticks_blue = bg_blue;
           end 
       else if(count_ticks == 0)
                       begin // Red
           ticks_red = 4'hF;
           ticks_green = 4'h0;
           ticks_blue = 4'h0;
       end
       else if(count_ticks == 1)
                       begin //Green
           ticks_red = 4'h0;
           ticks_green = 4'hF;
           ticks_blue = 4'h0;
       end
       else if(count_ticks == 2)
                       begin //Lime
           ticks_red = 4'h7;
           ticks_green = 4'h8;
           ticks_blue = 4'h0;
       end
       else if(count_ticks == 3)
                       begin //Purple
           ticks_red = 4'h4;
           ticks_green = 4'h0;
           ticks_blue = 4'h9;
       end
       else if(count_ticks == 4)
                       begin //Cyan
           ticks_red = 4'h0;
           ticks_green = 4'hF;
           ticks_blue = 4'hF;
       end
       else 
                       begin //red
           ticks_red = 4'hF;
           ticks_green = 4'h0;
           ticks_blue = 4'h0;
       end  
       
       
       case(count_ticks)
                   0:
                       begin // Red
                           ticks_red = 4'hF;
                           ticks_green = 4'h0;
                           ticks_blue = 4'h0;
                       end
                   1:
                       begin //Green
                           ticks_red = 4'h0;
                           ticks_green = 4'hF;
                           ticks_blue = 4'h0;
                       end
                   2:  
                       begin //Lime
                           ticks_red = 4'h7;
                           ticks_green = 4'h8;
                           ticks_blue = 4'h0;
                       end
                   3:
                       begin //Purple
                           ticks_red = 4'h4;
                           ticks_green = 4'h0;
                           ticks_blue = 4'h9;
                       end
                   4:
                       begin //Cyan
                           ticks_red = 4'h0;
                           ticks_green = 4'hF;
                           ticks_blue = 4'hF;
                       end
                   default:
                       begin
                           ticks_red = 4'hF;
                           ticks_green = 4'h0;
                           ticks_blue = 4'h0;
                       end     
              endcase
              
              
      //MUX FOR MAIN GRID
      
        if(sw5)
               begin //current background color
                   main_grid_red = bg_red;
                   main_grid_green = bg_green;
                   main_grid_blue = bg_blue;
               end 
           else if(count_ticks == 0)
                      begin //Blue (good)
               main_grid_red = 4'h0;
               main_grid_green = 4'h0;
               main_grid_blue = 4'hF;
           end
           else if(count_ticks == 1)
                      begin //Green 
               main_grid_red = 4'h0;
               main_grid_green = 4'hF;
               main_grid_blue = 4'h0;
           end
           else if(count_ticks == 2)
                      begin //Yellow
               main_grid_red = 4'hF;
               main_grid_green = 4'hF;
               main_grid_blue = 4'h0;
           end
           else if(count_ticks == 3)
                      begin //Magenta
               main_grid_red = 4'hF;
               main_grid_green = 4'h0;
               main_grid_blue = 4'hF;
           end
           else if(count_ticks == 4)
                      begin //Nice pink
               main_grid_red = 4'hD;
               main_grid_green = 4'h0;
               main_grid_blue = 4'h7;
           end
           else 
              begin
               main_grid_red = 4'hF;
               main_grid_green = 4'h0;
               main_grid_blue = 4'h0;
           end  
           
           
           
      case(count_main_grid)
                  0:
                      begin //Blue
                          main_grid_red = 4'h0;
                          main_grid_green = 4'h0;
                          main_grid_blue = 4'hF;
                      end
                  1:
                      begin //Green
                          main_grid_red = 4'h0;
                          main_grid_green = 4'hF;
                          main_grid_blue = 4'h0;
                      end
                  2:  
                      begin //Yellow
                          main_grid_red = 4'hF;
                          main_grid_green = 4'hF;
                          main_grid_blue = 4'h0;
                      end
                  3:
                      begin //Magenta
                          main_grid_red = 4'hF;
                          main_grid_green = 4'h0;
                          main_grid_blue = 4'hF;
                      end
                  4:
                      begin //Nice pink
                          main_grid_red = 4'hD;
                          main_grid_green = 4'h0;
                          main_grid_blue = 4'h7;
                      end
                  default:
                      begin
                          main_grid_red = 4'hF;
                          main_grid_green = 4'h0;
                          main_grid_blue = 4'h0;
                      end     
             endcase
             
             
             
       //MUX FOR BACKGROUND      
       case(count_bg)
                   0:
                       begin //Black
                           bg_red = 4'h0;
                           bg_green = 4'h0;
                           bg_blue = 4'h0;
                       end
                   1:
                       begin //Magenta
                           bg_red = 4'hD;
                           bg_green = 4'h0;
                           bg_blue = 4'hF;
                       end
                   2:  
                       begin //dullish cyan
                           bg_red = 4'h0;
                           bg_green = 4'hD;
                           bg_blue = 4'hD;
                       end
                   3:
                       begin //Blue
                           bg_red = 4'h0;
                           bg_green = 4'h0;
                           bg_blue = 4'hF;
                       end
                   4:
                       begin //Grey
                           bg_red = 4'hD;
                           bg_green = 4'hD;
                           bg_blue = 4'hD;
                       end
                   default:
                       begin //
                           bg_red = 4'hF;
                           bg_green = 4'h0;
                           bg_blue = 4'h0;
                       end     
              endcase
              */
    end
endmodule
