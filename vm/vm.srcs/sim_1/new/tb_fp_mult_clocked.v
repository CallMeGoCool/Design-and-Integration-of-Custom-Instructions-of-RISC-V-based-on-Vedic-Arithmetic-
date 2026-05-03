`timescale 1ns/1ps

module tb_fp_mult_clocked;

    reg clk;
    reg [31:0] a, b;
    wire [31:0] p;

    // Instantiate the clocked floating-point multiplier
    fp_mult_clocked uut (
        .clk(clk),
        .a(a),
        .b(b),
        .p(p)
    );

    // Clock generation: 100 MHz (10 ns period)
    initial clk = 0;
    always #5 clk = ~clk;

    // Display result as floating point value
    task print_float_result;
        input [31:0] ain, bin, pout;
        real r_a, r_b, r_p;
        begin
            r_a = $bitstoreal({32'b0, ain}); // simulate conversion
            r_b = $bitstoreal({32'b0, bin});
            r_p = $bitstoreal({32'b0, pout});

            $display("a = 0x%08h | b = 0x%08h | p = 0x%08h", ain, bin, pout);
            $display("→ Float: a = %f | b = %f | p ≈ %f", r_a, r_b, r_p);
            $display("------------------------------------------------------");
        end
    endtask

    // Provide test stimulus
    initial begin
        $display("=====================================================================");
        $display("|    Time    |        a        |        b        |       p (out)     |");
        $display("=====================================================================");

        test_case(32'h4048F5C3, 32'h402D70A4);  // 3.14 * 2.71
        test_case(32'h3DCCCCCD, 32'h41200000);  // 0.1 * 10.0
        test_case(32'h47F12000, 32'h47164800);  // 123456.0 * 78910.0
        test_case(32'h00000000, 32'h3F800000);  // 0.0 * 1.0
        test_case(32'h3FC00000, 32'h40800000);  // 1.5 * 4.0
        test_case(32'h3FC00000, 32'h40833333);  // 1.5 * ~4.1

        $display("=====================================================================");
        $finish;
    end

    task test_case(input [31:0] in1, input [31:0] in2);
    begin
        a = in1;
        b = in2;

        @(posedge clk);
        #1;

        $display("Time=%0t", $time);
        print_float_result(a, b, p);

        #10;
    end
    endtask

endmodule
