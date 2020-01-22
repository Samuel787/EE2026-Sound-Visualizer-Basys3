`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2019 23:22:23
// Design Name: 
// Module Name: my_running_max
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

module my_running_max(input clk_20khz, input [11:0] wave, output reg [11:0] result_wave);
    reg[12:0] sub_clock; //this clock runs at 2Hz
    reg[11:0] temp_max;
    initial begin
        result_wave = 0;
        sub_clock = 0;
        temp_max = 0;
    end
    
    always @(posedge clk_20khz) begin
        temp_max = (wave > temp_max) ? wave : temp_max;
        sub_clock = sub_clock+1;
        if(sub_clock == 1999)
            begin
                //reset sub_clock
                sub_clock = 0;
                //set the result_wave
                result_wave = temp_max;
                //reset the temp_max which wont affect result_wave
                temp_max = 0;
            end    
    end
endmodule
