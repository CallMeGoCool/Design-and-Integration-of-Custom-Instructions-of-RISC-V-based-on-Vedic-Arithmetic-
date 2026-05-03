`timescale 1ns/1ps

module vedic_8x8 (
    input [7:0] a, b,
    output [15:0] p
);
    wire [7:0] p0, p1, p2, p3;
    wire [15:0] temp1, temp2, temp3;
    wire [8:0] sum_p1_p2;  // just 9 bits needed for carry

    vedic_4x4 u0 (a[3:0], b[3:0], p0);
    vedic_4x4 u1 (a[7:4], b[3:0], p1);
    vedic_4x4 u2 (a[3:0], b[7:4], p2);
    vedic_4x4 u3 (a[7:4], b[7:4], p3);

    assign sum_p1_p2 = p1 + p2;             // now safe from overflow
    assign temp1 = {8'b0, p0};              // p0 << 0
    assign temp2 = sum_p1_p2 << 4;          // (p1 + p2) << 4
    assign temp3 = {p3, 8'b0};              // p3 << 8

    assign p = temp1 + temp2 + temp3;
endmodule

