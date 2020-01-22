`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2019 23:57:42
// Design Name: 
// Module Name: my_sound_bar
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


module my_sound_bar(input clk_vga, input clk_20khz, input[11:0] max_sound_wave, 
    input [11:0] vga_horz_coord, input [11:0] vga_vert_coord,
   output reg[3:0] sound_level = 1, output sound_bar_text);
    
    //position text
    Pixel_On_Text2 #(.displayText("Volume Bar: ")) title(
       clk_vga,
       28, // text position.x (top left)
       100, // text position.y (top left)
       vga_horz_coord, // current position.x
       vga_vert_coord, // current position.y
       sound_bar_text // result, 1 if current pixel is on text, 0 otherwise
   );
   
    always @(posedge clk_20khz) begin
        if(max_sound_wave <= 1800) sound_level = 1;
        else if(max_sound_wave <= 2000) sound_level = 2;
        else if(max_sound_wave <= 2200) sound_level = 3;
        else if(max_sound_wave <= 2400) sound_level = 4;
        else if(max_sound_wave <= 2600) sound_level = 5;
        else if(max_sound_wave <= 2800) sound_level = 6;
        else if(max_sound_wave <= 3000) sound_level = 7;
        else if(max_sound_wave <= 3200) sound_level = 8;
        else if(max_sound_wave <= 3400) sound_level = 9;
        else if(max_sound_wave <= 3600) sound_level = 10;
        else if(max_sound_wave <= 3800) sound_level = 11;
        else sound_level = 12;
    end
endmodule

