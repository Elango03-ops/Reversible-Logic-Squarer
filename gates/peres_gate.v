`timescale 1ns / 1ps


module peres_gate (
    input  wire U,
    input  wire V,
    input  wire W,
    output wire M,
    output wire N,
    output wire O
);
    assign M = U;
    assign N = U ^ V;
    assign O = (U & V) ^ W;
endmodule
