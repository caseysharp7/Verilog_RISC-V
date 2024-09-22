`timescale 1ns / 1ps

module InstMem(
    input [7:0] addr,
    output wire [31:0] instruction
    );
    
    wire [31:0] memory [0:63];
    assign instruction = memory[addr[7:2]];
 
    assign memory[0] = 32'h00007033; 
    assign memory[1] = 32'h00100093;
    assign memory[2] = 32'h00200113;
    assign memory[3] = 32'h00308193;
    assign memory[4] = 32'h00408213;
    assign memory[5] = 32'h00510293;
    assign memory[6] = 32'h00610313;
    assign memory[7] = 32'h00718393;
    assign memory[8] = 32'h00208433;
    assign memory[9] = 32'h404404b3;
    assign memory[10] = 32'h00317533;
    assign memory[11] = 32'h0041e5b3;
    assign memory[12] = 32'h0041a633;
    assign memory[13] = 32'h007346b3;
    assign memory[14] = 32'h4d34f713;
    assign memory[15] = 32'h8d35e793;
    assign memory[16] = 32'h4d26a813;
    assign memory[17] = 32'h4d244893;
    assign memory[18] = 32'h02b02823;
    assign memory[19] = 32'h03002603;
    
endmodule