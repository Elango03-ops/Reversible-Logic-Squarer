

module squarer_4bit (
    input  wire [3:0] a,
    output wire [7:0] Y,
    output wire [31:0] garbage_pp,
    output wire [31:0] garbage_sum
);

    // partial products
    wire pp00, pp01, pp02, pp03, pp11, pp12, pp13, pp22, pp23, pp33;
    wire [19:0] garbage_pp_small;

    partial_products_4bit ppgen (
        .a(a),
        .pp00(pp00), .pp01(pp01), .pp02(pp02), .pp03(pp03),
        .pp11(pp11), .pp12(pp12), .pp13(pp13),
        .pp22(pp22), .pp23(pp23), .pp33(pp33),
        .garbage(garbage_pp_small)
    );

    
    assign garbage_pp = {12'b0, garbage_pp_small};

    // summation network
    wire [31:0] garbage_sum_internal;

    summation_network_4bit sumnet (
        .pp00(pp00),
        .pp01(pp01),
        .pp02(pp02),
        .pp03(pp03),
        .pp11(pp11),
        .pp12(pp12),
        .pp13(pp13),
        .pp22(pp22),
        .pp23(pp23),
        .pp33(pp33),
        .Y(Y),
        .garbage(garbage_sum_internal)
    );

    assign garbage_sum = garbage_sum_internal;

endmodule
