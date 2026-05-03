`include "CONTROL.v"
`include "DATAPATH.v"
`include "IFU.v"

module PROCESSOR( 
    input clock, 
    input reset,
    output zero,
    output [31:0] alu_result_out,
    output [3:0] alu_control_out,
    output [31:0] pc_out,
    output [31:0] instruction_code_out,
    output [31:0] alu_in1,
    output [31:0] alu_in2
);

    wire [31:0] instruction_code;
    wire [3:0] alu_control;
    wire regwrite;
    wire [31:0] alu_result_internal;

    assign alu_control_out = alu_control;
    assign instruction_code_out = instruction_code;
    assign pc_out = PC_internal;
    assign alu_result_out = alu_result_internal;

    wire [31:0] PC_internal;
    IFU IFU_module(clock, reset, instruction_code);
    assign PC_internal = IFU_module.PC; // expose PC

    CONTROL control_module(
        instruction_code[31:25], 
        instruction_code[14:12],
        instruction_code[6:0], 
        alu_control, 
        regwrite
    );

    DATAPATH datapath_module(
        instruction_code[19:15], 
        instruction_code[24:20], 
        instruction_code[11:7],
        alu_control, 
        regwrite, 
        clock, 
        reset, 
        zero,
        alu_result_internal,
        alu_in1,
        alu_in2
    );

endmodule
