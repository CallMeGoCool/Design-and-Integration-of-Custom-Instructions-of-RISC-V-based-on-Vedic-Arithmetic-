`timescale 1ns / 1ps
module tb_normal_fp_mult;

    reg clk;
    reg [31:0] a;
    reg [31:0] b;
    wire [31:0] result;

    // Instantiate the DUT
    normal_fp_mult uut (
        .clk(clk),
        .a(a),
        .b(b),
        .result(result)
    );

    // Clock generation: 100 MHz (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus
    initial begin
        // Initial values
        a = 0; b = 0;
        #10;  // wait one clock

        // Test Case 1: 1.5 * 2.0 = 3.0
        a = 32'h3FC00000;  // 1.5
        b = 32'h40000000;  // 2.0
        #10;
        $display("Time = %0t | a = %h, b = %h, result = %h", $time, a, b, result);
        // Expected result = 0x40400000 (3.0)

        // Test Case 2: 0.5 * 4.0 = 2.0
        a = 32'h3F000000;  // 0.5
        b = 32'h40800000;  // 4.0
        #10;
        $display("Time = %0t | a = %h, b = %h, result = %h", $time, a, b, result);
        // Expected result = 0x40000000 (2.0)

        // Test Case 3: 2.25 * 3.0 = 6.75
        a = 32'h40100000;  // 2.25
        b = 32'h40400000;  // 3.0
        #10;
        $display("Time = %0t | a = %h, b = %h, result = %h", $time, a, b, result);
        // Expected result = 0x40D80000 (6.75)

        #20;
        $stop;
    end
endmodule
