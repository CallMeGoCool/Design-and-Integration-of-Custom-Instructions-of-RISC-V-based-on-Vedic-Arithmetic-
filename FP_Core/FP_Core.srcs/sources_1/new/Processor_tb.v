`timescale 1ns/1ps
`include "PROCESSOR.v"

module stimulus ();
    
    reg clock;
    reg reset;
    wire zero;
    wire [31:0] pc_out, instruction_code_out;
    wire [31:0] alu_result_out;
    wire [3:0] alu_control_out;
    wire [31:0] alu_in1;
    wire [31:0] alu_in2;

    PROCESSOR test_processor(
        .clock(clock), 
        .reset(reset), 
        .zero(zero),
        .alu_result_out(alu_result_out),
        .alu_control_out(alu_control_out),
        .pc_out(pc_out),
        .instruction_code_out(instruction_code_out),
        .alu_in1(alu_in1),
        .alu_in2(alu_in2)
    );

    initial begin
        clock = 0;
        forever #20 clock = ~clock;
    end

    initial begin
        reset = 1;
        #50 reset = 0;
    end

    initial begin
        $monitor("Time: %0dns | PC: %h | Instr: %h | ALU_ctrl: %b | ALU_result: %h | Zero: %b | INP1: %b | | INP2: %b",
            $time, pc_out, instruction_code_out, alu_control_out, alu_result_out, zero, alu_in1, alu_in2);
    end

    initial begin
        #200 $finish;
    end

endmodule

