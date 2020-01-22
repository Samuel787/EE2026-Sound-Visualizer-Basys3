`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2019 19:26:58
// Design Name: 
// Module Name: game_texts
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


module game_texts(input clk_vga, input[11:0] VGA_horzCoord, input[11:0] VGA_vertCoord, output[20:0] res);
    Pixel_On_Text2 #(.displayText("Score: ")) high_score_text(
         clk_vga,
         40, // text position.x (top left)
         40, // text position.y (top left)
         VGA_horzCoord, // current position.x
         VGA_vertCoord, // current position.y
         res[0]  // result, 1 if current pixel is on text, 0 otherwise
     );
     
     Pixel_On_Text2 #(.displayText("0")) high_score_0(
          clk_vga,
          100, // text position.x (top left)
          40, // text position.y (top left)
          VGA_horzCoord, // current position.x
          VGA_vertCoord, // current position.y
          res[20]  // result, 1 if current pixel is on text, 0 otherwise
      );
      
     Pixel_On_Text2 #(.displayText("1")) high_score_1(
          clk_vga,
          100, // text position.x (top left)
          40, // text position.y (top left)
          VGA_horzCoord, // current position.x
          VGA_vertCoord, // current position.y
          res[1]  // result, 1 if current pixel is on text, 0 otherwise
      );
      
     Pixel_On_Text2 #(.displayText("2")) high_score_2(
           clk_vga,
           100, // text position.x (top left)
           40, // text position.y (top left)
           VGA_horzCoord, // current position.x
           VGA_vertCoord, // current position.y
           res[2]  // result, 1 if current pixel is on text, 0 otherwise
       );
     
          Pixel_On_Text2 #(.displayText("3")) high_score_3(
            clk_vga,
            100, // text position.x (top left)
            40, // text position.y (top left)
            VGA_horzCoord, // current position.x
            VGA_vertCoord, // current position.y
            res[3]  // result, 1 if current pixel is on text, 0 otherwise
        );
        
                  Pixel_On_Text2 #(.displayText("4")) high_score_4(
          clk_vga,
          100, // text position.x (top left)
          40, // text position.y (top left)
          VGA_horzCoord, // current position.x
          VGA_vertCoord, // current position.y
          res[4]  // result, 1 if current pixel is on text, 0 otherwise
      );
      
                Pixel_On_Text2 #(.displayText("5")) high_score_5(
        clk_vga,
        100, // text position.x (top left)
        40, // text position.y (top left)
        VGA_horzCoord, // current position.x
        VGA_vertCoord, // current position.y
        res[5]  // result, 1 if current pixel is on text, 0 otherwise
    );
    
              Pixel_On_Text2 #(.displayText("6")) high_score_6(
      clk_vga,
      100, // text position.x (top left)
      40, // text position.y (top left)
      VGA_horzCoord, // current position.x
      VGA_vertCoord, // current position.y
      res[6]  // result, 1 if current pixel is on text, 0 otherwise
  );
  
            Pixel_On_Text2 #(.displayText("7")) high_score_7(
    clk_vga,
    100, // text position.x (top left)
    40, // text position.y (top left)
    VGA_horzCoord, // current position.x
    VGA_vertCoord, // current position.y
    res[7]  // result, 1 if current pixel is on text, 0 otherwise
);

          Pixel_On_Text2 #(.displayText("8")) high_score_8(
            clk_vga,
            100, // text position.x (top left)
            40, // text position.y (top left)
            VGA_horzCoord, // current position.x
            VGA_vertCoord, // current position.y
            res[8]  // result, 1 if current pixel is on text, 0 otherwise
        );
        
                  Pixel_On_Text2 #(.displayText("9")) high_score_9(
          clk_vga,
          100, // text position.x (top left)
          40, // text position.y (top left)
          VGA_horzCoord, // current position.x
          VGA_vertCoord, // current position.y
          res[9]  // result, 1 if current pixel is on text, 0 otherwise
      );
      
      
                Pixel_On_Text2 #(.displayText("10")) high_score_10(
        clk_vga,
        100, // text position.x (top left)
        40, // text position.y (top left)
        VGA_horzCoord, // current position.x
        VGA_vertCoord, // current position.y
        res[10]  // result, 1 if current pixel is on text, 0 otherwise
    );
    
    
endmodule

