`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//-------------------------------------------------------------------------  
//                  DRAWING GRID LINES AND TICKS ON SCREEN
// Description:
// Grid lines are drawn at pixel # 320 along the x-axis, and
// pixel #768 along the y-axis

// Note the VGA controller is configured to produce a 1024 x 1280 pixel resolution
//-------------------------------------------------------------------------

//-------------------------------------------------------------------------
// TOOD:    Draw grid lines at every 80-th pixel along the horizontal axis, and every 64th pixel
//          along the vertical axis. This gives us a 16x16 grid on screen. 
//          
//          Further draw ticks on the central x and y grid lines spaced 16 and 8 pixels apart in the 
//          horizontal and vertical directions respectively. This gives us 5 sub-divisions per division 
//          in the horizontal and 8 sub-divisions per divsion in the vertical direction   
//-------------------------------------------------------------------------  
  
//////////////////////////////////////////////////////////////////////////////////


module Draw_Background(
    input CLK,
    input clk_basys,
    input clk_12hz,
    input clk_80hz,
    input clk_30hz,
    input clk_20khz,
    input sw9,
    input sw10,
    input sw11, 
    input sw12,
    input sw13,
    input sw14,
    input sw15,
    input [9:0] wave_sample,
    input [9:0] rainbow_wave,
    input [11:0] count,
    input [11:0] game_sound,
    input [11:0] VGA_HORZ_COORD,
    input [11:0] VGA_VERT_COORD,
    input [3:0] sub_grid_red,
    input [3:0] sub_grid_green,
    input [3:0] sub_grid_blue,
    input [3:0] ticks_red,
    input [3:0] ticks_green,
    input [3:0] ticks_blue,
    input [3:0] main_grid_red,
    input [3:0] main_grid_green,
    input [3:0] main_grid_blue,
    input [3:0] bg_red,
    input [3:0] bg_green,
    input [3:0] bg_blue,
    input [4:0] main_menu_words,
    input [3:0] sound_level,
    input sound_bar_text,
    input [2:0] sound_texts,
    input [4:0] max_first,
    input [4:0] max_first_text,
    input [20:0] game_texts,
    input [30:0] help_texts,
    output reg [3:0] VGA_Red_Grid,
    output reg [3:0] VGA_Green_Grid,
    output reg [3:0] VGA_Blue_Grid
    );
    
    wire show_task = !sw15;
    wire clk_100hz, clk_50hz;
    my_clk_div my_100hz(clk_basys, 499999, clk_100hz);
    my_clk_div my_50hz(clk_basys, 999999, clk_50hz);
    
    wire main_menu_words_show = main_menu_words[0] || main_menu_words[1] || main_menu_words[2] || main_menu_words[3] || main_menu_words[4];

    wire sound_texts_show = sound_texts[0] || sound_texts[1] || sound_texts[2];
// The code below draws two grid lines. Modify the codes to draw more grid lines. 
    wire Condition_For_Grid = (VGA_HORZ_COORD == 640) ||  (VGA_VERT_COORD == 512) ;
    
// Condition for other grid lines
   wire Condition_For_Sub_Grids  = ((VGA_HORZ_COORD % 80 == 0 && (VGA_VERT_COORD % 64 < 10 || VGA_VERT_COORD % 64 > 54) && VGA_HORZ_COORD != 640) || (VGA_VERT_COORD % 64 == 0 && (VGA_HORZ_COORD %80 < 10 || VGA_HORZ_COORD % 80 > 70) && VGA_VERT_COORD != 512));
   
// Using the gridline example, insert your code below to draw ticks on the x-axis and y-axis.
   wire Condition_For_Ticks = ((VGA_HORZ_COORD % 16 == 0 && VGA_VERT_COORD <= 516 && VGA_VERT_COORD >= 508) || (VGA_VERT_COORD % 8 == 0 && VGA_HORZ_COORD <= 652 && VGA_HORZ_COORD >= 628));
   
   //SOUND SQUARES
   parameter ssq_size = 40;
   parameter left_margin = 150;
   wire square1 = (VGA_HORZ_COORD >= left_margin + ssq_size*0 && VGA_HORZ_COORD <= left_margin + ssq_size*1 && VGA_VERT_COORD >= 80 && VGA_VERT_COORD <= 80+ssq_size);
   wire square2 = (VGA_HORZ_COORD >= left_margin + ssq_size*1 && VGA_HORZ_COORD <= left_margin + ssq_size*2 && VGA_VERT_COORD >= 80 && VGA_VERT_COORD <= 80+ssq_size);
   wire square3 = (VGA_HORZ_COORD >= left_margin + ssq_size*2 && VGA_HORZ_COORD <= left_margin + ssq_size*3 && VGA_VERT_COORD >= 80 && VGA_VERT_COORD <= 80+ssq_size);
   wire square4 = (VGA_HORZ_COORD >= left_margin + ssq_size*3 && VGA_HORZ_COORD <= left_margin + ssq_size*4 && VGA_VERT_COORD >= 80 && VGA_VERT_COORD <= 80+ssq_size);
   wire square5 = (VGA_HORZ_COORD >= left_margin + ssq_size*4 && VGA_HORZ_COORD <= left_margin + ssq_size*5 && VGA_VERT_COORD >= 80 && VGA_VERT_COORD <= 80+ssq_size);
   wire square6 = (VGA_HORZ_COORD >= left_margin + ssq_size*5 && VGA_HORZ_COORD <= left_margin + ssq_size*6 && VGA_VERT_COORD >= 80 && VGA_VERT_COORD <= 80+ssq_size);
   wire square7 = (VGA_HORZ_COORD >= left_margin + ssq_size*6 && VGA_HORZ_COORD <= left_margin + ssq_size*7 && VGA_VERT_COORD >= 80 && VGA_VERT_COORD <= 80+ssq_size);
   wire square8 = (VGA_HORZ_COORD >= left_margin + ssq_size*7 && VGA_HORZ_COORD <= left_margin + ssq_size*8 && VGA_VERT_COORD >= 80 && VGA_VERT_COORD <= 80+ssq_size);
   wire square9 = (VGA_HORZ_COORD >= left_margin + ssq_size*8 && VGA_HORZ_COORD <= left_margin + ssq_size*9 && VGA_VERT_COORD >= 80 && VGA_VERT_COORD <= 80+ssq_size);
   wire square10 = (VGA_HORZ_COORD >= left_margin + ssq_size*9 && VGA_HORZ_COORD <= left_margin + ssq_size*10 && VGA_VERT_COORD >= 80 && VGA_VERT_COORD <= 80+ssq_size);
   wire square11 = (VGA_HORZ_COORD >= left_margin + ssq_size*10 && VGA_HORZ_COORD <= left_margin + ssq_size*11 && VGA_VERT_COORD >= 80 && VGA_VERT_COORD <= 80+ssq_size);
   wire square12 = (VGA_HORZ_COORD >= left_margin + ssq_size*11 && VGA_HORZ_COORD <= left_margin + ssq_size*12 && VGA_VERT_COORD >= 80 && VGA_VERT_COORD <= 80+ssq_size);
   
   
   //SOUND SPECS SCREEN
   wire sound_specs_screen = (VGA_HORZ_COORD >= 940 && VGA_HORZ_COORD <= 1240 && VGA_VERT_COORD >= 40 && VGA_VERT_COORD <= 240);
   wire sound_specs_border = ( (VGA_HORZ_COORD >= 935 && VGA_HORZ_COORD <= 1245 && VGA_VERT_COORD >= 35 && VGA_VERT_COORD < 40) ||
                                  (VGA_HORZ_COORD >= 935 && VGA_HORZ_COORD <= 1245 && VGA_VERT_COORD > 240 && VGA_VERT_COORD <= 245) ||
                                  (VGA_HORZ_COORD >= 935 && VGA_HORZ_COORD < 940 && VGA_VERT_COORD >= 40 && VGA_VERT_COORD <= 240) ||
                                  (VGA_HORZ_COORD >= 1240 && VGA_HORZ_COORD <=1245 && VGA_VERT_COORD >= 40 && VGA_VERT_COORD <= 240) );
   
// Please modify below codes to change the background color and to display ticks defined above

    //RAINBOW
     //wire cond_for_red_circle, cond_for_orange_circle, cond_for_yellow_circle, cond_for_green_circle, cond_for_blue_circle, cond_for_indigo_circle, cond_for_violet_circle;
     //wire cond_for_red_black, cond_for_orange_black, cond_for_yellow_black, cond_for_green_black, cond_for_blue_black, cond_for_indigo_black, cond_for_violet_black;
    
     wire cond_for_red_circle = (((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) < (450**2));
     wire cond_for_red_black =  ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) > (420**2);
     
     wire cond_for_orange_circle = ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) < (410**2);
     wire cond_for_orange_black =  ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) > (380**2);
     
     wire cond_for_yellow_circle = ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) < (370**2);
     wire cond_for_yellow_black =  ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) > (340**2);
     
     wire cond_for_green_circle = ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) < (330**2);
     wire cond_for_green_black =  ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) > (300**2);
     
     wire cond_for_blue_circle = ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) < (290**2);
     wire cond_for_blue_black =  ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) > (260**2);
     
     wire cond_for_indigo_circle = ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) < (250**2);
     wire cond_for_indigo_black =  ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) > (220**2);
     
     wire cond_for_violet_circle = ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) < (210**2);
     wire cond_for_violet_black =  ((VGA_HORZ_COORD - 640)*(VGA_HORZ_COORD - 640) + (VGA_VERT_COORD - 514)*(VGA_VERT_COORD - 514)) > (180**2);
    
     reg [11:0] vert_bound1 = 1024, vert_bound2 = 974, vert_bound3 = 974, vert_bound4 = 940,  vert_bound5 = 940,  vert_bound6 = 920, vert_bound7 = 1024, vert_bound8 = 974;
     reg [11:0] horz_bound1 = 0, horz_bound2 = 10, horz_bound3 = 0, horz_bound4 = 30,  horz_bound5 = 10,  horz_bound6 = 20, horz_bound7 = 20, horz_bound8 = 30;
     reg forward = 1;
     reg [11:0] vertbound1 = 0, vertbound2 = 40, vertbound3 = 0, vertbound4 = 40, vertbound5 = 0, vertbound6 = 40, vertbound7 = 0, vertbound8 = 40;
     reg [11:0] horz1 = 150, horz2 = 190, horz3 = 470, horz4 = 510,  horz5 = 790,  horz6 = 830, horz7 = 1110, horz8 = 1150;
     reg [11:0] bullet_horzbound1 = 10, bullet_horzbound2 = 20, bullet_vertbound1 = 890, bullet_vertbound2 = 880;
     reg[3:0] bullet_red, bullet_blue, bullet_green, sq1_red = 4'hF, sq1_green = 4'h0, sq1_blue = 4'h0, sq2_red = 4'hF, sq2_green = 4'hF, sq2_blue = 4'h0, sq3_red = 4'hB, sq3_green = 4'h6, sq3_blue = 4'hF, sq4_red = 4'hC, sq4_green = 4'hD, sq4_blue = 4'hE;
     reg[3:0] enemy_red, enemy_blue, enemy_green;
     reg spawned = 0;
     reg[10:0] score = 0;
     reg freeze = 0;
     reg [11:0] random_num = 0;
     wire btn_c;
        
   always @ (posedge clk_12hz) begin
        if (!freeze) begin
             if (vertbound2 < 900) begin
               vertbound1 <= vertbound1 + 2;
               vertbound2 <= vertbound2 + 2;
               end else
               begin
               vertbound1 <= 0;
               vertbound2 <= 40;
               vertbound3 <= 0;
               vertbound4 <= 40;
               vertbound5 <= 0;
               vertbound6 <= 40;
               vertbound7 <= 0;
               vertbound8 <= 40;
               freeze <= 1;
               /*
               sq1_red = enemy_red;
               sq1_green = enemy_green;
               sq1_blue = enemy_blue;
               */
               end
             if (vertbound4 < 900) begin
               vertbound3 <= vertbound3 + 2;
               vertbound4 <= vertbound4 + 2;
               end else
               begin
                vertbound1 <= 0;
                             vertbound2 <= 40;
                             vertbound3 <= 0;
                             vertbound4 <= 40;
                             vertbound5 <= 0;
                             vertbound6 <= 40;
                             vertbound7 <= 0;
                             vertbound8 <= 40;
               freeze <= 1;
               /*
               sq2_red = enemy_red;
               sq2_green = enemy_green;
               sq2_blue = enemy_blue;
               */
               end
             if (vertbound6 < 900) begin
               vertbound5 <= vertbound5 + 2;
               vertbound6 <= vertbound6 + 2;
               end else
               begin
               vertbound1 <= 0;
                             vertbound2 <= 40;
                             vertbound3 <= 0;
                             vertbound4 <= 40;
                             vertbound5 <= 0;
                             vertbound6 <= 40;
                             vertbound7 <= 0;
                             vertbound8 <= 40;
               freeze <= 1;
               /*
               sq3_red = enemy_red;
               sq3_green = enemy_green;
               sq3_blue = enemy_blue;
               */
               
               end
             if (vertbound8 < 900) begin
               vertbound7 <= vertbound7 + 2;
               vertbound8 <= vertbound8 + 2;
               end else
               begin
               vertbound1 <= 0;
                             vertbound2 <= 40;
                             vertbound3 <= 0;
                             vertbound4 <= 40;
                             vertbound5 <= 0;
                             vertbound6 <= 40;
                             vertbound7 <= 0;
                             vertbound8 <= 40;
               freeze <= 1;
               /*
               sq4_red = enemy_red;
               sq4_green = enemy_green;
               sq4_blue = enemy_blue;
               */
               
               end
            if (forward) begin
            horz_bound1 <= horz_bound1 + 15;
            horz_bound2 <= horz_bound2 + 15;
            horz_bound3 <= horz_bound3 + 15;
            horz_bound4 <= horz_bound4 + 15;
            horz_bound5 <= horz_bound5 + 15;
            horz_bound6 <= horz_bound6 + 15;
            horz_bound7 <= horz_bound7 + 15;
            horz_bound8 <= horz_bound8 + 15;
            /*
            if (!spawned) begin
                    bullet_horzbound1 <=  bullet_horzbound1 +10;
                    bullet_horzbound2 <=  bullet_horzbound2 +10;
                    end
                    */
            end else 
            begin
             horz_bound1 <= horz_bound1 - 15;
             horz_bound2 <= horz_bound2 - 15;
             horz_bound3 <= horz_bound3 - 15;
             horz_bound4 <= horz_bound4 - 15;
             horz_bound5 <= horz_bound5 - 15;
             horz_bound6 <= horz_bound6 - 15;
             horz_bound7 <= horz_bound7 - 15;
             horz_bound8 <= horz_bound8 - 15;
             /*
              if (!spawned) begin
                    bullet_horzbound1 <=  bullet_horzbound1 - 10;
                    bullet_horzbound2 <=  bullet_horzbound2 - 10;
                    end
                    */
            end
            if (horz_bound8 == 1275) forward = 0;
            else if (horz_bound1 == 0) forward = 1;
            
            if (bullet_vertbound2 == 0) begin 
                         spawned <= 0; 
                         bullet_vertbound1 <= 940;
                         bullet_vertbound2 <= 920;
                         bullet_horzbound1 <= horz_bound5;
                         bullet_horzbound2 <= horz_bound6;
                        
             end else 
             begin
             if (spawned) begin
                bullet_vertbound2 <= bullet_vertbound2 - 20;
                bullet_vertbound1 <= bullet_vertbound1 - 20;
             end else begin
                 bullet_horzbound1 <= horz_bound5;
                 bullet_horzbound2 <= horz_bound6;
                 end
             end
            //if (count >= 2000) spawned <= 1;
            
            
            if (!spawned) 
                                 begin
                                    if (count <= 3000) begin
                                     bullet_red <= 4'hF;
                                     bullet_green <= 4'hF;
                                     bullet_blue <= 4'hF;
                                     end
                                     else if (count <= 3250) begin 
                                               spawned <= 1;
                                               bullet_red <= 4'hF;
                                               bullet_green <= 4'h0;
                                               bullet_blue <= 4'h0;
                                                end
                                           else if (count <= 3500) begin
                                               spawned <= 1;
                                               bullet_red <= 4'hF;
                                               bullet_green <= 4'hF;
                                               bullet_blue <= 4'h0;
                                               end
                                           else if (count <= 3750) begin
                                               spawned <= 1;
                                               bullet_red <= 4'hB;
                                               bullet_green <= 4'h6;
                                               bullet_blue <= 4'hF;
                                               end
                                           else if (count <= 4000) begin
                                                 spawned <= 1;
                                                 bullet_red <= 4'hC;
                                                 bullet_green <= 4'hD;
                                                 bullet_blue <= 4'hE;
                                                 end
                                 end
                 end
                 
                 
                 if (spawned && (bullet_horzbound2 - horz2 <= 60 || horz2 - bullet_horzbound2 <= 60)  &&  (bullet_vertbound2 - vertbound2 <= 60 || vertbound2 - bullet_vertbound2 <= 60) && 
                      bullet_red == sq1_red && bullet_green == sq1_green && bullet_blue == sq1_blue) begin
                      spawned <= 0;
                      vertbound1 <= 0;
                      vertbound2 <= 40;
                      bullet_horzbound1 <= horz_bound5;
                      bullet_horzbound2 <= horz_bound6;
                      bullet_vertbound1 <= 940;
                      bullet_vertbound2 <= 920;
                      score <= score + 1;
                      /*
                      sq1_red = enemy_red;
                      sq1_green = enemy_green;
                      sq1_blue = enemy_blue; 
                      */                
                      end
                 
                 if (spawned && (bullet_horzbound2 - horz4 <= 60 || horz4 - bullet_horzbound2 <= 60)  &&  (bullet_vertbound2 - vertbound4 <= 60 || vertbound4 - bullet_vertbound2 <= 60) && 
                      bullet_red == sq2_red && bullet_green == sq2_green && bullet_blue == sq2_blue) begin
                      spawned <= 0;
                      vertbound3 <= 0;
                      vertbound4 <= 40;
                      bullet_horzbound1 <= horz_bound5;
                      bullet_horzbound2 <= horz_bound6;
                      bullet_vertbound1 <= 940;
                      bullet_vertbound2 <= 920;
                      score <= score + 1;
                      /*
                      sq2_red = enemy_red;
                      sq2_green = enemy_green;
                      sq2_blue = enemy_blue;
                      */
                 end
                 
                 if (spawned && (bullet_horzbound2 - horz6 <= 60 || horz6 - bullet_horzbound2 <= 60)  &&  (bullet_vertbound2 - vertbound6 <= 60 || vertbound6 - bullet_vertbound2 <= 60) && 
                      bullet_red == sq3_red && bullet_green == sq3_green && bullet_blue == sq3_blue) begin
                      spawned <= 0;
                      vertbound5 <= 0;
                      vertbound6 <= 40;
                      bullet_horzbound1 <= horz_bound5;
                      bullet_horzbound2 <= horz_bound6;
                      bullet_vertbound1 <= 940;
                      bullet_vertbound2 <= 920;
                      score <= score + 1;
                      /*
                      sq3_red = enemy_red;
                      sq3_green = enemy_green;
                      sq3_blue = enemy_blue;
                      */
                 end
                 
                  if (spawned && (bullet_horzbound2 - horz8 <= 60 || horz8 - bullet_horzbound2 <= 60)  &&  (bullet_vertbound2 - vertbound8 <= 60 || vertbound8 - bullet_vertbound2 <= 60) &&  
                      bullet_red == sq4_red && bullet_green == sq4_green && bullet_blue == sq4_blue) begin
                      spawned <= 0;
                      vertbound7 <= 0;
                      vertbound8 <= 40;
                      bullet_horzbound1 <= horz_bound5;
                      bullet_horzbound2 <= horz_bound6;
                      bullet_vertbound1 <= 940;
                      bullet_vertbound2 <= 920;
                      score <= score + 1;
                      /*
                      sq4_red = enemy_red;
                      sq4_green = enemy_green;
                      sq4_blue = enemy_blue;
                      */
                 end
            end
            
    /*
    always @(posedge clk_20khz) begin
          if (!spawned) 
                     begin
                        if (count <= 3000) begin
                         bullet_red <= 4'hF;
                         bullet_green <= 4'hF;
                         bullet_blue <= 4'hF;
                         end
                         else if (count <= 3250) begin 
                                   spawned <= 1;
                                   bullet_red <= 4'hF;
                                   bullet_green <= 4'h0;
                                   bullet_blue <= 4'h0;
                                    end
                               else if (count <= 3500) begin
                                   spawned <= 1;
                                   bullet_red <= 4'hF;
                                   bullet_green <= 4'hF;
                                   bullet_blue <= 4'h0;
                                   end
                               else if (count <= 3750) begin
                                   spawned <= 1;
                                   bullet_red <= 4'hB;
                                   bullet_green <= 4'h6;
                                   bullet_blue <= 4'hF;
                                   end
                               else if (count <= 4000) begin
                                     spawned <= 1;
                                     bullet_red <= 4'hC;
                                     bullet_green <= 4'hD;
                                     bullet_blue <= 4'hE;
                                     end
                     end
           end
           */
  
    
    always @(posedge CLK) begin
        
        if(Condition_For_Grid && show_task) 
            begin
                VGA_Red_Grid = main_grid_red;
                VGA_Green_Grid = main_grid_green;
                VGA_Blue_Grid = main_grid_blue;
            end
        else if(Condition_For_Ticks && show_task)
            begin
                VGA_Red_Grid = ticks_red;
                VGA_Green_Grid = ticks_green;
                VGA_Blue_Grid = ticks_blue;
            end
        else if(Condition_For_Sub_Grids && show_task)
            begin
                VGA_Red_Grid = sub_grid_red;
                VGA_Green_Grid = sub_grid_green;
                VGA_Blue_Grid = sub_grid_blue;
            end
        else if(show_task)
            begin
                VGA_Red_Grid = bg_red;
                VGA_Green_Grid = bg_green;
                VGA_Blue_Grid = bg_blue;
            end
       else if(sw15 && sw12 && !sw14 && !sw13)
                begin
                    if(help_texts)
                        begin
                                        VGA_Red_Grid = 4'hF;
                        VGA_Green_Grid = 4'hF;
                        VGA_Blue_Grid = 4'hF;
                        end
                    else
                        begin
                                        VGA_Red_Grid = 4'h0;
                        VGA_Green_Grid = 4'h0;
                        VGA_Blue_Grid = 4'h0;     
                        end
                end
        else if(!show_task && main_menu_words_show && !sw14 && !sw13)
            begin
                VGA_Red_Grid = 4'h3;
                VGA_Green_Grid = 4'hF;
                VGA_Blue_Grid = 4'hF;
            end
//START OF MARC'S GAME
                    else if(sw15 && sw13)
                        begin
                             if(game_texts[0])
                                                       begin
                                                           VGA_Red_Grid = 4'hf;
                                                           VGA_Blue_Grid = 4'hf;
                                                           VGA_Green_Grid = 4'hf;
                                                       end
                                                     else if(score == 0 && game_texts[20])
                                                       begin
                                                           VGA_Red_Grid = 4'hf;
                                                           VGA_Blue_Grid = 4'hf;
                                                           VGA_Green_Grid = 4'hf;  
                                                       end
                                                     else if(score == 1 && game_texts[1])
                                                       begin
                                                           VGA_Red_Grid = 4'hf;
                                                           VGA_Blue_Grid = 4'hf;
                                                           VGA_Green_Grid = 4'hf;  
                                                       end
                                                     else if(score == 2 && game_texts[2])
                                                         begin
                                                             VGA_Red_Grid = 4'hf;
                                                             VGA_Blue_Grid = 4'hf;
                                                             VGA_Green_Grid = 4'hf;  
                                                         end
                                                     else if(score == 3 && game_texts[3])
                                                           begin
                                                              VGA_Red_Grid = 4'hf;
                                                              VGA_Blue_Grid = 4'hf;
                                                              VGA_Green_Grid = 4'hf;  
                                                            end
                                                    else if(score == 4 && game_texts[4])
                                                           begin
                                                             VGA_Red_Grid = 4'hf;
                                                             VGA_Blue_Grid = 4'hf;
                                                             VGA_Green_Grid = 4'hf;  
                                                            end
                                                   else if(score == 5 && game_texts[5])
                                                           begin
                                                             VGA_Red_Grid = 4'hf;
                                                             VGA_Blue_Grid = 4'hf;
                                                             VGA_Green_Grid = 4'hf;  
                                                             end
                                                 else if(score == 6 && game_texts[6])
                                                           begin
                                                               VGA_Red_Grid = 4'hf;
                                                               VGA_Blue_Grid = 4'hf;
                                                               VGA_Green_Grid = 4'hf;  
                                                            end
                                                 else if(score == 7 && game_texts[7])
                                                           begin
                                                             VGA_Red_Grid = 4'hf;
                                                             VGA_Blue_Grid = 4'hf;
                                                             VGA_Green_Grid = 4'hf;  
                                                           end
                                               else if(score == 8 && game_texts[8])
                                                           begin
                                                             VGA_Red_Grid = 4'hf;
                                                             VGA_Blue_Grid = 4'hf;
                                                             VGA_Green_Grid = 4'hf;   
                                               end
                                               else if(score == 9 && game_texts[9])
                                                           begin  
                                                           VGA_Red_Grid = 4'hf;
                                                            VGA_Blue_Grid = 4'hf;
                                                          VGA_Green_Grid = 4'hf;  
                                                          end
                                              else if(score == 10 && game_texts[10])
                                                        begin
                                                          VGA_Red_Grid = 4'hf;
                                                          VGA_Blue_Grid = 4'hf;
                                                          VGA_Green_Grid = 4'hf;  
                                                        end
                        
                        
                        
                             else if (((VGA_VERT_COORD <= vert_bound1) && (VGA_VERT_COORD >= vert_bound2) &&
                                   (VGA_HORZ_COORD >= horz_bound1) && (VGA_HORZ_COORD <= horz_bound2)) || 
                                   ((VGA_VERT_COORD <= vert_bound3) && (VGA_VERT_COORD >= vert_bound4) &&
                                   (VGA_HORZ_COORD >= horz_bound3) && (VGA_HORZ_COORD <= horz_bound4)) ||
                                   ((VGA_VERT_COORD <= vert_bound5) && (VGA_VERT_COORD >= vert_bound6) &&
                                   (VGA_HORZ_COORD >= horz_bound5) && (VGA_HORZ_COORD <= horz_bound6)) ||
                                   ((VGA_VERT_COORD <= vert_bound7) && (VGA_VERT_COORD >= vert_bound8) &&
                                   (VGA_HORZ_COORD >= horz_bound7) && (VGA_HORZ_COORD <= horz_bound8))) begin
                                   VGA_Red_Grid = 4'hf;
                                   VGA_Blue_Grid = 4'hf;
                                   VGA_Green_Grid = 4'hf;
                                   end
                               else  if ((VGA_VERT_COORD >= vertbound1) && (VGA_VERT_COORD <= vertbound2) &&
                                              (VGA_HORZ_COORD >= horz1) && (VGA_HORZ_COORD <= horz2)) 
                                              begin
                                              VGA_Red_Grid = sq1_red;
                                              VGA_Blue_Grid = sq1_blue;
                                              VGA_Green_Grid = sq1_green;
                                              end
                               else if ((VGA_VERT_COORD >= vertbound3) && (VGA_VERT_COORD <= vertbound4) &&
                                              (VGA_HORZ_COORD >= horz3) && (VGA_HORZ_COORD <= horz4)) 
                                              begin
                                              VGA_Red_Grid = sq2_red;
                                              VGA_Blue_Grid = sq2_blue;
                                              VGA_Green_Grid = sq2_green;
                                              end
                                else if ((VGA_VERT_COORD >= vertbound5) && (VGA_VERT_COORD <= vertbound6) &&
                                              (VGA_HORZ_COORD >= horz5) && (VGA_HORZ_COORD <= horz6)) 
                                              begin
                                              VGA_Red_Grid = sq3_red;
                                              VGA_Blue_Grid = sq3_blue;
                                              VGA_Green_Grid = sq3_green;
                                              end
                                else if ((VGA_VERT_COORD >= vertbound7) && (VGA_VERT_COORD <= vertbound8) &&
                                              (VGA_HORZ_COORD >= horz7) && (VGA_HORZ_COORD <= horz8)) 
                                              begin
                                              VGA_Red_Grid = sq4_red;
                                              VGA_Blue_Grid = sq4_blue;
                                              VGA_Green_Grid = sq4_green;
                                              end
                                 else if (!freeze && spawned && (VGA_VERT_COORD <= bullet_vertbound1) && (VGA_VERT_COORD >= bullet_vertbound2) &&
                                                     (VGA_HORZ_COORD >= bullet_horzbound1) && (VGA_HORZ_COORD <= bullet_horzbound2)) begin
                                                      VGA_Red_Grid <= bullet_red;
                                                      VGA_Blue_Grid <= bullet_blue;
                                                      VGA_Green_Grid <= bullet_green;
                                                      end
                                else  begin
                                  VGA_Red_Grid = bg_red;
                                  VGA_Blue_Grid = bg_green;
                                  VGA_Green_Grid = bg_blue;
                                 end
                        end
                    //END OF MARC'S GAME
        //START OF PROJECT SOUND VISUALIZER
        else if(!show_task && sw14 & !sw13)
            begin
                if(sw12 && sound_bar_text)
                                begin
                                    VGA_Red_Grid = 4'h4;
                                    VGA_Green_Grid = 4'hF;
                                    VGA_Blue_Grid = 4'h5;
                                end
                            else if(sw12 && sound_level >= 1 && square1)
                                begin
                                    VGA_Red_Grid = 4'h0;
                                    VGA_Green_Grid = 4'h7;
                                    VGA_Blue_Grid = 4'h1;
                                end
                            else if(sw12 && sound_level >= 2 && square2)
                                begin
                                    VGA_Red_Grid = 4'h0;
                                    VGA_Green_Grid = 4'hA;
                                    VGA_Blue_Grid = 4'h1;
                                end
                            else if(sw12 && sound_level >= 3 && square3)
                                begin
                                    VGA_Red_Grid = 4'h5;
                                    VGA_Green_Grid = 4'hF;
                                    VGA_Blue_Grid = 4'h2;
                                end
                            else if(sw12 && sound_level >= 4 && square4)
                                begin
                                    VGA_Red_Grid = 4'hA;
                                    VGA_Green_Grid = 4'hF;
                                    VGA_Blue_Grid = 4'h2;
                                end
                            else if(sw12 && sound_level >= 5 && square5)
                                    begin
                                        VGA_Red_Grid = 4'hE;
                                        VGA_Green_Grid = 4'hF;
                                        VGA_Blue_Grid = 4'h2;
                                    end
                            else if(sw12 && sound_level >= 6 && square6)
                                begin
                                    VGA_Red_Grid = 4'hF;
                                    VGA_Green_Grid = 4'hD;
                                    VGA_Blue_Grid = 4'h0;
                                end
                            else if(sw12 && sound_level >= 7 && square7)
                                    begin
                                        VGA_Red_Grid = 4'hF;
                                        VGA_Green_Grid = 4'hC;
                                        VGA_Blue_Grid = 4'h0;
                                    end
                            else if(sw12 && sound_level >= 8 && square8)
                                        begin
                                            VGA_Red_Grid = 4'hF;
                                            VGA_Green_Grid = 4'h8;
                                            VGA_Blue_Grid = 4'h0;
                                        end
                            else if(sw12 && sound_level >= 9 && square9)
                                            begin
                                                VGA_Red_Grid = 4'hF;
                                                VGA_Green_Grid = 4'h5;
                                                VGA_Blue_Grid = 4'h0;
                                            end
                            else if(sw12 && sound_level >= 10 && square10)
                                                begin
                                                    VGA_Red_Grid = 4'hF;
                                                    VGA_Green_Grid = 4'h0;
                                                    VGA_Blue_Grid = 4'h0;
                                                end
                           
                            else if(sw12 && sound_level >= 11 && square11)
                                begin
                                    VGA_Red_Grid = 4'hB;
                                    VGA_Green_Grid = 4'h0;
                                    VGA_Blue_Grid = 4'h0;
                                end
                            else if(sw12 && sound_level >= 12 && square12)
                                    begin
                                        VGA_Red_Grid = 4'h5;
                                        VGA_Green_Grid = 4'h0;
                                        VGA_Blue_Grid = 4'h0;
                                    end
                            else if(Condition_For_Grid) 
                                    begin
                                        VGA_Red_Grid = main_grid_red;
                                        VGA_Green_Grid = main_grid_green;
                                        VGA_Blue_Grid = main_grid_blue;
                                    end
                            else if(Condition_For_Ticks)
                                    begin
                                        VGA_Red_Grid = ticks_red;
                                        VGA_Green_Grid = ticks_green;
                                        VGA_Blue_Grid = ticks_blue;
                                    end      
                            else if(Condition_For_Sub_Grids)
                                    begin
                                      VGA_Red_Grid = sub_grid_red;
                                      VGA_Green_Grid = sub_grid_green;
                                      VGA_Blue_Grid = sub_grid_blue;
                                    end  
                            else begin
                                        //draw background
                                        VGA_Red_Grid = bg_red;
                                        VGA_Green_Grid = bg_green;
                                        VGA_Blue_Grid = bg_blue;
                                    end 
                     
                    //SOUND SPECS SCREEN               
                    if(sw10)
                        begin
                            if(sound_texts_show)
                                begin
                                    VGA_Red_Grid = 4'h4;
                                    VGA_Green_Grid = 4'hF;
                                    VGA_Blue_Grid = 4'h5;    
                                end
                            else if(sound_specs_border)
                                begin
                                    VGA_Red_Grid = 4'h4;
                                    VGA_Green_Grid = 4'hF;
                                    VGA_Blue_Grid = 4'h5;
                                end
                              
                            else if(max_first[0] == 1 && max_first_text[0] == 1)
                                begin
                                VGA_Red_Grid = 4'h0;
                                VGA_Green_Grid = 4'h0;
                                VGA_Blue_Grid = 4'h0;      
                                end
                           else if(max_first[1] == 1 && max_first_text[1] == 1)
                                    begin
                                    VGA_Red_Grid = 4'h0;
                                    VGA_Green_Grid = 4'h0;
                                    VGA_Blue_Grid = 4'h0;      
                                    end
                             else if(max_first[2] == 1 && max_first_text[2] == 1)
                                        begin
                                        VGA_Red_Grid = 4'h0;
                                        VGA_Green_Grid = 4'h0;
                                        VGA_Blue_Grid = 4'h0;      
                                        end
                            else if(max_first[3] == 1 && max_first_text[3] == 1)
                                            begin
                                            VGA_Red_Grid = 4'h0;
                                            VGA_Green_Grid = 4'h0;
                                            VGA_Blue_Grid = 4'h0;      
                                            end
                            else if(max_first[4] == 1 && max_first_text[4] == 1)
                                                begin
                                                VGA_Red_Grid = 4'h0;
                                                VGA_Green_Grid = 4'h0;
                                                VGA_Blue_Grid = 4'h0;      
                                                end        
                                                                                                                                                               
                            else if(sound_specs_screen)
                                begin
                                    VGA_Red_Grid = 4'h0;
                                    VGA_Green_Grid = 4'h0;
                                    VGA_Blue_Grid = 4'h0;                                
                                end 
                        end
                  
                    //END SOUND SPECS SCREEN
                    
                    //START OF THE RAINBOW
                    if(sw9)
                        begin
                        if(rainbow_wave > 850 && VGA_VERT_COORD < 512 && cond_for_red_circle && cond_for_red_black)
                                                    begin
                                                        VGA_Red_Grid = 4'hF;
                                                        VGA_Green_Grid = 4'h0;
                                                        VGA_Blue_Grid = 4'h0;       
                                                    end
                                                    /*
                                                if(rainbow_wave > 950 && cond_for_red_black)
                                                    begin
                                                        VGA_Red_Grid = 4'h0;
                                                        VGA_Green_Grid = 4'h0;
                                                        VGA_Blue_Grid = 4'h0; 
                                                    end */
                                                if(rainbow_wave > 750 && VGA_VERT_COORD < 512 && cond_for_orange_circle && cond_for_orange_black)
                                                    begin
                                                    VGA_Red_Grid = 4'hF;
                                                    VGA_Green_Grid = 4'h8;
                                                    VGA_Blue_Grid = 4'h0;       
                                                end                   
                                                /*if(rainbow_wave >900 && cond_for_orange_black)
                                                    begin
                                                        VGA_Red_Grid = 4'h0;
                                                        VGA_Green_Grid = 4'h0;
                                                        VGA_Blue_Grid = 4'h0; 
                                                    end   */  
                                                if(rainbow_wave > 650 && VGA_VERT_COORD < 512 && cond_for_yellow_circle && cond_for_yellow_black)
                                                        begin
                                                        VGA_Red_Grid = 4'hF;
                                                        VGA_Green_Grid = 4'hF;
                                                        VGA_Blue_Grid = 4'h0;       
                                                    end  
                                                /*if(rainbow_wave > 850 && cond_for_yellow_black)
                                                        begin
                                                            VGA_Red_Grid = 4'h0;
                                                            VGA_Green_Grid = 4'h0;
                                                            VGA_Blue_Grid = 4'h0; 
                                                        end   */                   
                                                 if(rainbow_wave > 550 && VGA_VERT_COORD < 512 && cond_for_green_circle && cond_for_green_black)
                                                    begin
                                                                VGA_Red_Grid = 4'h1;
                                                                VGA_Green_Grid = 4'hA;
                                                                VGA_Blue_Grid = 4'h0;       
                                                    end          
                                                /*if(rainbow_wave > 800 && cond_for_green_black)
                                                            begin
                                                                VGA_Red_Grid = 4'h0;
                                                                VGA_Green_Grid = 4'h0;
                                                                VGA_Blue_Grid = 4'h0; 
                                                            end  */                               
                                                if(rainbow_wave > 500 && VGA_VERT_COORD < 512 && cond_for_blue_circle && cond_for_blue_black)
                                                                begin
                                                                            VGA_Red_Grid = 4'h0;
                                                                            VGA_Green_Grid = 4'h0;
                                                                            VGA_Blue_Grid = 4'hF;       
                                                                end
                                              /*  if(rainbow_wave > 700 && cond_for_blue_black)
                                                                begin
                                                                      VGA_Red_Grid = 4'h0;
                                                                      VGA_Green_Grid = 4'h0;
                                                                      VGA_Blue_Grid = 4'h0;       
                                                                end   */
                                                if(rainbow_wave > 400 && VGA_VERT_COORD < 512 && cond_for_indigo_circle && cond_for_indigo_black)
                                                                begin
                                                                      VGA_Red_Grid = 4'h7;
                                                                      VGA_Green_Grid = 4'h0;
                                                                      VGA_Blue_Grid = 4'hD;       
                                                                end
                                               /* if(rainbow_wave > 600 && cond_for_indigo_black)
                                                                begin
                                                                      VGA_Red_Grid = 4'h0;
                                                                      VGA_Green_Grid = 4'h0;
                                                                      VGA_Blue_Grid = 4'h0;       
                                                                 end           */                             
                                                if(rainbow_wave > 300 && VGA_VERT_COORD < 512 && cond_for_violet_circle && cond_for_violet_black)
                                                                 begin
                                                                    VGA_Red_Grid = 4'hE;
                                                                    VGA_Green_Grid = 4'hA;
                                                                    VGA_Blue_Grid = 4'hF;       
                                                                  end     
                                              /*   if(wave_sample > 500 && cond_for_violet_black)
                                                                  begin
                                                                    VGA_Red_Grid = 4'h0;
                                                                    VGA_Green_Grid = 4'h0;
                                                                    VGA_Blue_Grid = 4'h0;       
                                                                  end */
                        
                        end
            
        end
        //END OF PROJECT SOUND VISUALIZER    
         
        else if(!show_task)
            begin
                VGA_Red_Grid = 4'h0;
                VGA_Green_Grid = 4'h0;
                VGA_Blue_Grid = 4'h0;  
            end
        else
            begin
                VGA_Red_Grid = 4'h0;
                VGA_Green_Grid = 4'h0;
                VGA_Blue_Grid = 4'h0;
            end
    end
    /*
    assign VGA_Red_Grid = Condition_For_Grid ? main_grid_red :
                          Condition_For_Ticks ? ticks_red :
                          Condition_For_Sub_Grids ? sub_grid_red :
                          bg_red;
    
    assign VGA_Green_Grid = Condition_For_Grid ? main_grid_green :
                            Condition_For_Ticks ? ticks_green :
                            Condition_For_Sub_Grids ? sub_grid_green:
                            bg_green;
    
    
    assign VGA_Blue_Grid = Condition_For_Grid ? main_grid_blue :
                           Condition_For_Ticks ? ticks_blue:
                           Condition_For_Sub_Grids ? sub_grid_blue :
                           bg_blue;
      */                     
                        
   // if true, a red pixel is put at coordinates (VGA_HORZ_COORD, VGA_VERT_COORD), 
     
endmodule
