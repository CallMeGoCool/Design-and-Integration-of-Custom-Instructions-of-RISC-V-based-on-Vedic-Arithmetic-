`timescale 1ns/1ps

module tb_others;

    reg clk;
    reg [31:0] a;
    wire [63:0] p;
    reg [63:0] expected;

    // Instantiate the Vedic cube module
    vedic_cube uut (
        .clk(clk),
        .a(a),
        .p(p)
    );

    // Clock generation: 100 MHz (10 ns period)
    initial clk = 0;
    always #5 clk = ~clk;

    // Main stimulus
    initial begin
        $display("================================================================================");
        $display("|  Time   |         a         |        Output (a^3)       |     Expected       |");
        $display("================================================================================");

        test_case(32'd0);
        test_case(32'd123);
        test_case(32'd25);
        test_case(32'd1234);
        test_case(32'd1000);


        $display("================================================================================");
        $finish;
    end

    // Task for each test case
    task test_case(input [31:0] in1);
    begin
        a = in1;
        expected = a * a * a;

        @(posedge clk);
        #1;

        $display("Time=%0t | a=%11d | p=%20d | expected=%20d", 
                  $time, a, p, expected);

        if (p !== expected)
            $display(">> MISMATCH ❌ => a³ = %0d³ = %0d, but got %0d", a, expected, p);
        else
            $display(">> MATCH ✅");

        $display("Binary Output   : %064b", p);
        $display("Hex Output      : %016h", p);
        $display("------------------------------------------------------");

        #10;  // Wait between test cases
    end
    endtask

endmodule
