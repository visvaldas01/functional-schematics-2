`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2023 16:46:08
// Design Name: 
// Module Name: sqrt
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


module sqrt(
    input clk_i,
    input rst_i,
    
    input [7:0] x_bi,
    input start_i,
    
    output wire [1:0] busy_o,
    output reg [6:0] y_bo
);

    localparam IDLE = 2'b00;
    localparam Y_WORK = 2'b01;
    localparam X_WORK = 2'b10;
    
    reg [7:0] m; // счётчик
    reg [7:0] x;
    reg [6:0] y;
    reg [7:0] b;
    reg [1:0] state;
    
    assign busy_o = state;
    assign end_step = (m == 0);
    assign x_ge_b = (x >= b);
    
    always @(posedge clk_i)
        if (rst_i) begin
            m <= 1 << 6;
            y <= 0;
            y_bo <= 0;
            
            state <= IDLE;
        end else begin
            case (state)
                IDLE:
                    if (start_i) begin
                        state <= Y_WORK;
                        
                        x <= x_bi;
                        m <= 1 << 6;
                        y <= 0;
                    end
                Y_WORK:
                    begin
                        if (end_step) begin
                            state <= IDLE;
                            y_bo <= y;
                        end
                        else begin
                            b <= y | m;
                            y <= y >> 1;
                            state <= X_WORK;
                        end
                    end
                X_WORK:
                    begin                        
                        if (x_ge_b) begin
                            x <= x - b;
                            y <= y | m;
                        end
                        m <= m >> 2;
                        state <= Y_WORK;
                    end
            endcase
        end
        
endmodule
