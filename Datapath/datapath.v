module data_path #(
    parameter PC_W = 8,
    parameter INS_W = 32,
    parameter RF_ADDRESS = 5,
    parameter DATA_W = 32,
    parameter DM_ADDRESS = 9,
    parameter ALU_CC_W = 4
)(
    input clk,
    input reset,
    input reg_write,
    input mem2reg,
    input alu_src,
    input mem_write,
    input mem_read,
    input [ALU_CC_W -1:0] alu_cc,
    output [6:0] opcode,
    output [6:0] funct7,
    output [2:0] funct3,
    output [DATA_W -1:0] alu_result
);
    wire [PC_W-1:0] PC;
    wire [INS_W-1:0] Instruction;
    wire [DATA_W-1:0] Reg1;
    wire [DATA_W-1:0] Reg2;
    wire [INS_W-1:0] Extlmm;
    wire [DATA_W-1:0] SrcB;
    wire [31:0] ALU_Result;
    wire [31:0] DataMem_read;
    wire [31:0] WriteBack_Data;
    wire [RF_ADDRESS - 1:0] rd_rg_wrt_wire;
    wire [RF_ADDRESS - 1:0] rd_rg_addr_wire1;
    wire [RF_ADDRESS - 1:0] rd_rg_addr_wire2;
    wire [8:0] alu_sum;
    wire Zero;
    wire Carry_Out;
    wire Overflow;
    
    
    FlipFlop flip_flop
    (
        .clk(clk),
        .reset(reset),
        .d(PC + 4),
        .q(PC)
    );
    
    InstMem inst_mem
    (
        .addr(PC),
        .instruction(Instruction)
    );
    
    assign opcode = Instruction[6:0];
    assign funct3 = Instruction[14:12];
    assign funct7 = Instruction[31:25];
    
    assign rd_rg_wrt_wire = Instruction[11:7];
    assign rd_rg_addr_wire1 = Instruction[19:15];
    assign rd_rg_addr_wire2 = Instruction[24:20];
    
    RegFile reg_file
    (
        .clk(clk),
        .reset(reset),
        .rg_wrt_en(reg_write),
        .rg_wrt_addr(rd_rg_wrt_wire),
        .rg_rd_addr1(rd_rg_addr_wire1),
        .rg_rd_addr2(rd_rg_addr_wire2),
        .rg_wrt_data(WriteBack_Data),
        .rg_rd_data1(Reg1),
        .rg_rd_data2(Reg2)
    );
    
    ImmGen imm_gen
    (
        .InstCode(Instruction),
        .ImmOut(Extlmm)
    );
    
    mux21 mux1
    (
        .S(alu_src),
        .D1(Reg2),
        .D2(Extlmm),
        .Y(SrcB)
    );
    
    ALU_32 alu
    (
        .A_in(Reg1),
        .B_in(SrcB),
        .ALU_Sel(alu_cc),
        .ALU_Out(ALU_Result),
        .Zero(Zero),
        .Carry_Out(Carry_Out),
        .Overflow(Overflow)
    );
    
    assign alu_result = ALU_Result;
    assign alu_sum = ALU_Result[8:0];
    
    DataMem data
    (
        .addr(alu_sum),
        .MemWrite(mem_write),
        .MemRead(mem_read),
        .write_data(Reg2),
        .read_data(DataMem_read)
    );
    
    mux21 mux2
    (
        .S(mem2reg),
        .D1(ALU_Result),
        .D2(DataMem_read),
        .Y(WriteBack_Data)
    );   
endmodule
