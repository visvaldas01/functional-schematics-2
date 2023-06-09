`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2023 15:24:34
// Design Name: 
// Module Name: square_tb
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


module square_tb;
    reg clk_i, rst_i, start_i;
    wire busy_o;
    reg [7:0] x_bi;
    wire [15:0] y_bo;
    
    square square_1(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .x_bi(x_bi),
        .start_i(start_i),
        .busy_o(busy_o),
        .y_bo(y_bo)
    );
    
    integer i = 0;
    
initial begin
    rst_i = 1;
    for (i = 0; i < 256; i = i + 1) begin
            x_bi = i;
            clk_i = 1;
            start_i = 0;
            #10
            clk_i = 0;
            start_i = 1;
            #10
            rst_i = 0;
            clk_i = 1;
            #10
            while (busy_o != 0) begin  
                #10
                clk_i = 0;
                start_i = 0;
                #10
                clk_i = 1;
            end
            if (y_bo == i**2) begin
                $display("Correct! x_bi = %0d, y_bo = %0d, expected = %0d", x_bi, y_bo, i**2);
            end
            else begin
                $display("Incorrect! x_bi = %0d, y_bo = %0d, expected = %0d", x_bi, y_bo, i**2);
        end
    end
    #10 $stop;
end

endmodule
