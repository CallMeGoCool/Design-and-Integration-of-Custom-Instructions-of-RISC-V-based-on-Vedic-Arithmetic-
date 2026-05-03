`timescale 1ns/1ps

module tb_vedic_32x32_clocked;

    reg clk;
    reg [31:0] a, b;
    wire [63:0] p;
    reg [63:0] expected;

    // Instantiate the clocked Vedic multiplier
    vedic_32x32_clocked uut (
        .clk(clk),
        .a(a),
        .b(b),
        .p(p)
    );

    // Clock generation: 100 MHz (10 ns period)
    initial clk = 0;
    always #5 clk = ~clk;

        initial begin
        $display("=====================================================================");
        $display("|  Time   |         a         |         b         |   Output   | Expected |");
        $display("=====================================================================");

        test_case(32'd0, 32'd0);
        test_case(32'd429496001, 32'd4294967291);
        test_case(32'd1234, 32'd567);
        test_case(32'd32768, 32'd32768);
        test_case(32'hFFFFFFF0, 32'hFFFFFFF0);
        test_case(32'd100, 32'd4500);
        test_case(32'd1, 32'd1);
        test_case(32'd123456, 32'd789109);
        test_case(32'd12345678, 32'd87654321);
        test_case(32'd2000000000, 32'd2);
        test_case(32'hF8F8F8F8, 32'd2);

        $display("=====================================================================");
        $finish;
    end


    task test_case(input [31:0] in1, input [31:0] in2);
    begin
        a = in1;
        b = in2;

        expected = a * b;

        @(posedge clk);  // Wait for rising edge for output to register

        // Small delay after clock edge to ensure output is updated
        #1;

        $display("Time=%0t | a=%11d | b=%11d | p=%12d | expected=%12d", 
                  $time, a, b, p, expected);

        if (p !== expected)
            $display(">> MISMATCH ❌ => a*b = %0d * %0d = %0d, but got %0d", a, b, expected, p);
        else
            $display(">> MATCH ✅");

        $display("Binary Output   : %064b", p);
        $display("Hex Output      : %016h", p);
        $display("------------------------------------------------------");

        #10;  // Complete 100 ns total delay between test cases
    end
    endtask

endmodule
