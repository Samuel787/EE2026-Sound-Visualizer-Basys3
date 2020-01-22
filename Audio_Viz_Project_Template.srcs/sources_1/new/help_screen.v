`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2019 21:52:04
// Design Name: 
// Module Name: help_screen
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


module help_screen(input CLK_VGA, input [11:0] VGA_horzCoord, input [11:0] VGA_vertCoord, input[30:0] res);

       Pixel_On_Text2 #(.displayText("EE2026 Instruction Manual")) instruction1(
                CLK_VGA,
                400, // text position.x (top left)
                40, // text position.y (top left)
                VGA_horzCoord, // current position.x
                VGA_vertCoord, // current position.y
                res[0]  // result, 1 if current pixel is on text, 0 otherwise
        );
        
        Pixel_On_Text2 #(.displayText("Initially: Shows Task 2")) instruction2(
                 CLK_VGA,
                 40, // text position.x (top left)
                 80, // text position.y (top left)
                 VGA_horzCoord, // current position.x
                 VGA_vertCoord, // current position.y
                 res[1]  // result, 1 if current pixel is on text, 0 otherwise
         );
       Pixel_On_Text2 #(.displayText("SW1: Display Sound Wave")) instruction3(
                  CLK_VGA,
                  40, // text position.x (top left)
                  110, // text position.y (top left)
                  VGA_horzCoord, // current position.x
                  VGA_vertCoord, // current position.y
                  res[2]  // result, 1 if current pixel is on text, 0 otherwise
          );
       Pixel_On_Text2 #(.displayText("SW1 & Up Button: Change Wave Color")) instruction4(
                     CLK_VGA,
                     40, // text position.x (top left)
                     140, // text position.y (top left)
                     VGA_horzCoord, // current position.x
                     VGA_vertCoord, // current position.y
                     res[3]  // result, 1 if current pixel is on text, 0 otherwise
        );
       Pixel_On_Text2 #(.displayText("SW1 & Down Button: Change Tick Color")) instruction5(
                   CLK_VGA,
                   40, // text position.x (top left)
                   170, // text position.y (top left)
                   VGA_horzCoord, // current position.x
                   VGA_vertCoord, // current position.y
                   res[4]  // result, 1 if current pixel is on text, 0 otherwise
           );
       Pixel_On_Text2 #(.displayText("SW1 & Centre Button: Change Background Color")) instruction6(
                       CLK_VGA,
                       40, // text position.x (top left)
                       200, // text position.y (top left)
                       VGA_horzCoord, // current position.x
                       VGA_vertCoord, // current position.y
                       res[5]  // result, 1 if current pixel is on text, 0 otherwise
               );          
       Pixel_On_Text2 #(.displayText("SW1 & Right Button: Change Grid Color")) instruction7(
                           CLK_VGA,
                           40, // text position.x (top left)
                           230, // text position.y (top left)
                           VGA_horzCoord, // current position.x
                           VGA_vertCoord, // current position.y
                           res[6]  // result, 1 if current pixel is on text, 0 otherwise
                   );
        Pixel_On_Text2 #(.displayText("SW1 & Left Button: Change Axes Color")) instruction8(
                                       CLK_VGA,
                                       40, // text position.x (top left)
                                       260, // text position.y (top left)
                                       VGA_horzCoord, // current position.x
                                       VGA_vertCoord, // current position.y
                                       res[7]  // result, 1 if current pixel is on text, 0 otherwise
                               );                             
       Pixel_On_Text2 #(.displayText("SW2: Freeze waveform")) instruction9(
                                                   CLK_VGA,
                                                   40, // text position.x (top left)
                                                   290, // text position.y (top left)
                                                   VGA_horzCoord, // current position.x
                                                   VGA_vertCoord, // current position.y
                                                   res[8]  // result, 1 if current pixel is on text, 0 otherwise
                                           );
       Pixel_On_Text2 #(.displayText("SW15: Project Menu")) instruction10(
                    CLK_VGA,
                                                               40, // text position.x (top left)
                                                               310, // text position.y (top left)
                                                               VGA_horzCoord, // current position.x
                                                               VGA_vertCoord, // current position.y
                                                               res[9]  // result, 1 if current pixel is on text, 0 otherwise
                                                       );
       Pixel_On_Text2 #(.displayText("SW15 & S14: Sound Visualizer")) instruction11(
                                                                   CLK_VGA,
                                                                   40, // text position.x (top left)
                                                                   340, // text position.y (top left)
                                                                   VGA_horzCoord, // current position.x
                                                                   VGA_vertCoord, // current position.y
                                                                   res[10]  // result, 1 if current pixel is on text, 0 otherwise
                                                           );        
       Pixel_On_Text2 #(.displayText("SW15 & SW14 & SW12: Volume Bar")) instruction12(
                                                                       CLK_VGA,
                                                                       40, // text position.x (top left)
                                                                       370, // text position.y (top left)
                                                                       VGA_horzCoord, // current position.x
                                                                       VGA_vertCoord, // current position.y
                                                                       res[11]  // result, 1 if current pixel is on text, 0 otherwise
                                                               ); 
       Pixel_On_Text2 #(.displayText("SW15 & SW14 & SW11: Preset Waves (up button -> increase freq | down button -> decrease freq | left button -> decrease amplitude | right button -> increase amplitude")) instruction13(
                                                                           CLK_VGA,
                                                                           40, // text position.x (top left)
                                                                           400, // text position.y (top left)
                                                                           VGA_horzCoord, // current position.x
                                                                           VGA_vertCoord, // current position.y
                                                                           res[12]  // result, 1 if current pixel is on text, 0 otherwise
                                                                   );        
       Pixel_On_Text2 #(.displayText("SW15 & SW14 & SW10: Credits textbox")) instruction14(
                                               CLK_VGA,
                                               40, // text position.x (top left)
                                                 430, // text position.y (top left)
                                                 VGA_horzCoord, // current position.x
                                                 VGA_vertCoord, // current position.y
                                                res[13]  // result, 1 if current pixel is on text, 0 otherwise
                                                                       );   
       Pixel_On_Text2 #(.displayText("SW15 & SW14 & SW9: Rainbow")) instruction15(
                                                                                   CLK_VGA,
                                                                                   40, // text position.x (top left)
                                                                                   460, // text position.y (top left)
                                                                                   VGA_horzCoord, // current position.x
                                                                                   VGA_vertCoord, // current position.y
                                                                                   res[14]  // result, 1 if current pixel is on text, 0 otherwise
                                                                           );   
                                                                           
       Pixel_On_Text2 #(.displayText("SW15 & SW14 & Sw8: Piano Waveform")) instruction16(
                                                                                       CLK_VGA,
                                                                                       40, // text position.x (top left)
                                                                                       490, // text position.y (top left)
                                                                                       VGA_horzCoord, // current position.x
                                                                                       VGA_vertCoord, // current position.y
                                                                                       res[15]  // result, 1 if current pixel is on text, 0 otherwise
                                                                               );  
       Pixel_On_Text2 #(.displayText("SW15 & SW14 & SW7: Splat waveform")) instruction17(
                                                                                           CLK_VGA,
                                                                                           40, // text position.x (top left)
                                                                                           520, // text position.y (top left)
                                                                                           VGA_horzCoord, // current position.x
                                                                                           VGA_vertCoord, // current position.y
                                                                                           res[16]  // result, 1 if current pixel is on text, 0 otherwise
                                                                                   );         
       Pixel_On_Text2 #(.displayText("SW15 & SW14 & SW6: Shaded Wave")) instruction18(
                                                                                               CLK_VGA,
                                                                                               40, // text position.x (top left)
                                                                                               550, // text position.y (top left)
                                                                                               VGA_horzCoord, // current position.x
                                                                                               VGA_vertCoord, // current position.y
                                                                                               res[17]  // result, 1 if current pixel is on text, 0 otherwise
                                                                                       ); 
                                                                                       
       Pixel_On_Text2 #(.displayText("SW15 & SW14 & (SW5: Remove background) || (SW4: Remove Axes) || (SW3: Remove Ticks) || (SW2: Remove Grid Lines) || (SW1: Freeze Wave)")) instruction19(
                                                                                                   CLK_VGA,
                                                                                                   40, // text position.x (top left)
                                                                                                   580, // text position.y (top left)
                                                                                                   VGA_horzCoord, // current position.x
                                                                                                   VGA_vertCoord, // current position.y
                                                                                                   res[18]  // result, 1 if current pixel is on text, 0 otherwise
                                                                                           );                  
           
       Pixel_On_Text2 #(.displayText("SW15 & SW14 & SW11 & SW8: Custom Preset Piano Waveform")) instruction20(
                       CLK_VGA,
                       40, // text position.x (top left)
                       610, // text position.y (top left)
                       VGA_horzCoord, // current position.x
                       VGA_vertCoord, // current position.y
                       res[19]  // result, 1 if current pixel is on text, 0 otherwise
               );           
               
       Pixel_On_Text2 #(.displayText("SW15 & SW14 & SW11 & SW7: Custom Preset Splat Waveform")) instruction21(
                           CLK_VGA,
                           40, // text position.x (top left)
                           640, // text position.y (top left)
                           VGA_horzCoord, // current position.x
                           VGA_vertCoord, // current position.y
                           res[20]  // result, 1 if current pixel is on text, 0 otherwise
                   );
                   
      Pixel_On_Text2 #(.displayText("SW15 & SW14 & SW11 & SW6: Custom Preset Shaded Waveform")) instruction22(
                                        CLK_VGA,
                                        40, // text position.x (top left)
                                        670, // text position.y (top left)
                                        VGA_horzCoord, // current position.x
                                        VGA_vertCoord, // current position.y
                                        res[21]  // result, 1 if current pixel is on text, 0 otherwise
                                );    
                                
      Pixel_On_Text2 #(.displayText("SW15 & SW14 & SW11 & SW7 & SW8: More Custom Wave Variants")) instruction23(
                                                     CLK_VGA,
                                                     40, // text position.x (top left)
                                                     700, // text position.y (top left)
                                                     VGA_horzCoord, // current position.x
                                                     VGA_vertCoord, // current position.y
                                                     res[22]  // result, 1 if current pixel is on text, 0 otherwise
                                             );    
      Pixel_On_Text2 #(.displayText("SW15 & SW13: Game")) instruction24(
                                                                  CLK_VGA,
                                                                  40, // text position.x (top left)
                                                                  730, // text position.y (top left)
                                                                  VGA_horzCoord, // current position.x
                                                                  VGA_vertCoord, // current position.y
                                                                  res[23]  // result, 1 if current pixel is on text, 0 otherwise
                                                          );
                                                          
      Pixel_On_Text2 #(.displayText("SW15 & SW12: Help Menu")) instruction26(
                                                                               CLK_VGA,
                                                                               40, // text position.x (top left)
                                                                               760, // text position.y (top left)
                                                                               VGA_horzCoord, // current position.x
                                                                               VGA_vertCoord, // current position.y
                                                                               res[24]  // result, 1 if current pixel is on text, 0 otherwise
                                                                       );                                                                                                       
                                                                                        
                   
                                                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
endmodule
