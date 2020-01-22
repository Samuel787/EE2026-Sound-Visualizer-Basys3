`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2019 12:04:21
// Design Name: 
// Module Name: project_menu_screen
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


module project_menu_screen(input clk_vga, input [11:0] vga_horz_coord, input [11:0] vga_vert_coord, output [4:0] main_menu_words);
     
     Pixel_On_Text2 #(.displayText("EE2026 Project by Marc and Samuel")) title(
        clk_vga,
        200, // text position.x (top left)
        200, // text position.y (top left)
        vga_horz_coord, // current position.x
        vga_vert_coord, // current position.y
        main_menu_words[0]  // result, 1 if current pixel is on text, 0 otherwise
    );
    
    Pixel_On_Text2 #(.displayText("Sound Visualizer[sw14]")) sub_text1(
       clk_vga,
       580, // text position.x (top left)
       480, // text position.y (top left)
       vga_horz_coord, // current position.x
       vga_vert_coord, // current position.y
       main_menu_words[1]  // result, 1 if current pixel is on text, 0 otherwise
   );
   
    Pixel_On_Text2 #(.displayText("Game[sw13]")) sub_text2(
      clk_vga,
      580, // text position.x (top left)
      510, // text position.y (top left)
      vga_horz_coord, // current position.x
      vga_vert_coord, // current position.y
      main_menu_words[2]  // result, 1 if current pixel is on text, 0 otherwise
  );
  
   Pixel_On_Text2 #(.displayText("Help[sw12]")) sub_text3(
     clk_vga,
     580, // text position.x (top left)
     540, // text position.y (top left)
     vga_horz_coord, // current position.x
     vga_vert_coord, // current position.y
     main_menu_words[3]// result, 1 if current pixel is on text, 0 otherwise
 );
 Pixel_On_Text2 #(.displayText("Toggle switch 15 to change between Task 2 and special features")) t1(
    clk_vga,
    200, // text position.x (top left)
    820, // text position.y (top left)
    vga_horz_coord, // current position.x
    vga_vert_coord, // current position.y
    main_menu_words[4]  // result, 1 if current pixel is on text, 0 otherwise
); 
 
    
    
endmodule
