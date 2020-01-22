`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2019 01:13:40
// Design Name: 
// Module Name: my_running_avg
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


module my_running_avg(input clk_20khz, input [11:0] wave, output reg [11:0] result_wave);
    reg [12:0] sub_clock; //this clock runs at 5hz
    reg [11:0] temp_wave;
    initial begin
        result_wave = 0;
        sub_clock = 0;
        temp_wave = 0;
    end
    
    always @(posedge clk_20khz) begin
        temp_wave = (wave + temp_wave)/2; //does running average
        sub_clock = sub_clock + 1;
        if(sub_clock == 1999)
            begin
                //reset the sub_clock
                sub_clock = 0;
                //set the result_wave to running avg
                result_wave = temp_wave;
                //reset the temp_wave
                temp_wave = 0; //does averaging on next interval
            end
    end
endmodule
