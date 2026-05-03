module vedic_32x32_clocked (
    input  wire        clk,
    input  wire [31:0] a,
    input  wire [31:0] b,
    output reg  [63:0] p
);

    wire [63:0] p_comb;

    vedic_32x32 u (
        .a(a),
        .b(b),
        .p(p_comb)
    );

    always @(posedge clk) begin
        p <= p_comb;
    end
endmodule
