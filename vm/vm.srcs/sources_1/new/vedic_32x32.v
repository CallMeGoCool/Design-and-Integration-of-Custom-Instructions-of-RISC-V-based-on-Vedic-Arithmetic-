`timescale 1ns/1ps

module vedic_32x32 (
    input [31:0] a, b,
    output reg [63:0] p
);
    wire [63:0] result;
    wire [31:0] p0, p1, p2, p3;
    wire [63:0] temp1, temp2, temp3;

    vedic_16x16 u0 (a[15:0], b[15:0], p0);
    vedic_16x16 u1 (a[31:16], b[15:0], p1);
    vedic_16x16 u2 (a[15:0], b[31:16], p2);
    vedic_16x16 u3 (a[31:16], b[31:16], p3);

    assign temp1 = {32'b0, p0};  // p0 << 0
    assign temp2 = (({32'b0, p1} + {32'b0, p2}) << 16);  // (p1 + p2) << 16
    assign temp3 = {p3, 32'b0};  // p3 << 32
    assign result = temp1 + temp2 + temp3;

    always @(*) begin
            p = result;

    end
endmodule
