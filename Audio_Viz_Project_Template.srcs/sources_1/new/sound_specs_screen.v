`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2019 00:52:52
// Design Name: 
// Module Name: sound_specs_screen
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


module sound_specs_screen(input clk_vga, input clk_20khz,
 input[11:0] vga_horz_coord, input [11:0] vga_vert_coord, 
 input [11:0] max, input [11:0] avg, input [11:0] min,  
 output [2:0] sound_texts, 
output reg [4:0] max_first = 0, output [4:0] max_first_text);
      
      initial begin
        max_first = 5'b0;
      end
      
      Pixel_On_Text2 #(.displayText("EE2026 ")) max_vol_title(
              clk_vga,
              960, // text position.x (top left)
              60, // text position.y (top left)
              vga_horz_coord, // current position.x
              vga_vert_coord, // current position.y
              sound_texts[0]  // result, 1 if current pixel is on text, 0 otherwise
          );
          
      Pixel_On_Text2 #(.displayText("Sound Visualizations ")) avg_vol_title(
                  clk_vga,
                  960, // text position.x (top left)
                  100, // text position.y (top left)
                  vga_horz_coord, // current position.x
                  vga_vert_coord, // current position.y
                  sound_texts[1]  // result, 1 if current pixel is on text, 0 otherwise
              );
              
      Pixel_On_Text2 #(.displayText("By Marc and Samuel")) min_vol_title(
                      clk_vga,
                      960, // text position.x (top left)
                      140, // text position.y (top left)
                      vga_horz_coord, // current position.x
                      vga_vert_coord, // current position.y
                      sound_texts[2]  // result, 1 if current pixel is on text, 0 otherwise
                  );                        
     
     
     //can slow down the clock somemore...
     always @(posedge clk_20khz) begin
        //extracting digits from max 
        case (max/1000) 
            0: begin
                max_first[0] = 1;
                max_first[1] = 0;
                max_first[2] = 0;
                max_first[3] = 0;
                max_first[4] = 0;
                end
            1: 
                begin
                max_first[0] = 0;
                max_first[1] = 1;
                max_first[2] = 0;
                max_first[3] = 0;
                max_first[4] = 0;
                end
            2:
                begin
                max_first[0] = 0;
                max_first[1] = 0;
                max_first[2] = 1;
                max_first[3] = 0;
                max_first[4] = 0;
                end
            3: begin
                                max_first[0] = 0;
            max_first[1] = 0;
            max_first[2] = 0;
            max_first[3] = 1;
            max_first[4] = 0;
                end
            4: begin
                 max_first[0] = 0;
                 max_first[1] = 0;
                 max_first[2] = 0;
                 max_first[3] = 0;
                 max_first[4] = 1;
                end
            default: max_first = 5'b0;
        endcase
        
     end
     
     
     
     //the mess of pixels
     //MAX BEGIN
     
           Pixel_On_Text2 #(.displayText("0")) max_first0(
                     clk_vga,
                     1060, // text position.x (top left)
                     60, // text position.y (top left)
                     vga_horz_coord, // current position.x
                     vga_vert_coord, // current position.y
                     max_first_text[0]  // result, 1 if current pixel is on text, 0 otherwise
                 );
                 
                      Pixel_On_Text2 #(.displayText("0")) max_first1(
                           clk_vga,
                           1060, // text position.x (top left)
                           60, // text position.y (top left)
                           vga_horz_coord, // current position.x
                           vga_vert_coord, // current position.y
                           max_first_text[1]  // result, 1 if current pixel is on text, 0 otherwise
                       );
                       
                       
                                  Pixel_On_Text2 #(.displayText("0")) max_first2(
                                 clk_vga,
                                 1060, // text position.x (top left)
                                 60, // text position.y (top left)
                                 vga_horz_coord, // current position.x
                                 vga_vert_coord, // current position.y
                                 max_first_text[2]  // result, 1 if current pixel is on text, 0 otherwise
                             );
                             
                                        Pixel_On_Text2 #(.displayText("0")) max_first3(
                                       clk_vga,
                                       1060, // text position.x (top left)
                                       60, // text position.y (top left)
                                       vga_horz_coord, // current position.x
                                       vga_vert_coord, // current position.y
                                       max_first_text[3]  // result, 1 if current pixel is on text, 0 otherwise
                                   );
                                   
                                              Pixel_On_Text2 #(.displayText("0")) max_first4(
                                             clk_vga,
                                             1060, // text position.x (top left)
                                             60, // text position.y (top left)
                                             vga_horz_coord, // current position.x
                                             vga_vert_coord, // current position.y
                                             max_first_text[4]  // result, 1 if current pixel is on text, 0 otherwise
                                         ); 
endmodule
