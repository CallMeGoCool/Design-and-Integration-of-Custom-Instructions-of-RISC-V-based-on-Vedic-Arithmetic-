`timescale 1ns/1ps


module vedic_24x24 (
    input  [23:0] a, b,
    output [47:0] p
);
    wire [15:0] p0, p1, p2, p3, p4, p5, p6, p7, p8;
    wire [31:0] temp1, temp2, temp3, temp4, temp5, temp6;

    // Break inputs into 3 parts of 8 bits each
    // a_hi = a[23:16], a_mid = a[15:8], a_lo = a[7:0]
    // b_hi = b[23:16], b_mid = b[15:8], b_lo = b[7:0]

    vedic_8x8 u0 (a[7:0],    b[7:0],    p0);  // a_lo * b_lo
    vedic_8x8 u1 (a[15:8],   b[7:0],    p1);  // a_mid * b_lo
    vedic_8x8 u2 (a[23:16],  b[7:0],    p2);  // a_hi * b_lo
    vedic_8x8 u3 (a[7:0],    b[15:8],   p3);  // a_lo * b_mid
    vedic_8x8 u4 (a[15:8],   b[15:8],   p4);  // a_mid * b_mid
    vedic_8x8 u5 (a[23:16],  b[15:8],   p5);  // a_hi * b_mid
    vedic_8x8 u6 (a[7:0],    b[23:16],  p6);  // a_lo * b_hi
    vedic_8x8 u7 (a[15:8],   b[23:16],  p7);  // a_mid * b_hi
    vedic_8x8 u8 (a[23:16],  b[23:16],  p8);  // a_hi * b_hi

    // Now sum partial products with proper shifting
    // Each multiplication produces 16-bit results
    // Shifts: 
    // p0 at [0], p1 and p3 shifted by 8 bits, p2, p5, p7 shifted by 16 bits, p4 shifted by 16 bits, p6 shifted by 16 bits, p8 shifted by 32 bits

    wire [47:0] pp0 = {32'b0, p0};
    wire [47:0] pp1 = {24'b0, p1, 8'b0};
    wire [47:0] pp2 = {16'b0, p2, 16'b0};
    wire [47:0] pp3 = {24'b0, p3, 8'b0};
    wire [47:0] pp4 = {16'b0, p4, 16'b0};
    wire [47:0] pp5 = {16'b0, p5, 16'b0};
    wire [47:0] pp6 = {16'b0, p6, 16'b0};
    wire [47:0] pp7 = {16'b0, p7, 16'b0};
    wire [47:0] pp8 = {p8, 32'b0};

    wire [47:0] sum1 = pp0 + pp1 + pp3;
    wire [47:0] sum2 = pp2 + pp4 + pp5 + pp6 + pp7;
    wire [47:0] sum3 = sum1 + sum2 + pp8;

    assign p = sum3;

endmodule
