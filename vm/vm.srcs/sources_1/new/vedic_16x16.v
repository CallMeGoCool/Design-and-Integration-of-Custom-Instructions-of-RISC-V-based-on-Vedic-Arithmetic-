`timescale 1ns/1ps

module vedic_16x16 (
    input [15:0] a, b,
    output [31:0] p
);
    wire [15:0] p0, p1, p2, p3;
    wire [31:0] temp1, temp2, temp3;
    wire [16:0] sum_p1_p2;  // must be 17 bits!

    vedic_8x8 u0 (a[7:0], b[7:0], p0);
    vedic_8x8 u1 (a[15:8], b[7:0], p1);
    vedic_8x8 u2 (a[7:0], b[15:8], p2);
    vedic_8x8 u3 (a[15:8], b[15:8], p3);

    assign sum_p1_p2 = p1 + p2;           // now full 17-bit addition
    assign temp1 = {16'b0, p0};           // p0 << 0
    assign temp2 = sum_p1_p2 << 8;        // shifted correctly
    assign temp3 = {p3, 16'b0};           // p3 << 16

    assign p = temp1 + temp2 + temp3;
endmodule
