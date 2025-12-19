module rev_full_adder (
    input  wire A,
    input  wire B,
    input  wire Cin,
    output wire Sum,
    output wire Cout,
    output wire G1,    
    output wire G2     
);

    wire M, N, O, P;

    hng_gate h1 (
        .U(A),
        .V(B),
        .W(Cin),      // THIS is Cin (do NOT set this to 0)
        .X(1'b0),     // ancilla = 0   (necessary for FA behavior)
        .M(M),
        .N(N),
        .O(O),
        .P(P)
    );

    assign Sum  = O;
    assign Cout = P;

    assign G1 = M;    
    assign G2 = N;    

endmodule
