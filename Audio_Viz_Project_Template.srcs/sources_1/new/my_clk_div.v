`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2019 22:37:30
// Design Name: 
// Module Name: my_clk_div
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

module my_clk_div(input basys_clk, input [30:0] m, output reg Q);
    reg [30:0] count;
    initial begin
        count = 0; 
    end
    always @(posedge basys_clk) begin
        if(count == m)
            begin
                Q = ~Q;
                count = 0;
            end
        else
            count = count + 1;
    end
endmodule
