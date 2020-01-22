`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// You may study and modify the code inside this module to imporve the display feature or introduce other features
//////////////////////////////////////////////////////////////////////////////////

module Draw_Waveform(
    input clk_sample, //20kHz clock
    input clk_vga,
    input clk_80hz,
    input sw2,
    input sw_e,
    input sw7,
    input sw8,
    input sw9,
    input sw13,
    input sw14,
    input sw15,
    input btnU,
    input btnD,
    input [11:0] count,
    input [9:0] wave_sample,
    input [11:0] VGA_HORZ_COORD,
    input [11:0] VGA_VERT_COORD,
    input [3:0] wave_red,
    input [3:0] wave_green,
    input [3:0] wave_blue,
    input [3:0] bg_red,
    input [3:0] bg_green,
    input [3:0] bg_blue,
    input [3:0] VGA_Red_Grid,
    input [3:0] VGA_Green_Grid,
    input [3:0] VGA_Blue_Grid,
    output reg [3:0] VGA_Red_waveform,
    output reg [3:0] VGA_Green_waveform,
    output reg [3:0] VGA_Blue_waveform
    );
    
    wire btn_u, btn_d;
    single_pulse pulse_up(clk_80hz, btnU, btn_u);
    single_pulse pulse_down(clk_80hz, btnD,btn_d);
    
    reg[3:0] wave_amplifier;
    
    initial begin
        wave_amplifier = 1;
    end
       
    //The Sample_Memory represents the memory array used to store the voice samples.
    //There are 1280 points and each point can range from 0 to 1023. 
    reg [9:0] Sample_Memory[1279:0];
    reg [10:0] i = 0;
    reg [9:0] temp;
    wire show_task = !sw15;
    reg [14:0] radius = 400;
    reg[22:0] horz_pos, vert_pos, res_pos;
    //Each wave_sample is displayed on the screen from left to right. 
    always @ (posedge clk_sample) begin
        i = (i==1279) ? 0 : i + 1;
        if(show_task) Sample_Memory[i] <= (sw2) ? Sample_Memory[i] : wave_sample;   
        else
            begin
            if (sw8) begin
               if (i % 20 == 0) begin
                  Sample_Memory[i] <= (sw2) ? Sample_Memory[i] : wave_sample;
                  temp = wave_sample;
                end else Sample_Memory[i] <= (sw2) ? Sample_Memory[i] : temp;   
            end
            else Sample_Memory[i] <= (sw2) ? Sample_Memory[i] : wave_sample;
            end
             if (count <= 2200) radius = 100;
             else if (count <= 2400) radius = 150;
             else if (count <= 2600) radius = 200;
             else if (count <= 2800) radius = 250;
             else if (count <= 3000) radius = 300;
             else if (count <= 3500) radius = 350;
             else if (count <= 3800) radius = 400;
             else radius = 450;
        end           
    reg cond;
    reg c1, c2, c3, c4;
    reg[32:0] cur_pos;
    reg cond_for_red_circle, cond_for_orange_circle, cond_for_yellow_circle, cond_for_green_circle, cond_for_blue_circle, cond_for_indigo_circle, cond_for_violet_circle;
    reg cond_for_red_black, cond_for_orange_black, cond_for_yellow_black, cond_for_green_black, cond_for_blue_black, cond_for_indigo_black, cond_for_violet_black;
    
   always @(posedge clk_80hz) begin
                if(btn_u)
        begin
            wave_amplifier = (wave_amplifier == 14) ? 14 : wave_amplifier + 1;
        end
    else if(btn_d)
        begin
            wave_amplifier = (wave_amplifier == 1) ? 1 : wave_amplifier - 1;
        end
    end   
    
    
    
    always @(posedge clk_vga) begin      
        //SHOW PROJECT
        /*
        if(!sw15 && sw8)
            begin
                VGA_Red_waveform = VGA_Red_Grid;
                VGA_Green_waveform = VGA_Green_Grid;
                VGA_Blue_waveform = VGA_Blue_Grid;
            end*/
        if(sw15 && !sw14 && !sw13)
            begin
                VGA_Red_waveform = 4'h0;
                VGA_Green_waveform = 4'h0;
                VGA_Blue_waveform = 4'h0;
            end
        else if(sw15 && sw13)
            //THIS IS MARC'S GAME
            begin
                VGA_Red_waveform = VGA_Red_Grid;
                VGA_Green_waveform = VGA_Green_Grid;
                VGA_Blue_waveform = VGA_Blue_Grid;
            end
        else if(!show_task && sw14)
            begin
                //ENTER CODE TO DRAW PROJECT WAVEFORMS
                if(sw_e)
                    begin
                        if(Sample_Memory[VGA_HORZ_COORD] >= 512 && VGA_VERT_COORD >= 512 && VGA_VERT_COORD <= (Sample_Memory[VGA_HORZ_COORD] - 512)*wave_amplifier + 512)
                            begin
                                VGA_Red_waveform = wave_red;
                                VGA_Green_waveform = wave_green;
                                VGA_Blue_waveform = wave_blue;
                            end
                         else if(Sample_Memory[VGA_HORZ_COORD] < 512 && VGA_VERT_COORD <= 512 && VGA_VERT_COORD >= 512 - (512-Sample_Memory[VGA_HORZ_COORD])*wave_amplifier)
                            begin
                                VGA_Red_waveform = wave_red;
                                VGA_Green_waveform = wave_green;
                                VGA_Blue_waveform = wave_blue;                                
                            end
                         else 
                            begin
                                VGA_Red_waveform = VGA_Red_Grid;
                                VGA_Green_waveform = VGA_Green_Grid;
                                VGA_Blue_waveform = VGA_Blue_Grid;                               
                            end   
                           
                    end
                else if (sw7)
                    begin
                        cond = ((VGA_VERT_COORD + Sample_Memory[VGA_HORZ_COORD] - 1024)* 
                              (VGA_VERT_COORD + Sample_Memory[VGA_HORZ_COORD] - 1024) + 
                              (VGA_HORZ_COORD + Sample_Memory[VGA_VERT_COORD] - 1350) * 
                              (VGA_HORZ_COORD + Sample_Memory[VGA_VERT_COORD] - 1350) <= radius * radius);
                        if(cond)
                            begin
                                VGA_Red_waveform = wave_red;
                                VGA_Green_waveform = wave_green;
                                VGA_Blue_waveform = wave_blue;
                            end
                        else 
                            begin
                                VGA_Red_waveform = VGA_Red_Grid;
                                VGA_Green_waveform = VGA_Green_Grid;
                                VGA_Blue_waveform = VGA_Blue_Grid;                            
                            end
                    end
                else if (sw8) 
                    begin
                       //cond <= ((VGA_HORZ_COORD < 1280) && (VGA_VERT_COORD >= (1024 - Sample_Memory[VGA_HORZ_COORD])));
                         cond = ((VGA_HORZ_COORD < 1280) && (VGA_VERT_COORD >= (1024 - Sample_Memory[VGA_HORZ_COORD])) &&
                                                      (VGA_HORZ_COORD % 20 != 0) && (VGA_VERT_COORD % 20 != 0));
                           if(cond)
                            begin
                                VGA_Red_waveform = wave_red;
                            VGA_Green_waveform = wave_green;
                            VGA_Blue_waveform = wave_blue;                            
                            end
                          else
                            begin
                                   VGA_Red_waveform = VGA_Red_Grid;
                            VGA_Green_waveform = VGA_Green_Grid;
                            VGA_Blue_waveform = VGA_Blue_Grid;                         
                            end                                                                                
                    end
                    /*
                else if(sw9)    
                    begin
                        cond_for_red_circle = ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) < (450**2);
                        cond_for_red_black =  ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) < (420**2);
                        
                        cond_for_orange_circle = ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) < (410**2);
                        cond_for_orange_black =  ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) < (380**2);
                        
                        cond_for_yellow_circle = ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) < (370**2);
                        cond_for_yellow_black =  ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) < (340**2);
                        
                        cond_for_green_circle = ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) < (330**2);
                        cond_for_green_black =  ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) < (300**2);
                        
                        cond_for_blue_circle = ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) < (290**2);
                        cond_for_blue_black =  ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) < (260**2);
                        
                        cond_for_indigo_circle = ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) < (250**2);
                        cond_for_indigo_black =  ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) < (220**2);
                        
                        cond_for_violet_circle = ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) < (210**2);
                        cond_for_violet_black =  ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) < (180**2);
                        
                        if(wave_sample > 950 && cond_for_red_circle)
                            begin
                                VGA_Red_waveform = 4'hF;
                                VGA_Green_waveform = 4'h0;
                                VGA_Blue_waveform = 4'h0;       
                            end
                        if(wave_sample > 950 && cond_for_red_black)
                            begin
                                VGA_Red_waveform = 4'h0;
                                VGA_Green_waveform = 4'h0;
                                VGA_Blue_waveform = 4'h0; 
                            end
                        if(wave_sample > 900 && cond_for_orange_circle)
                            begin
                            VGA_Red_waveform = 4'hF;
                            VGA_Green_waveform = 4'h8;
                            VGA_Blue_waveform = 4'h0;       
                        end                   
                        if(wave_sample >900 && cond_for_orange_black)
                            begin
                                VGA_Red_waveform = 4'h0;
                                VGA_Green_waveform = 4'h0;
                                VGA_Blue_waveform = 4'h0; 
                            end     
                        if(wave_sample > 850 && cond_for_yellow_circle)
                                begin
                                VGA_Red_waveform = 4'hF;
                                VGA_Green_waveform = 4'hF;
                                VGA_Blue_waveform = 4'h0;       
                            end  
                        if(wave_sample > 850 && cond_for_yellow_black)
                                begin
                                    VGA_Red_waveform = 4'h0;
                                    VGA_Green_waveform = 4'h0;
                                    VGA_Blue_waveform = 4'h0; 
                                end                      
                        if(wave_sample > 800 && cond_for_green_circle)
                            begin
                                        VGA_Red_waveform = 4'h1;
                                        VGA_Green_waveform = 4'hA;
                                        VGA_Blue_waveform = 4'h0;       
                            end             
                        if(wave_sample > 800 && cond_for_green_black)
                                    begin
                                        VGA_Red_waveform = 4'h0;
                                        VGA_Green_waveform = 4'h0;
                                        VGA_Blue_waveform = 4'h0; 
                                    end                                 
                        if(wave_sample > 700 && cond_for_blue_circle)
                                        begin
                                                    VGA_Red_waveform = 4'h0;
                                                    VGA_Green_waveform = 4'h0;
                                                    VGA_Blue_waveform = 4'hF;       
                                        end
                        if(wave_sample > 700 && cond_for_blue_black)
                                        begin
                                              VGA_Red_waveform = 4'h0;
                                              VGA_Green_waveform = 4'h0;
                                              VGA_Blue_waveform = 4'h0;       
                                        end   
                        if(wave_sample > 600 && cond_for_indigo_circle)
                                        begin
                                              VGA_Red_waveform = 4'h7;
                                              VGA_Green_waveform = 4'h0;
                                              VGA_Blue_waveform = 4'hD;       
                                        end
                        if(wave_sample > 600 && cond_for_indigo_black)
                                        begin
                                              VGA_Red_waveform = 4'h0;
                                              VGA_Green_waveform = 4'h0;
                                              VGA_Blue_waveform = 4'h0;       
                                         end                                        
                        if(wave_sample > 500 && cond_for_violet_circle)
                                         begin
                                            VGA_Red_waveform = 4'hE;
                                            VGA_Green_waveform = 4'hA;
                                            VGA_Blue_waveform = 4'hF;       
                                          end     
                         if(wave_sample > 500 && cond_for_violet_black)
                                          begin
                                            VGA_Red_waveform = 4'h0;
                                            VGA_Green_waveform = 4'h0;
                                            VGA_Blue_waveform = 4'h0;       
                                          end   
                               */                                    
                         /*
                        else 
                            begin
                            VGA_Red_waveform = 4'h0;
                            VGA_Green_waveform = 4'h0;
                            VGA_Blue_waveform = 4'h0;                             
                            end    
                          */  
                          
                    //end
                    /*
                else if(sw9)
                    begin
                        c1 = (wave_sample > 2000);
                        c2 = (wave_sample > 2500);
                        c3 = (wave_sample >3000);
                        c4 = (wave_sample >3500);
                        horz_pos = (VGA_HORZ_COORD - 1280)*(VGA_HORZ_COORD - 1280) ;
                        vert_pos = (VGA_VERT_COORD - 1024) * (VGA_VERT_COORD - 1024);
                        res_pos = horz_pos + res_pos;
                        if(c4 && (res_pos < 160000))
                            begin
                                
                            end
                    end */
                    
                // DEFAULT WAVE DRAWER FOR PROJECT VIEW                
                else 
                    begin
                       cond = ((VGA_HORZ_COORD < 1280) && (VGA_VERT_COORD == (1024 - Sample_Memory[VGA_HORZ_COORD])));
                        
                        if (cond)
                           begin
                               VGA_Red_waveform = wave_red;
                               VGA_Green_waveform = wave_green;
                               VGA_Blue_waveform = wave_blue;
                           end
                       
                       else
                           begin
                               VGA_Red_waveform = VGA_Red_Grid;
                               VGA_Green_waveform = VGA_Green_Grid;
                               VGA_Blue_waveform = VGA_Blue_Grid;
                           end 
                    end      
            end

        //SHOW TASK
        else if(show_task && (VGA_HORZ_COORD < 1280) && (VGA_VERT_COORD == (1024 - Sample_Memory[VGA_HORZ_COORD])))
            begin
                VGA_Red_waveform = wave_red;
                VGA_Green_waveform = wave_green;
                VGA_Blue_waveform = wave_blue;
            end
            
        else if(show_task)
            begin
                VGA_Red_waveform = bg_red;
                VGA_Green_waveform = bg_green;
                VGA_Blue_waveform = bg_blue;
            end
            /*
       else 
            begin
                VGA_Red_waveform = bg_red;
                VGA_Green_waveform = bg_green;
                VGA_Blue_waveform = bg_blue;         
            end
            */
    end
    
    /*
    assign VGA_Red_waveform =   ((VGA_HORZ_COORD < 1280) && (VGA_VERT_COORD == (1024 - Sample_Memory[VGA_HORZ_COORD]))) ? wave_red : bg_red;
    assign VGA_Green_waveform = ((VGA_HORZ_COORD < 1280) && (VGA_VERT_COORD == (1024 - Sample_Memory[VGA_HORZ_COORD]))) ? wave_green : bg_green;
    assign VGA_Blue_waveform =  ((VGA_HORZ_COORD < 1280) && (VGA_VERT_COORD == (1024 - Sample_Memory[VGA_HORZ_COORD]))) ? wave_blue : bg_blue ;
    */
    
endmodule
