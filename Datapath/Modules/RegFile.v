`timescale 1 ns / 1 ps

module RegFile(
    clk, reset, rg_wrt_en,
    rg_wrt_addr,
    rg_rd_addr1,
    rg_rd_addr2,
    rg_wrt_data,
    rg_rd_data1,
    rg_rd_data2
    );
    
    input clk;
    input reset;
    input rg_wrt_en;
    input [4:0] rg_wrt_addr;
    input [4:0] rg_rd_addr1;
    input [4:0] rg_rd_addr2;
    input [31:0] rg_wrt_data;
    output wire [31:0] rg_rd_data1;
    output wire [31:0] rg_rd_data2;
    
    reg [31:0] register_file [0:31];
    
    integer i;
    
    always @(posedge reset)
    begin
        if(reset == 1)
        begin
            for(i = 0; i < 32; i = i + 1)
                register_file[i] = 32'b0;
        end
    end
    
    always @(posedge clk)
    begin
        if(rg_wrt_en == 1 && reset != 1)
        begin
            register_file[rg_wrt_addr] <= rg_wrt_data;
        end
    end
    
    assign rg_rd_data1 = register_file[rg_rd_addr1];
    assign rg_rd_data2 = register_file[rg_rd_addr2];
    
endmodule