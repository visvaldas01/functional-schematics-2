`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.03.2023 17:06:02
// Design Name: 
// Module Name: mealy_tb
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


module mealy_tb;
    
    reg clk, rst;
    reg [1:0] x;
    wire [2:0] y;
    
    mealy mealy_1(
        .clk(clk),
        .rst(rst),
        .x(x),
        .y(y)
    );
    
    integer i;
    
initial begin    
    x = 0;
    clk = 1;
    rst = 1;
    #10
    clk = 0;
    rst = 0;
    #10
    rst = 0;
    clk = 1;
    #10
    clk = 0;
    x = 1;
    #10
    rst = 0;
    clk = 1;
    #10
    clk = 0;
    x = 2;
    #10
    rst = 0;
    clk = 1;
    #10
    clk = 0;
    x = 1;
    #10
    rst = 0;
    clk = 1;
    #10
    clk = 0;
    x = 3;
    #10
    rst = 0;
    clk = 1;
    #10
    clk = 0;
    #10 $stop;
    end


//initial begin
//        x = 0;
//        clk = 1;
//        rst = 1;
//        #10
//        clk = 0;
//        rst = 0;
//        for (i = 0; i < 4; i = i + 1) begin
//            x = i;
//            #10
//            rst = 0;
//            clk = 1;
//            #10
//            clk = 0;
//        end
//        #10 $stop;
//    end
endmodule
