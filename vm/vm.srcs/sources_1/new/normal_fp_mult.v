`timescale 1ns / 1ps

module normal_fp_mult (
    input  wire clk,
    input  wire [31:0] a,
    input  wire [31:0] b,
    output reg  [31:0] result
);

    // Extract fields
    wire sign_a = a[31];
    wire sign_b = b[31];
    wire [7:0] exp_a = a[30:23];
    wire [7:0] exp_b = b[30:23];
    wire [23:0] mant_a = {1'b1, a[22:0]};
    wire [23:0] mant_b = {1'b1, b[22:0]};

    wire sign_res = sign_a ^ sign_b;
    wire [47:0] mant_res = mant_a * mant_b;
    wire [7:0] exp_sum = exp_a + exp_b - 8'd127;

    reg [7:0]   final_exp;
    reg [22:0]  final_mant;

    always @(posedge clk) begin
        // Check where the MSB lies and normalize accordingly
        if (mant_res[47]) begin
            final_mant <= mant_res[46:24];        // No shift needed, already normalized
            final_exp  <= exp_sum + 1;            // Exponent incremented
        end
        else begin
            final_mant <= mant_res[45:23];        // Shifted right by 1
            final_exp  <= exp_sum;                // No exponent change
        end

        result <= {sign_res, final_exp, final_mant};
    end

endmodule
