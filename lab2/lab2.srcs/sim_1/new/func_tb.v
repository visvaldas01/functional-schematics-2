`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2023 02:56:53
// Design Name: 
// Module Name: func_tb
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


module func_tb;
    reg clk_i, rst_i, start_i;
    wire busy_o;
    reg [7:0] a_bi, b_bi;
    wire [15:0] y_bo;
    
    func func_1(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .a_bi(a_bi),
        .b_bi(b_bi),
        .start_i(start_i),
        .busy_o(busy_o),
        .y_bo(y_bo)
    );
    
    integer i = 0;
    integer j = 0;
    
initial begin
    rst_i = 1;
    for (i = 0; i < 256; i = i + 1) begin
        for (j = 0; j < 256; j = j + 1) begin
            a_bi = i;
            b_bi = j;
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
            #10
            if ((b_bi >= (y_bo-a_bi**2)**3) && (b_bi < (y_bo+1-a_bi**2)**3)) begin
                $display("Correct! a_bi = %0d, b_bi = %0d, y_bo = %0d", a_bi, b_bi, y_bo);
            end
            else begin
                $display("Incorrect! a_bi = %0d, b_bi = %0d, y_bo = %0d", a_bi, b_bi, y_bo);
            end
        end
    end
    #10 $stop;
end

endmodule
