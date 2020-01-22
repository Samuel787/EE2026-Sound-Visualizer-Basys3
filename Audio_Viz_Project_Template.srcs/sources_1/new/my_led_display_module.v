`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2019 23:32:54
// Design Name: 
// Module Name: my_led_display_module
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


module my_led_display_module(
    input clk_2hz,
    input [11:0] count,
    output reg [11:0] led
    );
    
    initial begin
        led = 0;
    end
    
    always @ (posedge clk_2hz) begin
      if(count <= 1800) led = 12'b000000000000;
      else if(count <= 2000) led = 12'b000000000001;
      else if(count <= 2200) led = 12'b000000000011;
      else if(count <= 2400) led = 12'b000000000111;
      else if(count <= 2600) led = 12'b000000001111;
      else if(count <= 2800) led = 12'b000000011111;
      else if(count <= 3000) led = 12'b000000111111;
      else if(count <= 3200) led = 12'b000001111111;
      else if(count <= 3400) led = 12'b000011111111;
      else if(count <= 3600) led = 12'b000111111111;
      else if(count <= 3800) led = 12'b001111111111;
      else if(count <= 4000) led = 12'b011111111111;
      else led = 12'b111111111111;
      end
endmodule