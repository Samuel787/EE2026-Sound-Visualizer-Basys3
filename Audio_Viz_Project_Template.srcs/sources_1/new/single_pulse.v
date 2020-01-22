`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2019 01:54:19
// Design Name: 
// Module Name: single_pulse
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

module single_pulse(input DFF_CLOCK, input D, output Q);
    wire temp1, temp2;
    my_dff dff1(DFF_CLOCK, D, temp1);
    my_dff dff2(DFF_CLOCK, temp1, temp2);
    assign Q = temp1 & ~temp2; 
endmodule