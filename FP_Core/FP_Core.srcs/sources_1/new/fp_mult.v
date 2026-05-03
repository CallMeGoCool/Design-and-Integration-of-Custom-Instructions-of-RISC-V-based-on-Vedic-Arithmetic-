module fp_mult (
    input  [31:0] a,
    input  [31:0] b,
    output [31:0] p
);
    // Extract fields
    wire sign_a = a[31];
    wire sign_b = b[31];
    wire [7:0] exp_a = a[30:23];
    wire [7:0] exp_b = b[30:23];
    wire [23:0] mantissa_a = {1'b1, a[22:0]};  // Implicit leading 1
    wire [23:0] mantissa_b = {1'b1, b[22:0]};

    // Multiply mantissas: 24x24 => 48-bit result
    wire [47:0] mantissa_product;
    vedic_24x24 mult_inst (
        .a(mantissa_a),
        .b(mantissa_b),
        .p(mantissa_product)
    );

    // Compute raw exponent
    wire [8:0] exp_raw = exp_a + exp_b - 8'd127;

    // Compute result sign
    wire sign_result = sign_a ^ sign_b;

    // Normalization logic
    reg [22:0] mantissa_norm;
    reg [8:0] exp_norm;

    integer i;
    reg found_one;

    always @(*) begin
        if (mantissa_product[47] == 1'b1) begin
            // Already normalized
            mantissa_norm = mantissa_product[46:24];
            exp_norm = exp_raw + 1;
        end else begin
            // Search for first '1' bit from bit 46 down to 23
            found_one = 0;
            exp_norm = exp_raw;
            mantissa_norm = 0;

            for (i = 46; i >= 23; i = i - 1) begin
                if (!found_one && mantissa_product[i] == 1'b1) begin
                    found_one = 1;
                    exp_norm = exp_raw - (46 - i);
                    mantissa_norm = mantissa_product[i-1 -: 23];
                end
            end

            // If no '1' found (product zero), then mantissa_norm stays 0 and exponent is 0
            if (!found_one) begin
                mantissa_norm = 0;
                exp_norm = 0;
            end
        end
    end

    // Pack final result
    assign p = {sign_result, exp_norm[7:0], mantissa_norm};

endmodule
