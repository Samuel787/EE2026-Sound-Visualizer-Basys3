`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2019 01:14:05
// Design Name: 
// Module Name: my_running_min
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


module my_running_min(input clk_20khz, input [11:0] wave, output reg [11:0] result_wave);
reg[12:0] sub_clock; //this clock runs at 5hz
reg[11:0] temp_min;
initial begin
    result_wave = 0;
    sub_clock = 0;
    temp_min = 0;
end

always @(posedge clk_20khz) begin
    temp_min = (wave < temp_min) ? wave : temp_min;
    sub_clock = sub_clock + 1;
    if(sub_clock == 1999)
        begin
            //reset the sub_clock
            sub_clock = 0;
            //set the result_wave
            result_wave = temp_min;
            //reset the temp_max which wont affect result_wave
            temp_min = 0;
        end
end
endmodule
