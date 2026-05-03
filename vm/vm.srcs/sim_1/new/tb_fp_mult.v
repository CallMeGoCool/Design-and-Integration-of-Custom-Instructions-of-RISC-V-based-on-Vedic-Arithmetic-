`timescale 1ns/1ps

module tb_fp_mult;
    reg [31:0] a, b;
    wire [31:0] p;

    // Instantiate your floating-point multiplier
    fp_mult uut (
        .a(a),
        .b(b),
        .p(p)
    );

    // Helper task to display float as hex and decimal
    task display_float;
        input [31:0] f;
        real r;
        begin
            r = $bitstoreal({1'b0, f[30:0]}); // This is approximate, better to check externally for exact decimal
            $display("Hex: 0x%08h", f);
        end
    endtask

    initial begin
        $monitor("Time=%0t | a=0x%08h b=0x%08h => p=0x%08h", $time, a, b, p);

        // Test cases: hex representation of float numbers
        // 3.14 * 2.71
        a = 32'h4048F5C3;  // 3.14
        b = 32'h402D70A4;  // 2.71
        #100;

        // 0.1 * 10.0
        a = 32'h3DCCCCCD;  // 0.1
        b = 32'h41200000;  // 10.0
        #100;

        // Large numbers: 123456.0 * 78910.0
        a = 32'h47F12000;  // 123456.0
        b = 32'h47164800;  // 78910.0
        #100;

        // Edge case: 0 * 1.0
        a = 32'h00000000;  // 0.0
        b = 32'h3F800000;  // 1.0
        #100;
        
                // 1.5 * 4.0
        a = 32'h3FC00000;  // 1.5
        b = 32'h40800000;  // 4.0
        #100;
        
                    // 1.5 * 4.12
        a = 32'h3FC00000;  // 1.5
        b = 32'h40833333;  // 4.0
        #100;
       

        $finish;
    end
endmodule
