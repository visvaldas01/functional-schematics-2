`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2023 17:39:18
// Design Name: 
// Module Name: sqrt_tb
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


module sqrt_tb;
    reg clk_i, rst_i, start_i;
    wire [1:0] busy_o;
    reg [7:0] x_bi;
    wire [3:0] y_bo;
    
    sqrt sqrt_1(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .x_bi(x_bi),
        .start_i(start_i),
        .busy_o(busy_o),
        .y_bo(y_bo)
    );
    
    integer i = 0;
    
initial begin
    for (i = 0; i < 256; i = i + 1) begin
        x_bi = i;
        rst_i = 1;
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
            start_i = 0;
            clk_i = 0;
            #10
            clk_i = 1;
        end
        #10
        if ((x_bi >= y_bo**2) && (x_bi < (y_bo+1)**2)) begin
            $display("Correct! x_bi = %0d, y_bo = %0d", x_bi, y_bo);
        end
        else begin
            $display("Incorrect! x_bi = %0d, y_bo = %0d", x_bi, y_bo);
        end
    end
    #10 $stop;
end

endmodule
