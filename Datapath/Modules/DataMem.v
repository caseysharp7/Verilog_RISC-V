`timescale 1ns/1ps

module DataMem(MemRead, MemWrite, addr, write_data, read_data);
    input [8:0] addr;
    input MemWrite;
    input MemRead;
    input [31:0] write_data;
    output reg [31:0] read_data;
    
    reg [31:0] internal_mem[0:127];
    
    initial
    begin
        internal_mem[addr[8:2]] = 32'b0;
    end
    
    always @(*)
    begin
        if(MemWrite == 1)
            internal_mem[addr[8:2]] <= write_data;
    end
    
    always @(*)
    begin
        if(MemRead == 1)
            read_data <= internal_mem[addr[8:2]];
    end
    
endmodule