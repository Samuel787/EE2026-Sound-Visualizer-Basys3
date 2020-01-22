`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2019 03:01:29
// Design Name: 
// Module Name: enemy_color_selector
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


module enemy_color_selector(input clk_vga, input [3:0] random_num, 
    output reg [3:0] enemy_red,
    output reg [3:0] enemy_green,
    output reg [3:0] enemy_blue
);

    always @(posedge clk_vga) begin
        case(random_num)
            0:
                begin
                    enemy_red = 4'hf;
                    enemy_green = 4'h0;
                    enemy_blue = 4'h5;
                end
            1: 
                begin
                    enemy_red = 4'h0;
                    enemy_green = 4'hf;
                    enemy_blue = 4'h4;
                end
            2:
                begin
                                        enemy_red = 4'h0;
                enemy_green = 4'hf;
                enemy_blue = 4'h4;
                end
            3:
                begin
                                    enemy_red = 4'h5;
                enemy_green = 4'hb;
                enemy_blue = 4'h2;
                end
            4:
                begin
                                    enemy_red = 4'hb;
                enemy_green = 4'h2;
                enemy_blue = 4'h5;
                end
            5:
                begin
                                        enemy_red = 4'hf;
                enemy_green = 4'h3;
                enemy_blue = 4'h9;
                end
            default:
                begin
                                    enemy_red = 4'h6;
                enemy_green = 4'h0;
                enemy_blue = 4'h9;
                end
        endcase
    end
endmodule
