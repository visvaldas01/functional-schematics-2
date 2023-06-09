`timescale 1ns / 1ps

module moore(
    input wire clk,
    input wire rst,
    
    input wire [1:0] x,
    output wire [1:0] y
);

    localparam S0 = 0, S1 = 1, S2 = 2;
    localparam X0 = 0, X1 = 1, X2 = 2, X3 = 3;
    
    reg [1:0] state;
    reg [1:0] state_next;
    
    // логика формирования следующего состояния
    always @*
        case(state)
            S0: state_next = (x == X0) ? S1 : S0;
            S1: state_next = (x == X1) ? S2 : S1;
            S2: state_next = (x == X2) ? S1 :
                             (x == X3) ? S0 : S2;
            default: state_next = state;
        endcase

    // логика формирования выходного значения
    assign y = state;
    
    // регистр состояния
    always @(posedge clk)
        if (rst) begin
            state <= S0;
        end else begin
            state <= state_next;
        end
        
endmodule
