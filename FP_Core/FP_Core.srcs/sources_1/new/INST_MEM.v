
//
//Instruction memory takes in two inputs: A 32-bit Program counter and a 1-bit reset. 
//The memory is initialized when reset is 1.
//When reset is set to 0, Based on the value of PC, corresponding 32-bit Instruction code is output
// 
// For R Type risc instruction
//            | funct7 |   rs2  |   rs1  | funct3 |   rd   | opcode |
//            |--------|--------|--------|--------|--------|--------|
//            | 7 bits | 5 bits | 5 bits | 3 bits | 5 bits | 7 bits |
module INST_MEM(
    input [31:0] PC,
    input reset,
    output [31:0] Instruction_Code
);
    reg [7:0] Memory [31:0]; // Byte addressable memory with 32 locations

    // Under normal operation (reset = 0), we assign the instr. code, based on PC
    assign Instruction_Code = {Memory[PC+3],Memory[PC+2],Memory[PC+1],Memory[PC]};

    // Initializing memory when reset is one
    always @(reset)
    begin
        if(reset == 1)
        begin
            // Setting 32-bit instruction: vmul rd, r1, r2 => 0x0220B1B3
            // Vedic Multiplier Codes
            // funct7   =   0000000
            // rs2      =   00010
            // rs1      =   00001
            // funct3   =   011
            // rd       =   00011
            // opcode   =   0110011
            // 0020B1B3
            Memory[3] = 8'h00;
            Memory[2] = 8'h20;
            Memory[1] = 8'hb1;
            Memory[0] = 8'hb3;
            // new one 
            // funct7   =   0000000
            // rs2      =   00100
            // rs1      =   00101
            // funct3   =   011
            // rd       =   00110
            // opcode   =   0110011
            // 0042B333
            Memory[7] = 8'h00;
            Memory[6] = 8'h42;
            Memory[5] = 8'hb3;
            Memory[4] = 8'h33;
              // new one 
            // funct7   =   0000000
            // rs2      =   01000
            // rs1      =   00111
            // funct3   =   011
            // rd       =   01001
            // opcode   =   0110011
            // 0083B4B3
            Memory[11] = 8'h00;
            Memory[10] = 8'h83;
            Memory[9] = 8'hb4;
            Memory[8] = 8'h33;
        end
    end

endmodule




