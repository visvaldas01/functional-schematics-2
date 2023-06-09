`timescale 1ns / 1ps

module mealy(
    input wire clk,
    input wire rst,
    
    input wire [1:0] x,
    output reg [2:0] y
);

    localparam S0 = 0, S1 = 1, S2 = 2;
    localparam X0 = 0, X1 = 1, X2 = 2, X3 = 3;
    
    localparam Y0 = 0, Y1 = 1, Y2 = 2,
               Y3 = 3, Y4 = 4;
    
    reg [1:0] state;
    reg [1:0] state_next;
    reg [2:0] y_next;
    
    // логика формирования следующего состояния
    always @*
        case (state)
            S0: state_next = (x == X0) ? S1 : S0;
            S1: state_next = (x == X1) ? S2 : S1;
            S2: state_next = (x == X2) ? S1 :
                             (x == X3) ? S0 : S2;
            default: state_next = state;
        endcase

    // логика формирования выходного значения
    always @* begin
        y_next = y;
        case (state)
            S0: if (x == X0) y_next = Y1;
            S1: if (x == X1) y_next = Y2;
            S2: begin
                if (x == X2) y_next = Y3;
                if (x == X3) y_next = Y4;
                end
            default: y_next = y;
        endcase
    end
    
    // регистр выходного порта y
    always @(posedge clk)
        if (rst) begin
            y <= Y0;
        end else begin
            y <= y_next;
        end
    
    // регистр состояния
    always @(posedge clk)
        if (rst) begin
            state <= S0;
        end else begin
            state <= state_next;
        end
        
endmodule
