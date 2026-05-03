`timescale 1ns/1ps

module tb_vedic_32x32;

    reg  [31:0] a, b;
    wire [63:0] p;
    reg  [63:0] expected;

    // Instantiate the unsigned Vedic multiplier
    vedic_32x32 uut (
        .a(a),
        .b(b),
        .p(p)
    );

    initial begin
        $display("=====================================================================");
        $display("|  Time   |         a         |         b         |   Output   | Expected |");
        $display("=====================================================================");

        test_case(0, 0);
        test_case(429496001, 429497003);               // Use positive value only
        test_case(1234, 567);
        test_case(32768, 32768);           // Only positive values
        test_case(32'hFFFFFFF0, 32'hFFFFFFF0);
        test_case(100, 4500);
        test_case(1, 1);
        test_case(123456, 789109);
        test_case(12345678, 87654321);
        test_case(2000000000, 2);
        test_case(32'hF8F8F8F8, 32'h00000002); // Example: large unsigned number * 2

        $display("=====================================================================");
        $finish;
    end

    task test_case(input [31:0] in1, input [31:0] in2);
    begin
        a = in1;
        b = in2;

        #1; // Let a and b settle
        expected = a * b;

        #9; // Wait for multiplier output

        $display("Time=%0t | a=%11d | b=%11d | p=%12d | expected=%12d", 
                  $time, a, b, p, expected);

        if (p !== expected)
            $display(">> MISMATCH ❌ => a*b = %0d * %0d = %0d, but got %0d", a, b, expected, p);
        else
            $display(">> MATCH ✅");

        $display("Binary Output   : %064b", p);
        $display("Hex Output      : %016h", p);
        $display("------------------------------------------------------");

        #90;
    end
    endtask

endmodule
