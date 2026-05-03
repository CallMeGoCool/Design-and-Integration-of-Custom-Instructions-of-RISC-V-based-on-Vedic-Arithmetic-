module vedic_cube(
    input  wire        clk,
    input  wire [31:0] a,
    output reg  [63:0] p
);

    wire [63:0] temp1, temp2;

    // First: a × a = temp1
    // Then: a × temp1 (lower 32 bits) = temp2
    vedic_32x32 u1 (
        .a(a),
        .b(a),
        .p(temp1)
    );

    vedic_32x32 u2 (
        .a(a),
        .b(temp1[31:0]),
        .p(temp2)
    );

    always @(posedge clk) begin
        p <= temp2;
    end
endmodule
