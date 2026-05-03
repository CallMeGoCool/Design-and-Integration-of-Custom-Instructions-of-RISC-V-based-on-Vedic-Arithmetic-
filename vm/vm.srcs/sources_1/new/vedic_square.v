module vedic_square(
    input  wire        clk,
    input  wire [31:0] a,
    output reg  [63:0] p
);

    wire [63:0] p1;

    vedic_32x32 u1 (.a(a), .b(a), .p(p1));  // Square = a × a

    always @(posedge clk) begin
        p <= p1;
    end
endmodule
