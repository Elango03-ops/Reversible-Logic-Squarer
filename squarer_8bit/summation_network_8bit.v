
module summation_network_8bit (
    input wire pp00,
    input wire pp10,
    input wire pp11,
    input wire pp20,
    input wire pp21,
    input wire pp22,
    input wire pp30,
    input wire pp31,
    input wire pp32,
    input wire pp33,
    input wire pp40,
    input wire pp41,
    input wire pp42,
    input wire pp43,
    input wire pp44,
    input wire pp50,
    input wire pp51,
    input wire pp52,
    input wire pp53,
    input wire pp54,
    input wire pp55,
    input wire pp60,
    input wire pp61,
    input wire pp62,
    input wire pp63,
    input wire pp64,
    input wire pp65,
    input wire pp66,
    input wire pp70,
    input wire pp71,
    input wire pp72,
    input wire pp73,
    input wire pp74,
    input wire pp75,
    input wire pp76,
    input wire pp77,
    output wire [15:0] Y,
    output wire [127:0] garbage
);

    // --- Internal Carry/Sum Wires ---
    // --- Column 0 ---
    assign Y[0] = pp00;

    // --- Column 1 ---
    assign Y[1] = 1'b0;

    // --- Column 2 ---
    wire s_2_1, c_2_1, g_ha0;
    rev_half_adder ha0 (.A(pp10), .B(pp11), .Sum(s_2_1), .Carry(c_2_1), .G(g_ha0));
    assign Y[2] = s_2_1;

    // --- Column 3 ---
    wire s_3_1, c_3_1, g_ha1;
    rev_half_adder ha1 (.A(pp20), .B(c_2_1), .Sum(s_3_1), .Carry(c_3_1), .G(g_ha1));
    assign Y[3] = s_3_1;

    // --- Column 4 ---
    wire s_4_1, c_4_1, g_fa2_1, g_fa2_2;
    rev_full_adder fa2 (.A(pp21), .B(pp22), .Cin(pp30), .Sum(s_4_1), .Cout(c_4_1), .G1(g_fa2_1), .G2(g_fa2_2));
    wire s_4_2, c_4_2, g_ha3;
    rev_half_adder ha3 (.A(c_3_1), .B(s_4_1), .Sum(s_4_2), .Carry(c_4_2), .G(g_ha3));
    assign Y[4] = s_4_2;

    // --- Column 5 ---
    wire s_5_1, c_5_1, g_fa4_1, g_fa4_2;
    rev_full_adder fa4 (.A(pp31), .B(pp40), .Cin(c_4_1), .Sum(s_5_1), .Cout(c_5_1), .G1(g_fa4_1), .G2(g_fa4_2));
    wire s_5_2, c_5_2, g_ha5;
    rev_half_adder ha5 (.A(c_4_2), .B(s_5_1), .Sum(s_5_2), .Carry(c_5_2), .G(g_ha5));
    assign Y[5] = s_5_2;

    // --- Column 6 ---
    wire s_6_1, c_6_1, g_fa6_1, g_fa6_2;
    rev_full_adder fa6 (.A(pp32), .B(pp33), .Cin(pp41), .Sum(s_6_1), .Cout(c_6_1), .G1(g_fa6_1), .G2(g_fa6_2));
    wire s_6_2, c_6_2, g_fa7_1, g_fa7_2;
    rev_full_adder fa7 (.A(pp50), .B(c_5_1), .Cin(c_5_2), .Sum(s_6_2), .Cout(c_6_2), .G1(g_fa7_1), .G2(g_fa7_2));
    wire s_6_3, c_6_3, g_ha8;
    rev_half_adder ha8 (.A(s_6_1), .B(s_6_2), .Sum(s_6_3), .Carry(c_6_3), .G(g_ha8));
    assign Y[6] = s_6_3;

    // --- Column 7 ---
    wire s_7_1, c_7_1, g_fa9_1, g_fa9_2;
    rev_full_adder fa9 (.A(pp42), .B(pp51), .Cin(pp60), .Sum(s_7_1), .Cout(c_7_1), .G1(g_fa9_1), .G2(g_fa9_2));
    wire s_7_2, c_7_2, g_fa10_1, g_fa10_2;
    rev_full_adder fa10 (.A(c_6_1), .B(c_6_2), .Cin(c_6_3), .Sum(s_7_2), .Cout(c_7_2), .G1(g_fa10_1), .G2(g_fa10_2));
    wire s_7_3, c_7_3, g_ha11;
    rev_half_adder ha11 (.A(s_7_1), .B(s_7_2), .Sum(s_7_3), .Carry(c_7_3), .G(g_ha11));
    assign Y[7] = s_7_3;

    // --- Column 8 ---
    wire s_8_1, c_8_1, g_fa12_1, g_fa12_2;
    rev_full_adder fa12 (.A(pp43), .B(pp44), .Cin(pp52), .Sum(s_8_1), .Cout(c_8_1), .G1(g_fa12_1), .G2(g_fa12_2));
    wire s_8_2, c_8_2, g_fa13_1, g_fa13_2;
    rev_full_adder fa13 (.A(pp61), .B(pp70), .Cin(c_7_1), .Sum(s_8_2), .Cout(c_8_2), .G1(g_fa13_1), .G2(g_fa13_2));
    wire s_8_3, c_8_3, g_fa14_1, g_fa14_2;
    rev_full_adder fa14 (.A(c_7_2), .B(c_7_3), .Cin(s_8_1), .Sum(s_8_3), .Cout(c_8_3), .G1(g_fa14_1), .G2(g_fa14_2));
    wire s_8_4, c_8_4, g_ha15;
    rev_half_adder ha15 (.A(s_8_2), .B(s_8_3), .Sum(s_8_4), .Carry(c_8_4), .G(g_ha15));
    assign Y[8] = s_8_4;

    // --- Column 9 ---
    wire s_9_1, c_9_1, g_fa16_1, g_fa16_2;
    rev_full_adder fa16 (.A(pp53), .B(pp62), .Cin(pp71), .Sum(s_9_1), .Cout(c_9_1), .G1(g_fa16_1), .G2(g_fa16_2));
    wire s_9_2, c_9_2, g_fa17_1, g_fa17_2;
    rev_full_adder fa17 (.A(c_8_1), .B(c_8_2), .Cin(c_8_3), .Sum(s_9_2), .Cout(c_9_2), .G1(g_fa17_1), .G2(g_fa17_2));
    wire s_9_3, c_9_3, g_fa18_1, g_fa18_2;
    rev_full_adder fa18 (.A(c_8_4), .B(s_9_1), .Cin(s_9_2), .Sum(s_9_3), .Cout(c_9_3), .G1(g_fa18_1), .G2(g_fa18_2));
    assign Y[9] = s_9_3;

    // --- Column 10 ---
    wire s_10_1, c_10_1, g_fa19_1, g_fa19_2;
    rev_full_adder fa19 (.A(pp54), .B(pp55), .Cin(pp63), .Sum(s_10_1), .Cout(c_10_1), .G1(g_fa19_1), .G2(g_fa19_2));
    wire s_10_2, c_10_2, g_fa20_1, g_fa20_2;
    rev_full_adder fa20 (.A(pp72), .B(c_9_1), .Cin(c_9_2), .Sum(s_10_2), .Cout(c_10_2), .G1(g_fa20_1), .G2(g_fa20_2));
    wire s_10_3, c_10_3, g_fa21_1, g_fa21_2;
    rev_full_adder fa21 (.A(c_9_3), .B(s_10_1), .Cin(s_10_2), .Sum(s_10_3), .Cout(c_10_3), .G1(g_fa21_1), .G2(g_fa21_2));
    assign Y[10] = s_10_3;

    // --- Column 11 ---
    wire s_11_1, c_11_1, g_fa22_1, g_fa22_2;
    rev_full_adder fa22 (.A(pp64), .B(pp73), .Cin(c_10_1), .Sum(s_11_1), .Cout(c_11_1), .G1(g_fa22_1), .G2(g_fa22_2));
    wire s_11_2, c_11_2, g_fa23_1, g_fa23_2;
    rev_full_adder fa23 (.A(c_10_2), .B(c_10_3), .Cin(s_11_1), .Sum(s_11_2), .Cout(c_11_2), .G1(g_fa23_1), .G2(g_fa23_2));
    assign Y[11] = s_11_2;

    // --- Column 12 ---
    wire s_12_1, c_12_1, g_fa24_1, g_fa24_2;
    rev_full_adder fa24 (.A(pp65), .B(pp66), .Cin(pp74), .Sum(s_12_1), .Cout(c_12_1), .G1(g_fa24_1), .G2(g_fa24_2));
    wire s_12_2, c_12_2, g_fa25_1, g_fa25_2;
    rev_full_adder fa25 (.A(c_11_1), .B(c_11_2), .Cin(s_12_1), .Sum(s_12_2), .Cout(c_12_2), .G1(g_fa25_1), .G2(g_fa25_2));
    assign Y[12] = s_12_2;

    // --- Column 13 ---
    wire s_13_1, c_13_1, g_fa26_1, g_fa26_2;
    rev_full_adder fa26 (.A(pp75), .B(c_12_1), .Cin(c_12_2), .Sum(s_13_1), .Cout(c_13_1), .G1(g_fa26_1), .G2(g_fa26_2));
    assign Y[13] = s_13_1;

    // --- Column 14 ---
    wire s_14_1, c_14_1, g_fa27_1, g_fa27_2;
    rev_full_adder fa27 (.A(pp76), .B(pp77), .Cin(c_13_1), .Sum(s_14_1), .Cout(c_14_1), .G1(g_fa27_1), .G2(g_fa27_2));
    assign Y[14] = s_14_1;

    // --- Column 15 ---
    assign Y[15] = c_14_1;

    // Total Summation Garbage Wires: 49
    assign garbage = {79'b0, g_fa27_1, g_fa27_2, g_fa26_1, g_fa26_2, g_fa25_1, g_fa25_2, g_fa24_1, g_fa24_2, g_fa23_1, g_fa23_2, g_fa22_1, g_fa22_2, g_fa21_1, g_fa21_2, g_fa20_1, g_fa20_2, g_fa19_1, g_fa19_2, g_fa18_1, g_fa18_2, g_fa17_1, g_fa17_2, g_fa16_1, g_fa16_2, g_ha15, g_fa14_1, g_fa14_2, g_fa13_1, g_fa13_2, g_fa12_1, g_fa12_2, g_ha11, g_fa10_1, g_fa10_2, g_fa9_1, g_fa9_2, g_ha8, g_fa7_1, g_fa7_2, g_fa6_1, g_fa6_2, g_ha5, g_fa4_1, g_fa4_2, g_ha3, g_fa2_1, g_fa2_2, g_ha1, g_ha0};
endmodule
