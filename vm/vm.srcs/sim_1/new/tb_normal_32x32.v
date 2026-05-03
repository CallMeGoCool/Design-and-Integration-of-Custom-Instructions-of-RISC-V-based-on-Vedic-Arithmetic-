`timescale 1ns / 1ps
module tb_normal_32x32;

    reg clk;
    reg [31:0] a;
    reg [31:0] b;
    wire [63:0] product;

    // Instantiate the design under test (DUT)
    normal_32x32 uut (
        .clk(clk),
        .a(a),
        .b(b),
        .product(product)
    );

    // Clock generation: 100MHz (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle every 5ns
    end

    // Stimulus
    initial begin
        // Set inputs
        a = 0; b = 0;
        #10; // wait 1 clock

        a = 32'd12; b = 32'd34;
        #10; // wait 1 clock
        $display("Time = %0t | a = %d, b = %d, product = %d", $time, a, b, product);

        a = 32'd255; b = 32'd255;
        #10;
        $display("Time = %0t | a = %d, b = %d, product = %d", $time, a, b, product);

        a = 32'd123456; b = 32'd654321;
        #10;
        $display("Time = %0t | a = %d, b = %d, product = %d", $time, a, b, product);
        
        
          a = 32'd2147483647; b = 32'd2147483647;
        #10;
        $display("Time = %0t | a = %d, b = %d, product = %d", $time, a, b, product);

        #20;  // wait additional time for last product
        $stop;
    end
endmodule
