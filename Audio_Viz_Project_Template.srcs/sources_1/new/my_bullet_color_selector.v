`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2019 03:05:52
// Design Name: 
// Module Name: my_bullet_color_selector
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


module my_bullet_color_selector(input clk_80hz, input [11:0] sound_max, 
    input sw13,
    input sw14,
    input sw15,
    output reg [3:0] bullet_red,
    output reg [3:0] bullet_green,
    output reg [3:0] bullet_blue);
    
    always @(posedge clk_80hz) begin
        if(sound_max >= 4000) 
            begin
                bullet_red = 4'hF;
                bullet_green = 4'h0;
                bullet_blue = 4'h0;
            end
        else if(sound_max >= 3800)
            begin
                bullet_red = 4'hF;
                bullet_green = 4'hF;
                bullet_blue = 4'h0;
            end
        else if(sound_max >= 3400)
            begin
                bullet_red = 4'h0;
                bullet_green = 4'hF;
                bullet_blue = 4'h0;
            end
        else if(sound_max >= 3000)
            begin
                bullet_red = 4'h0;
                bullet_green = 4'h0;
                bullet_blue = 4'hF;
            end
       else 
            begin
                bullet_red = 4'h0;
            bullet_green = 4'h0;
            bullet_blue = 4'h0;                  
            end
     
    end
endmodule
