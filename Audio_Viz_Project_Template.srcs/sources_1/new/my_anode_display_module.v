`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2019 00:06:15
// Design Name: 
// Module Name: my_anode_display_module
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


module my_anode_display_module(input clk_20khz, input[11:0] led, output reg [3:0] AN, output reg [7:0] seg_7);
    reg count;
    initial begin
        count = 0;
    end
    
    reg [7:0] seg7_one, seg7_two;
    always @(posedge clk_20khz) begin
        count = count + 1;
        //setting the 7 segs
        if(led == 12'b000000000000) //0
            begin
                seg7_one = 8'b11000000;
                seg7_two = 8'b11000000;
            end
        else if(led == 12'b000000000001) //1
            begin
                seg7_one = 8'b11111001;
                seg7_two = 8'b11000000;
            end
        else if(led == 12'b000000000011) //2
            begin
                seg7_one = 8'b10100100;
                seg7_two = 8'b11000000;
            end
        else if(led == 12'b000000000111) //3
            begin
                seg7_one = 8'b10110000;
                seg7_two = 8'b11000000;
            end
        else if(led == 12'b000000001111) //4
            begin
                seg7_one = 8'b10011001;
                seg7_two = 8'b11000000;
            end
        else if(led == 12'b000000011111) //5
            begin
                seg7_one = 8'b10010010;
                seg7_two = 8'b11000000;
            end
        else if(led == 12'b000000111111) //6
            begin
                seg7_one = 8'b10000010;
                seg7_two = 8'b11000000;
            end
        else if(led == 12'b000001111111) //7
            begin
                seg7_one = 8'b11111000;
                seg7_two = 8'b11000000;    
            end
        else if(led == 12'b000011111111) //8
            begin
                seg7_one = 8'b10000000;
                seg7_two = 8'b11000000;   
            end
        else if(led == 12'b000111111111) //9
            begin
                seg7_one = 8'b10010000;
                seg7_two = 8'b11000000;
            end
        else if(led == 12'b001111111111) //10
            begin
                seg7_one = 8'b11000000;
                seg7_two = 8'b11111001;
            end
        else if(led == 12'b011111111111) //11
            begin
                seg7_one = 8'b11111001;
                seg7_two = 8'b11111001; 
            end
        else   //12
            begin
                seg7_one = 8'b10100100;
                seg7_two = 8'b11111001;
            end
            
        //set the anode and seg value
        case(count)
            0: 
                begin
                AN = 4'b1110;
                seg_7 = seg7_one;
                end
            1:  begin
                AN = 4'b1101;
                seg_7 = seg7_two;
                end
        endcase
    end
endmodule
