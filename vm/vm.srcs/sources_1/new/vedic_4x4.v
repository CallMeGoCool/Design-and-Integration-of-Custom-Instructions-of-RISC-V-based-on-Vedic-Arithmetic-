`timescale 1ns/1ps

module vedic_4x4 (
    input [3:0] a, b,
    output [7:0] p
);
    wire [3:0] p0, p1, p2, p3;
    wire [4:0] sum_p1_p2;      // max value = 15 + 15 = 30
    wire [7:0] temp1, temp2, temp3;

    vedic_2x2 u0 (a[1:0], b[1:0], p0);
    vedic_2x2 u1 (a[3:2], b[1:0], p1);
    vedic_2x2 u2 (a[1:0], b[3:2], p2);
    vedic_2x2 u3 (a[3:2], b[3:2], p3);

    assign sum_p1_p2 = p1 + p2;
    assign temp1 = {4'b0000, p0};              // p0 << 0
    assign temp2 = sum_p1_p2 << 2;             // (p1 + p2) << 2
    assign temp3 = {p3, 4'b0000};              // p3 << 4

    assign p = temp1 + temp2 + temp3;
endmodule
