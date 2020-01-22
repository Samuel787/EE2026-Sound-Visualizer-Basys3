`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2019 18:54:08
// Design Name: 
// Module Name: pseudo_wave_gen
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


module pseudo_wave_gen(input clk, input clk_80hz, input [9:0] variable_A,
  input sw11, input sw13, input sw14, input sw15,
 input btnC, output reg [9:0] count);
    reg flag, flag0, flag1; //0 for rising and 1 for falling
    wire btn_c;
    reg [1:0] counter;
    reg [12:0] square_timer; 
    reg [1:0] curve_timer;
    single_pulse pulse_middle(clk_80hz, btnC, btn_c);
    
    initial begin
        count = 512;
        flag = 0;
        flag0 = 0;
        flag1 = 0;
        counter = 0;
        square_timer = 0;
        curve_timer = 0;
    end
    
    always @(posedge clk_80hz) begin
        counter = (btn_c && sw15 && sw14 && !sw13 && sw11) ? counter + 1: counter; //auto overflow
    end
    
    always @(posedge clk) begin 
        if(counter == 0) 
            begin
                //Triangle tooth graph
                if(count == 512-variable_A) flag = 0; //set to rising mode
                else if(count == 512+variable_A) flag = 1; //set to falling mode
                
                count = (flag) ? count - 1 : count + 1; //set value of count
            end
        else if(counter == 1)
            begin
                //Saw tooth graph
                if(count == 512-variable_A) flag = 0; //set to rising mode
                else if(count == 512+variable_A) flag = 1; //set to falling mode             
                count = (flag) ? 512-variable_A : count + 1; //set value of count
            end
        else if(counter == 2)
            begin
                //square wave graph
                //square_timer = square_timer + 1;
                //if(square_timer == 0) flag = ~flag;
                flag = ~flag;
                count = (flag) ? 512 + variable_A : 512 - variable_A;
            end
        else if(counter == 3)
            begin
                //trapezium wave
            if(count == 512-variable_A) flag = 0; //set to rising mode
            else if(count == 512+variable_A) flag = 1; //set to falling mode             
            count = (flag) ? count - 1: 512+variable_A; //set value of count
            end
         //counter then overflows
    end
endmodule
