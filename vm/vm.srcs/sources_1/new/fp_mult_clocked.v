`timescale 1ns/1ps

module fp_mult_clocked (
    input  wire        clk,
    input  wire [31:0] a,
    input  wire [31:0] b,
    output reg  [31:0] p
);

    wire [31:0] p_comb;

    // Instantiate the combinational FP multiplier
    fp_mult comb_fp_mult (
        .a(a),
        .b(b),
        .p(p_comb)
    );

    // Register the result on the clock edge
    always @(posedge clk) begin
        p <= p_comb;
    end

endmodule
