`timescale 1ns / 1ps

module mux21(S, D1, D2, Y);
    input S;
    input [31:0] D1;
    input [31:0] D2;
    output [31:0] Y;
    
    assign Y = (S == 1'b0) ? D1:D2;
    
endmodule
