module summation_network_4bit (
    input  wire pp00,
    input  wire pp01,
    input  wire pp02,
    input  wire pp03,
    input  wire pp11,
    input  wire pp12,
    input  wire pp13,
    input  wire pp22,
    input  wire pp23,
    input  wire pp33,
    output wire [7:0] Y,
    output wire [31:0] garbage
);

    // --- intermediate carries and sums ---
    wire c0;                // carry from col0 (unused)
    wire c1;                // carry from col1 (pp01+pp01)
    wire s2, c2a, c2b;      // col2 intermediate
    wire s3a, c3a, s3b, c3b, c3c; // col3 intermediates
    wire s4a, c4a, s4b, c4b, c4c; // col4 intermediates
    wire s5a, c5a, c5b;     // col5 intermediates

    // --- garbage wires (unique) ---
    wire g_ha0;      // ha0
    wire g_ha1;      // ha1
    wire g_ha2;      // ha2
    wire g_ha3;      // ha3
    wire g_ha4;      // ha4

    wire g_fa2_1, g_fa2_2;
    wire g_fa3a_1, g_fa3a_2;
    wire g_fa3b_1, g_fa3b_2;
    wire g_fa4a_1, g_fa4a_2;
    wire g_fa4b_1, g_fa4b_2;
    wire g_fa5a_1, g_fa5a_2;
    wire g_fa5b_1, g_fa5b_2;
    wire g_fa6_1, g_fa6_2;

    // -------------------------
    // Column 0 (weight 0): pp00
    // -------------------------
    // Use a reversible half-adder with 0 to keep structure reversible.
    rev_half_adder ha0 (
        .A(pp00),
        .B(1'b0),
        .Sum(Y[0]),
        .Carry(c0),
        .G(g_ha0)
    );

    // -------------------------
    // Column 1 (weight 1): 2*pp01
    // -------------------------
    rev_half_adder ha1 (
        .A(pp01),
        .B(pp01),
        .Sum(Y[1]),
        .Carry(c1),
        .G(g_ha1)
    );

    // -------------------------
    // Column 2 (weight 2): 2*pp02 + pp11 + carry_from_col1
    // fa2: (pp02, pp02, pp11) -> s2, c2a
    // ha2: (s2, c1) -> Y[2], c2b
    // -------------------------
    rev_full_adder fa2 (
        .A(pp02),
        .B(pp02),
        .Cin(pp11),
        .Sum(s2),
        .Cout(c2a),
        .G1(g_fa2_1),
        .G2(g_fa2_2)
    );

    rev_half_adder ha2 (
        .A(s2),
        .B(c1),
        .Sum(Y[2]),
        .Carry(c2b),
        .G(g_ha2)
    );

    // -------------------------
    // Column 3 (weight 3): 2*pp03 + 2*pp12 + carries from col2 (c2a,c2b)
    // fa3a: (pp03, pp03, pp12) -> s3a, c3a
    // fa3b: (pp12, c2a, c2b)   -> s3b, c3b
    // ha3 : (s3a, s3b)         -> Y[3], c3c
    // -------------------------
    rev_full_adder fa3a (
        .A(pp03),
        .B(pp03),
        .Cin(pp12),
        .Sum(s3a),
        .Cout(c3a),
        .G1(g_fa3a_1),
        .G2(g_fa3a_2)
    );

    rev_full_adder fa3b (
        .A(pp12),
        .B(c2a),
        .Cin(c2b),
        .Sum(s3b),
        .Cout(c3b),
        .G1(g_fa3b_1),
        .G2(g_fa3b_2)
    );

    rev_half_adder ha3 (
        .A(s3a),
        .B(s3b),
        .Sum(Y[3]),
        .Carry(c3c),
        .G(g_ha3)
    );

    // -------------------------
    // Column 4 (weight 4): 2*pp13 + pp22 + carries from col3 (c3a,c3b,c3c)
    // fa4a: (pp13, pp13, pp22) -> s4a, c4a
    // fa4b: (c3a, c3b, c3c)    -> s4b, c4b
    // ha4 : (s4a, s4b)         -> Y[4], c4c
    // -------------------------
    rev_full_adder fa4a (
        .A(pp13),
        .B(pp13),
        .Cin(pp22),
        .Sum(s4a),
        .Cout(c4a),
        .G1(g_fa4a_1),
        .G2(g_fa4a_2)
    );

    rev_full_adder fa4b (
        .A(c3a),
        .B(c3b),
        .Cin(c3c),
        .Sum(s4b),
        .Cout(c4b),
        .G1(g_fa4b_1),
        .G2(g_fa4b_2)
    );

    rev_half_adder ha4 (
        .A(s4a),
        .B(s4b),
        .Sum(Y[4]),
        .Carry(c4c),
        .G(g_ha4)
    );

    // -------------------------
    // Column 5 (weight 5): 2*pp23 + carries from col4 (c4a,c4b,c4c)
    // fa5a: (pp23, pp23, c4a) -> s5a, c5a
    // fa5b: (s5a, c4b, c4c)   -> Y[5], c5b
    // -------------------------
    rev_full_adder fa5a (
        .A(pp23),
        .B(pp23),
        .Cin(c4a),
        .Sum(s5a),
        .Cout(c5a),
        .G1(g_fa5a_1),
        .G2(g_fa5a_2)
    );

    rev_full_adder fa5b (
        .A(s5a),
        .B(c4b),
        .Cin(c4c),
        .Sum(Y[5]),
        .Cout(c5b),
        .G1(g_fa5b_1),
        .G2(g_fa5b_2)
    );

    // -------------------------
    // Column 6 (weight 6): pp33 + carries from col5 (c5a, c5b)
    // fa6: (pp33, c5a, c5b) -> Y[6], Y[7] (Cout)
    // -------------------------
    rev_full_adder fa6 (
        .A(pp33),
        .B(c5a),
        .Cin(c5b),
        .Sum(Y[6]),
        .Cout(Y[7]),
        .G1(g_fa6_1),
        .G2(g_fa6_2)
    );

    // --- Pack garbage into 32-bit vector (unused high bits = 0) ---
    // Order chosen LSB-first: G0 is LSB of packed portion, etc.
    // We have 21 garbage wires; place them into [20:0], remaining bits zero.
    assign garbage = {
        11'b0,               // bits [31:21] unused
        g_fa6_2,             // bit 20
        g_fa6_1,             // bit 19
        g_fa5b_2,            // bit 18
        g_fa5b_1,            // bit 17
        g_fa5a_2,            // bit 16
        g_fa5a_1,            // bit 15
        g_ha4,               // bit 14
        g_fa4b_2,            // bit 13
        g_fa4b_1,            // bit 12
        g_fa4a_2,            // bit 11
        g_fa4a_1,            // bit 10
        g_ha3,               // bit 9
        g_fa3b_2,            // bit 8
        g_fa3b_1,            // bit 7
        g_fa3a_2,            // bit 6
        g_fa3a_1,            // bit 5
        g_ha2,               // bit 4
        g_fa2_2,             // bit 3
        g_fa2_1,             // bit 2
        g_ha1,               // bit 1
        g_ha0                // bit 0 (LSB)
    };

endmodule
