`timescale 1ns / 1ps

module normal_32x32 (
    input  wire clk,
    input  wire [31:0] a,
    input  wire [31:0] b,
    output reg  [63:0] product
);
    always @(posedge clk) begin
        product <= a * b;
    end
endmodule


