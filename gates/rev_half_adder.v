module rev_half_adder (
    input  wire A,
    input  wire B,
    output wire Sum,
    output wire Carry,
    output wire G  
);

    wire M, N, O;   

    peres_gate pg (
        .U(A),
        .V(B),
        .W(1'b0),   
        .M(M),      
        .N(N),      
        .O(O)      
    );

    assign Sum   = N;
    assign Carry = O;
    assign G = M;

endmodule
