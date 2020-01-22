`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2019 20:19:38
// Design Name: 
// Module Name: custom_wave_module
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


module custom_wave_module(input clk_12hz, input btn_u, input btn_d, input btn_l,
    input btn_r, input sw11, output reg [30:0] m, output reg [9:0] A);
    
    initial begin
        m = 2499; //initial frequency of wave is set to 20khz
        A = 200; //initial amplitude of wave is set to 200px
    end
    
    always @(posedge clk_12hz) begin
        if(sw11)
            begin
                if(btn_u) 
                    begin
                        //increase frequency of wave
                        m = (m <= 10000) ? 15000 : m - 5;
                    end
                 else if(btn_d)
                    begin
                        m = (m >= 16666660) ? 16666660 : m + 5;
                    end
                 else if(btn_l)
                    begin
                        A = (A<=20) ? 20: A - 1;
                    end
                 else if(btn_r)
                    begin
                        A = (A>=450) ? 450 : A + 1;
                    end
            end
        else 
            begin
                m = 2499; //reset clock to original 20khz
                A = 200; //reset amplitude to original amplitude
            end
    end
    
endmodule
